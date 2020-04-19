from flask import Flask,render_template,request,request,redirect,url_for,session
import mysql.connector
import pandas as pd
from datetime import datetime
#build flask
app=Flask(__name__)
# make up scret key
app.secret_key="secretkkey"
#connect mysql database
mysql=mysql.connector.connect(
    host='localhost',
    user="twnv",
    password="password",
    database="Booksora"
)

#content of /localhost/
#index
@app.route('/')
def index():
    return render_template('index.html')

#content of /localhost/home
#home
@app.route('/home')
def home():
    return render_template('home.html')

#content of /localhost/about
#about page
@app.route('/about')
def about():
    return render_template('about.html')

#content of /localhost/shop
#shop
@app.route('/shop',methods=['GET','POST'])
def shop():
    #for logged in users only
    if 'loggedin' not in session:
        session["url"]=url_for('shop')
        return redirect(url_for('login'))
    else:
        #connecting database and retrieve book names
        userid = session['id']
        cursor=mysql.cursor()
        cursor.execute('SELECT Name FROM chiBooklist')
        chibook=cursor.fetchall()
        cursor.execute('SELECT Name FROM enBooklist')
        engbook=cursor.fetchall()
        cursor.execute('SELECT Name FROM jpBooklist') 
        jpbook=cursor.fetchall()
        #retrieve submitted orders of user
        cursor.execute('SELECT id,book,quantity FROM Orders WHERE userid=%s',(userid,))
        preview=cursor.fetchall()       
    return render_template('shop.html',engbook=engbook,chibook=chibook,jpbook=jpbook,preview=preview)
#content of /localhost/preview/
#route use to save orders of users
@app.route('/preview/',methods=['POST'])
def shoplist():
    #make sure user logged in
    if 'loggedin' not in session:
        session["url"]=url_for('shop')
        return redirect(url_for('login'))
    else:
        #save the content of the html form into database
        if request.method == 'POST' and 'books' in request.form:
            book = request.form['books']
            quantity = request.form['quantity']
            userid = session['id']
            cursor = mysql.cursor(dictionary=True)
            cursor.execute('INSERT INTO Orders VALUES (NULL, %s, %s, %s)', (book, quantity, userid,))
            mysql.commit()

    return redirect(url_for('shop'))
#content of /localhost/delete
#route use to delete unwanted orders
@app.route('/delete/',methods=['POST'])
def delete():
    #make sure user logged in
    if 'loggedin' not in session:
        session["url"]=url_for('shop')
        return redirect(url_for('login'))
    else:
        #select content in database accroding to users input and delete records
        if request.method == 'POST' and 'orderid' in request.form:
            orderid = request.form['orderid']
            userid = session['id']
            cursor = mysql.cursor(dictionary=True)
            cursor.execute('DELETE FROM `Orders` WHERE `Orders`.`id` = %s ',(orderid,))
    return redirect(url_for('shop'))

#content of /localhost/shop/info
#for more details of customer
@app.route('/shop/info',methods=['GET','POST'])    
def info():
    #make sure user logged in
    if 'loggedin' not in session:
        session["url"]=url_for('shop')
        return redirect(url_for('login'))
    else:
        #save user details for delivery of books
        if request.method == 'POST' and 'location' in request.form:
            deliver = request.form['location']
            convno = request.form['connum']
            address = request.form['address']
            pm = request.form['payment']
            userid = session['id']
            cursor = mysql.cursor(dictionary=True)
            cursor.execute('INSERT INTO Orderdetails VALUES (NULL, %s, %s, %s, %s, %s)', (userid, deliver, convno, address, pm))
            mysql.commit()
            msg='submitted'
            return render_template('shopinfo.html',msg=msg)
    return render_template('shopinfo.html')

#content of /localhost/logout
#logout session
@app.route('/logout')
def logout():
    #erase logged in dession item
   session.pop('loggedin', None)
   session.pop('id', None)
   session.pop('username', None)
   
   return redirect(url_for('index'))

#content of /localhost/login
#login session
@app.route('/login',methods=['GET','POST'])
def login():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        username = request.form['username']
        password = request.form['password']
        #find account
        cursor = mysql.cursor(dictionary=True)
        cursor.execute('SELECT * FROM LoginSystem WHERE username = %s AND password = %s', (username, password,))
        account = cursor.fetchone()
        # if exist
        if account:
            session['loggedin'] = True
            session['id'] = account['id']
            session['username'] = account['username']
            return redirect(session['url'])
        else:
            #if not exist
            msg = 'Incorrect username/password!'
    return render_template('log.html',msg=msg)

#content of /localhost/registration
#sign up session
@app.route('/registration', methods=['GET', 'POST'])
def reg():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form and 'email' in request.form:
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']
        # make sure account not repeated
        cursor = mysql.cursor(dictionary=True)
        cursor.execute('SELECT * FROM LoginSystem WHERE username = %s', (username,))
        account = cursor.fetchone()
        # If exists
        if account:
            msg = 'Account exists!'
        elif not username or not password or not email:
            #if form empty
            msg = 'Fill the form!'
        else:
            #insert data into database
            cursor=mysql.cursor(dictionary=True)
            cursor.execute('INSERT INTO LoginSystem VALUES (NULL, %s, %s, %s)', (username, password, email,))
            mysql.commit()
    elif request.method == 'POST':
        msg = 'Fill the form!'
    return render_template('registration.html', msg=msg)

