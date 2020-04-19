-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 17, 2020 at 04:18 PM
-- Server version: 5.7.29-0ubuntu0.18.04.1
-- PHP Version: 7.2.24-0ubuntu0.18.04.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Booksora`
--
CREATE DATABASE IF NOT EXISTS `Booksora` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `Booksora`;

-- --------------------------------------------------------

--
-- Table structure for table `chiBooklist`
--

CREATE TABLE IF NOT EXISTS `chiBooklist` (
  `Bookid` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Author` varchar(255) DEFAULT NULL,
  `Publisher` varchar(255) DEFAULT NULL,
  `ISBN` varchar(20) DEFAULT NULL,
  `Description` varchar(255) NOT NULL,
  `Price` int(11) DEFAULT NULL,
  PRIMARY KEY (`Bookid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `chiBooklist`:
--

--
-- Dumping data for table `chiBooklist`
--

INSERT INTO `chiBooklist` (`Bookid`, `Name`, `Author`, `Publisher`, `ISBN`, `Description`, `Price`) VALUES
(1, 'The Mandela Experiment in Time', 'Tin Hong', 'Tin Hong Publisher', '978-988-13670-4-4', 'There are 2 countries remain after the WW III: the Albikini United Nations and the republic of great east Eurasia. The population of the world decreased rapidly to 400 million. Human are heading towards extinct. A story about 7 people starts.', 68),
(2, 'Maya the Diviner', 'Tin Hong', 'Tin Hong Publisher', '978-98816360-0-3', '\"at midnight twelve...pyramid of the sun...met the holy people\" Diviners are a group of people who use prophecy and truth to lead people who\"walk on an incorrect route\" back to the right track.', 68),
(3, 'The Last Will of Emperor Qin', 'Tin Hong', 'Tin Hong Publisher', '978-988-16360-9-6', '\"Do you know the reason to make a total of 8 thousand terracotta army? I know the truth.\" 2000 years have passes and the truth finally came to light.', 58),
(4, 'The Kensei\'s Calligraphy', 'Tin Hong', 'Tin Hong Publisher', '978-988-17815-5-0', 'According to the unofficial count, one life only worth for 2 hundred thosand. Hire a killer to kill a person only costs 50 thousand.He is the top killer on list and also the most elegant demon.Find the meaning of two historical words as to survive. ', 58),
(5, 'The Sarira\'s Smile', 'Tin Hong', 'Tin Hong Publisher', '978-988-17815-7-4', 'This is a story start with \"smile\".\"I wanna be a bad guy which helps a good guy\"', 58),
(6, 'Sixty-Four Codons', 'Tin Hong', 'Tin Hong Publisher', '978-988-17815-6-7', 'a poor boy met his teacher and learn mathemathics', 55);

-- --------------------------------------------------------

--
-- Table structure for table `dcomment`
--

CREATE TABLE IF NOT EXISTS `dcomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` varchar(200) NOT NULL,
  `authorid` int(11) NOT NULL,
  `cname` varchar(20) NOT NULL,
  `forumid` int(11) NOT NULL,
  `posttime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `authorid` (`authorid`),
  KEY `forumid` (`forumid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `dcomment`:
--   `authorid`
--       `LoginSystem` -> `id`
--   `forumid`
--       `dforum` -> `id`
--

--
-- Dumping data for table `dcomment`
--

INSERT INTO `dcomment` (`id`, `comment`, `authorid`, `cname`, `forumid`, `posttime`) VALUES
(1, 'agree<3', 2, 'vic', 3, '2020-04-10 22:35:58'),
(2, 'wow~', 2, 'vic', 3, '2020-04-10 23:26:50'),
(3, 'this is a comment\'', 2, 'vic', 2, '2020-04-10 23:27:19'),
(4, 'test.comment......', 2, 'vic', 1, '2020-04-10 23:27:35'),
(5, 'recommed', 1, 'test', 3, '2020-04-14 16:29:02');

-- --------------------------------------------------------

--
-- Table structure for table `dforum`
--

CREATE TABLE IF NOT EXISTS `dforum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `dcontent` varchar(300) NOT NULL,
  `createtime` datetime DEFAULT NULL,
  `authorid` int(11) NOT NULL,
  `authorname` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `authorid` (`authorid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- RELATIONS FOR TABLE `dforum`:
--   `authorid`
--       `LoginSystem` -> `id`
--

--
-- Dumping data for table `dforum`
--

INSERT INTO `dforum` (`id`, `title`, `dcontent`, `createtime`, `authorid`, `authorname`) VALUES
(1, 'test', 'test', '2020-04-09 15:09:43', 1, 'test'),
(2, 'this is a title', 'this is the content', '2020-04-10 19:48:19', 2, 'vic'),
(3, 'Recommend!!!!!Must not miss this book', 'Title: The book\r\nReason: Very good recommend everyone to have a look of it', '2020-04-10 19:50:12', 2, 'vic');

-- --------------------------------------------------------

--
-- Table structure for table `enBooklist`
--

CREATE TABLE IF NOT EXISTS `enBooklist` (
  `Bookid` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Author` varchar(255) NOT NULL,
  `Publisher` varchar(255) NOT NULL,
  `ISBN` varchar(255) NOT NULL,
  `Description` varchar(1000) NOT NULL,
  `Price` int(11) NOT NULL,
  PRIMARY KEY (`Bookid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `enBooklist`:
--

--
-- Dumping data for table `enBooklist`
--

INSERT INTO `enBooklist` (`Bookid`, `Name`, `Author`, `Publisher`, `ISBN`, `Description`, `Price`) VALUES
(1, 'Test', 'Test', 'Test', 'Test', 'Test', 89),
(2, 'The Island', 'Victoria Hislop', 'Headline Publishing Group', '978-0-7553-0950-4', 'nominator of book of the year 2007', 90),
(3, 'The Thread', 'Victoria Hislop', 'Harper Collins', '9780062135599', 'a story of friendship and love', 88);

-- --------------------------------------------------------

--
-- Table structure for table `jpBooklist`
--

CREATE TABLE IF NOT EXISTS `jpBooklist` (
  `Bookid` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Author` varchar(255) DEFAULT NULL,
  `Publisher` varchar(255) DEFAULT NULL,
  `ISBN` varchar(20) DEFAULT NULL,
  `Description` varchar(1000) NOT NULL,
  `Price` int(11) DEFAULT NULL,
  PRIMARY KEY (`Bookid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `jpBooklist`:
--

--
-- Dumping data for table `jpBooklist`
--

INSERT INTO `jpBooklist` (`Bookid`, `Name`, `Author`, `Publisher`, `ISBN`, `Description`, `Price`) VALUES
(1, 'Hello World ', 'Mado Nozaki', 'Shueisha Inc', '978-4-08-631329-2', '\"this story, will restart at the last second\"', 77),
(2, 'Masqurade Hotel', 'Keigo Higashino', 'Shueisha Inc', '978-4-08-771414-2', 'a story about a murder case', 85),
(3, 'Children who Chase lost voices from deep below', 'Makoto Shinkai', 'Kadokawa Corp', '978-4-04-102631-1', 'A journey learn to say \"goodbye\" ', 78);

-- --------------------------------------------------------

--
-- Table structure for table `LoginSystem`
--

CREATE TABLE IF NOT EXISTS `LoginSystem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `LoginSystem`:
--

--
-- Dumping data for table `LoginSystem`
--

INSERT INTO `LoginSystem` (`id`, `username`, `password`, `email`) VALUES
(1, 'test', 'test', ''),
(2, 'vic', 'vic', 'vic@gg.com'),
(3, 'vicvv', 'vvvvvvvv', 'vv@vvvv.com');

-- --------------------------------------------------------

--
-- Table structure for table `Orderdetails`
--

CREATE TABLE IF NOT EXISTS `Orderdetails` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `deliver` varchar(20) NOT NULL,
  `convno` int(11) DEFAULT NULL,
  `address` varchar(1000) DEFAULT NULL,
  `pm` varchar(20) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `Orderdetails`:
--   `userid`
--       `LoginSystem` -> `id`
--

--
-- Dumping data for table `Orderdetails`
--

INSERT INTO `Orderdetails` (`ID`, `userid`, `deliver`, `convno`, `address`, `pm`) VALUES
(1, 1, 'Home', 0, 'address', 'Credit Card'),
(2, 2, 'Home', 0, '/', 'Credit Card');

-- --------------------------------------------------------

--
-- Table structure for table `Orders`
--

CREATE TABLE IF NOT EXISTS `Orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book` varchar(100) NOT NULL,
  `quantity` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- RELATIONS FOR TABLE `Orders`:
--   `userid`
--       `LoginSystem` -> `id`
--

--
-- Dumping data for table `Orders`
--

INSERT INTO `Orders` (`id`, `book`, `quantity`, `userid`) VALUES
(1, '(\'The Mandela Experiment in Time\',)', 1, 1),
(7, '(\'Masqurade Hotel\',)', 3, 1),
(8, '(\'The Mandela Experiment in Time\',)', 1, 2);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dcomment`
--
ALTER TABLE `dcomment`
  ADD CONSTRAINT `dcomment_ibfk_1` FOREIGN KEY (`authorid`) REFERENCES `LoginSystem` (`id`),
  ADD CONSTRAINT `dcomment_ibfk_2` FOREIGN KEY (`forumid`) REFERENCES `dforum` (`id`);

--
-- Constraints for table `dforum`
--
ALTER TABLE `dforum`
  ADD CONSTRAINT `dforum_ibfk_1` FOREIGN KEY (`authorid`) REFERENCES `LoginSystem` (`id`);

--
-- Constraints for table `Orderdetails`
--
ALTER TABLE `Orderdetails`
  ADD CONSTRAINT `Orderdetails_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `LoginSystem` (`id`);

--
-- Constraints for table `Orders`
--
ALTER TABLE `Orders`
  ADD CONSTRAINT `Orders_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `LoginSystem` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
