DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `vacancys`;
DROP TABLE IF EXISTS `job_requests`;
DROP TABLE IF EXISTS `user_roles`;

CREATE TABLE IF NOT EXISTS `users` (
  `USER_ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `LOGIN` VARCHAR(100) NOT NULL,
  `PASSWORD` VARCHAR(100) NOT NULL,
  `NAME` VARCHAR(100) NOT NULL,
  `ABOUT` VARCHAR(300),
  `ENABLED` BOOLEAN,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `vacancys` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `USER_ID` INT(10) UNSIGNED NOT NULL,
  `PAYMENT` VARCHAR(100),
  `TITLE` VARCHAR(255) NOT NULL,
  `DESCRIPTION` VARCHAR(3000) NOT NULL,
  `DATE_ADDED` DATETIME NOT NULL,
  `VACANCY_STATUS` BOOLEAN,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `job_requests` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `VACANCY_ID` INT(10) UNSIGNED NOT NULL,
  `USER_ID` INT(10) UNSIGNED NOT NULL,
  `COMMENT` VARCHAR(300),
  `DATE_ADDED` DATETIME NOT NULL,
  `REQUEST_STATUS` BOOLEAN,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `user_roles` (
  `USER_ROLE_ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `USER_ID` INT(10) UNSIGNED NOT NULL,
  `ROLE` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`USER_ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


INSERT INTO `users` (`USER_ID`, `LOGIN`, `PASSWORD`, `NAME`, `ABOUT` , `ENABLED`) VALUES
(1, 'ar1', '123', 'Serj', 'I am admin! I am GOD!', 1),
(2, 'pinkman', 'pass', 'Jessi Jackson', 'Lets cook!', 1),
(3, 'walter', 'pass', 'Walter W.', 'Jessy where is you?', 1),
(4, 'jenny', 'pass', 'Jennifer', 'Ololo', 1);


INSERT INTO `vacancys` (`ID` , `USER_ID` , `PAYMENT` , `TITLE` , `DESCRIPTION`, `DATE_ADDED` , `VACANCY_STATUS` ) VALUES
(1, 2, '$$$', 'Find new partner', 'I hate my old boss. If someone wanna new illegal job. Give me a sign!' , '2015-04-05 11:33:03', 0),
(2, 3, '$10 000', 'Need someone who know big markets', 'We small company what try to get new partners in global markets. Blablabla Blablabla Blablabla Need more text!! Blablabla Blablabla Blablabla' , '2015-04-06 12:00:01', 1),
(3, 3, NULL, 'Need professional killer', 'Need to kill one person. I will pay really big money for that!' , '2015-04-26 02:33:37', 0);

INSERT INTO `job_requests` ( `ID` , `VACANCY_ID` , `USER_ID` , `COMMENT` , `DATE_ADDED` , `REQUEST_STATUS` ) VALUES 
(1, 1, 3, 'Jessy! Why are you doing that?! I am best partner for you! And I did not kill your girlfriend! Trust me!!!', '2015-04-05 21:00:09', 0);

INSERT INTO `user_roles` (`USER_ROLE_ID`, `USER_ID`, `ROLE` ) VALUES 
(1 , 1, 'ROLE_ADMIN'),
(2 , 2, 'ROLE_USER'),
(3 , 3, 'ROLE_USER'),
(4 , 4, 'ROLE_USER');