#content of /localhost/post
#posting a message in discussion forum
@app.route('/post',methods=['GET','POST'])
def post():
    # Check if user is loggedin
    if 'loggedin' not in session:
        session["url"]=url_for('post')
        return redirect(url_for('login'))
    else:
        #insert html form data into database
        if request.method == 'POST' and 'title' in request.form and 'dcontent' in request.form:
            title = request.form['title']
            dcontent = request.form['dcontent']
            createtime = datetime.now()
            authorid = session['id']
            authorname= session['username'] 
            cursor = mysql.cursor(dictionary=True)
            cursor.execute('INSERT INTO dforum VALUES (NULL, %s, %s, %s, %s, %s)', (title, dcontent, createtime,authorid,authorname,))
            mysql.commit()
            
        return render_template('post.html', username=session['username'])

#content of /localhost/forum
#forum
@app.route('/forum')
def forum():
    #make sure user logged in
    if 'loggedin' not in session:
        session['url']=url_for('forum')
        return redirect(url_for('login'))
    else:
        #retrieve messages post by users
        cursor=mysql.cursor()
        cursor.execute('SELECT * FROM dforum')
        records=cursor.fetchall()
    return render_template('forum.html',output=records)

# content of /localhost/forum/<forumid>/
#detai; of one message
@app.route('/forum/<forum_id>/') 
def detail(forum_id):
    #make sure user loggid in
    if 'loggedin' not in session:
        session['url']=url_for('detail')
        return redirect(url_for('login'))
    else:
        #retrieve message
        cursor=mysql.cursor()
        id=forum_id
        cursor.execute('SELECT * FROM dforum WHERE id= %s',(id,))
        records=cursor.fetchone()
        #retrieve comments of message
        cursor.execute('SELECT * FROM dcomment WHERE forumid=%s',(id,))
        comment=cursor.fetchall()
        return render_template('forumdetail.html',output=records,comment=comment)

#content of /localhost/comment/
#route for user to leave comment
@app.route('/comment/',methods=['POST'])
def comment():
    #make sure user logged in
    if 'loggedin' not in session:
        session['url']=url_for('detail')
        return redirect(url_for('login'))
    else:
        #save html form content into database
           if request.method == 'POST' and 'comment'in request.form:
                comment = request.form['comment']
                authorid = session['id']
                cname= session['username']
                posttime = datetime.now()
                forumid= request.form['forumid']
                cursor = mysql.cursor(dictionary=True)
                cursor.execute('INSERT INTO dcomment VALUES (NULL, %s, %s, %s, %s, %s)', (comment, authorid, cname, forumid, posttime,))
                mysql.commit()
                return redirect(url_for('detail',forum_id=forumid))

#content of /localhost/bookshelf/
#homepage of booklist
@app.route('/bookshelf')
def bookshelf():
    return render_template('bookhome.html')
#content of /localhost/chibooklist/bookdetails
#details of one book in chiBooklist database
@app.route('/chibooklist/bookdetails',methods=['POST'])
def chibookdetail():
    #retrieve records in booklist and post it to html
    if request.method =='POST' and 'bookid' in request.form:
        bookid = request.form['bookid']
        cursor=mysql.cursor(dictionary=True)
        cursor.execute('SELECT * FROM chiBooklist WHERE Bookid= %s',(bookid,))
        output = cursor.fetchone()
        return render_template('bookdetails.html',output=output)

#content of /localhost/enbooklist/bookdetails/
#details of one book in enBooklist database
@app.route('/enbooklist/bookdetails',methods=['POST'])
def enbookdetail():
    if request.method =='POST' and 'bookid' in request.form:
        bookid = request.form['bookid']
        cursor=mysql.cursor(dictionary=True)
        cursor.execute('SELECT * FROM enBooklist WHERE Bookid= %s',(bookid,))
        output = cursor.fetchone()
        return render_template('bookdetails.html',output=output)

#content of /localhost/jpbooklist/bookdetails/
#details of one book in jpBooklist database
@app.route('/jpbooklist/bookdetails',methods=['POST'])
def jpbookdetail():
    if request.method =='POST' and 'bookid' in request.form:
        bookid = request.form['bookid']
        cursor=mysql.cursor(dictionary=True)
        cursor.execute('SELECT * FROM jpBooklist WHERE Bookid= %s',(bookid,))
        output = cursor.fetchone()
        return render_template('bookdetails.html',output=output)
#content of /localhost/enbooklist
#english booklist
@app.route('/enbooklist')
def getENbooks():
    #retrieve data from database and make it as a table by pandas
    db_cursor=mysql.cursor(dictionary=True)
    sql="SELECT * FROM enBooklist"
    db_cursor.execute(sql)
    output = db_cursor.fetchall()
    return render_template(
        "enbooktemp.html",
        enbookdata=pd.DataFrame(output,columns=['Bookid','Name','Author','Publisher']).to_html(classes='table table-striped table-hover',index=False)
    )

#content of /localhost/chibooklist
#Chinese booklist  
@app.route('/chibooklist',methods=['GET','POST'])
def getCHbooks():
    #retrieve data from database and make it as a table by pandas
    db_cursor=mysql.cursor(dictionary=True)
    sql="SELECT * FROM chiBooklist"
    db_cursor.execute(sql)
    output = db_cursor.fetchall()
    return render_template(
        "chibooktemp.html",
        chbookdata=pd.DataFrame(output,columns=['Bookid','Name','Author','Publisher']).to_html(classes='table table-striped table-hover',index=False)
    )

#content of /localhost/jpbooklist
#Japanese booklist  
@app.route('/jpbooklist')
def getJPbooks():
    #retrieve data from database and make it as a table by pandas
    db_cursor=mysql.cursor(dictionary=True)
    sql="SELECT * FROM jpBooklist"
    db_cursor.execute(sql)
    output = db_cursor.fetchall()
    return render_template(
        "jpbooktemp.html",
        jpbookdata=pd.DataFrame(output,columns=['Bookid','Name','Author','Publisher']).to_html(classes='table table-striped table-hover',index=False)
    )

if __name__=='__main__':
    app.run(debug=True)
