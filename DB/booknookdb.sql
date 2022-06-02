-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema booknookdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `booknookdb` ;

-- -----------------------------------------------------
-- Schema booknookdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `booknookdb` DEFAULT CHARACTER SET utf8 ;
USE `booknookdb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `role` VARCHAR(45) NULL,
  `email` VARCHAR(200) NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `img_url` VARCHAR(2000) NULL,
  `biography` TEXT NULL,
  `create_date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `language` ;

CREATE TABLE IF NOT EXISTS `language` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book` ;

CREATE TABLE IF NOT EXISTS `book` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `description` TEXT NULL,
  `isbn_10` VARCHAR(20) NULL,
  `page_count` INT NULL,
  `img_url` VARCHAR(2000) NULL,
  `publish_date` DATE NULL,
  `isbn_13` VARCHAR(20) NULL,
  `language_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `date_added` DATE NOT NULL,
  `last_updated` DATETIME NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_book_language1_idx` (`language_id` ASC),
  INDEX `fk_book_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_book_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `language` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category` ;

CREATE TABLE IF NOT EXISTS `category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(2000) NULL,
  `img_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `author` ;

CREATE TABLE IF NOT EXISTS `author` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(45) NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `post` ;

CREATE TABLE IF NOT EXISTS `post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NOT NULL,
  `title` VARCHAR(200) NULL,
  `post_date` DATETIME NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_post_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_post_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment` ;

CREATE TABLE IF NOT EXISTS `comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(2000) NOT NULL,
  `comment_date` DATETIME NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `user_id` INT NOT NULL,
  `post_id` INT NOT NULL,
  `in_reply_to_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_comment_post1_idx` (`post_id` ASC),
  INDEX `fk_comment_comment1_idx` (`in_reply_to_id` ASC),
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_comment1`
    FOREIGN KEY (`in_reply_to_id`)
    REFERENCES `comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `question`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `question` ;

CREATE TABLE IF NOT EXISTS `question` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(2000) NOT NULL,
  `question_date` DATETIME NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `user_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_question_user1_idx` (`user_id` ASC),
  INDEX `fk_question_book1_idx` (`book_id` ASC),
  CONSTRAINT `fk_question_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_question_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `answer` ;

CREATE TABLE IF NOT EXISTS `answer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(2000) NOT NULL,
  `answer_date` DATETIME NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `user_id` INT NOT NULL,
  `question_id` INT NOT NULL,
  `in_reply_to_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_answer_user1_idx` (`user_id` ASC),
  INDEX `fk_answer_question1_idx` (`question_id` ASC),
  INDEX `fk_answer_answer1_idx` (`in_reply_to_id` ASC),
  CONSTRAINT `fk_answer_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_answer_question1`
    FOREIGN KEY (`question_id`)
    REFERENCES `question` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_answer_answer1`
    FOREIGN KEY (`in_reply_to_id`)
    REFERENCES `answer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `review` ;

CREATE TABLE IF NOT EXISTS `review` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NOT NULL,
  `rating` INT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `title` VARCHAR(45) NULL,
  `review_date` DATETIME NOT NULL,
  `user_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_review_user1_idx` (`user_id` ASC),
  INDEX `fk_review_book1_idx` (`book_id` ASC),
  CONSTRAINT `fk_review_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wishlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wishlist` ;

CREATE TABLE IF NOT EXISTS `wishlist` (
  `user_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `book_id`),
  INDEX `fk_user_has_book_book1_idx` (`book_id` ASC),
  INDEX `fk_user_has_book_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_book_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_book_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `currently_reading`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `currently_reading` ;

CREATE TABLE IF NOT EXISTS `currently_reading` (
  `user_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `book_id`),
  INDEX `fk_user_has_book1_book1_idx` (`book_id` ASC),
  INDEX `fk_user_has_book1_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_book1_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_book1_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `finished`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `finished` ;

CREATE TABLE IF NOT EXISTS `finished` (
  `user_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `book_id`),
  INDEX `fk_user_has_book_book2_idx` (`book_id` ASC),
  INDEX `fk_user_has_book_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_book_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_book_book2`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `book_to_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `book_to_category` ;

CREATE TABLE IF NOT EXISTS `book_to_category` (
  `book_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`book_id`, `category_id`),
  INDEX `fk_book_has_category_category1_idx` (`category_id` ASC),
  INDEX `fk_book_has_category_book1_idx` (`book_id` ASC),
  CONSTRAINT `fk_book_has_category_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_has_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `author_to_book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `author_to_book` ;

CREATE TABLE IF NOT EXISTS `author_to_book` (
  `author_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`author_id`, `book_id`),
  INDEX `fk_author_has_book_book1_idx` (`book_id` ASC),
  INDEX `fk_author_has_book_author1_idx` (`author_id` ASC),
  CONSTRAINT `fk_author_has_book_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_author_has_book_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `answer_vote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `answer_vote` ;

CREATE TABLE IF NOT EXISTS `answer_vote` (
  `answer_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `vote` TINYINT NOT NULL,
  PRIMARY KEY (`answer_id`, `user_id`),
  INDEX `fk_answer_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_answer_has_user_answer1_idx` (`answer_id` ASC),
  CONSTRAINT `fk_answer_has_user_answer1`
    FOREIGN KEY (`answer_id`)
    REFERENCES `answer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_answer_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `post_vote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `post_vote` ;

CREATE TABLE IF NOT EXISTS `post_vote` (
  `post_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `vote` TINYINT NOT NULL,
  PRIMARY KEY (`post_id`, `user_id`),
  INDEX `fk_post_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_post_has_user_post1_idx` (`post_id` ASC),
  CONSTRAINT `fk_post_has_user_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comment_vote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment_vote` ;

CREATE TABLE IF NOT EXISTS `comment_vote` (
  `user_id` INT NOT NULL,
  `comment_id` INT NOT NULL,
  `vote` TINYINT NOT NULL,
  PRIMARY KEY (`user_id`, `comment_id`),
  INDEX `fk_user_has_comment_comment1_idx` (`comment_id` ASC),
  INDEX `fk_user_has_comment_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_comment_comment1`
    FOREIGN KEY (`comment_id`)
    REFERENCES `comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `favorite_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `favorite_categories` ;

CREATE TABLE IF NOT EXISTS `favorite_categories` (
  `user_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `category_id`),
  INDEX `fk_user_has_category_category1_idx` (`category_id` ASC),
  INDEX `fk_user_has_category_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_category_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `favorite_authors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `favorite_authors` ;

CREATE TABLE IF NOT EXISTS `favorite_authors` (
  `user_id` INT NOT NULL,
  `author_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `author_id`),
  INDEX `fk_user_has_author_author1_idx` (`author_id` ASC),
  INDEX `fk_user_has_author_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_author_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_author_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `follow_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `follow_list` ;

CREATE TABLE IF NOT EXISTS `follow_list` (
  `user_id` INT NOT NULL,
  `follow_to_user_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `follow_to_user_id`),
  INDEX `fk_user_has_user_user2_idx` (`follow_to_user_id` ASC),
  INDEX `fk_user_has_user_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_user_user2`
    FOREIGN KEY (`follow_to_user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `favorite_book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `favorite_book` ;

CREATE TABLE IF NOT EXISTS `favorite_book` (
  `user_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `book_id`),
  INDEX `fk_user_has_book_book3_idx` (`book_id` ASC),
  INDEX `fk_user_has_book_user2_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_book_user2`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_book_book3`
    FOREIGN KEY (`book_id`)
    REFERENCES `book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS book@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'book'@'localhost' IDENTIFIED BY 'book';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'book'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `email`, `first_name`, `last_name`, `img_url`, `biography`, `create_date`) VALUES (1, 'admin', '$2a$10$5PbAsZlmRaA/6XfTJPFkA.AjYJJWN74amFScRzJh1ptPY34yMX/Qy', 1, 'ROLE_ADMIN', 'booknookadmin@gmail.com', 'Bob', 'Dobbs', 'https://media.istockphoto.com/vectors/wizard-1-vector-id502757527?k=20&m=502757527&s=612x612&w=0&h=euCGt24F5-C5qbSxete2gOgmToMpKhVgdpRWyL1C-Ds=', 'I am a programming wizard, and I like to read tomes.', '2022-05-25');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `email`, `first_name`, `last_name`, `img_url`, `biography`, `create_date`) VALUES (2, 'Fred', '$2a$10$wjX78AfG3tyB8uXmB6Jn.unENzyRU9xwKb/cd4BetCBOee2n0rDLq', 1, 'ROLE_USER', 'booknookuser@gmail.com', 'Fred', 'Rocks', 'https://media.istockphoto.com/vectors/primitive-man-thinking-confused-embarrassed-caveman-with-club-in-hand-vector-id1081447694?k=20&m=1081447694&s=612x612&w=0&h=X9L1jWbdJR4a521lTFXYu2CGUn4w0FF3S8i3Nymf21o=', 'Me want read books but is hard without alphabet invented', '2022-05-25');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `email`, `first_name`, `last_name`, `img_url`, `biography`, `create_date`) VALUES (3, 'barnman', '$2a$10$XE0n3aN92TgrqspN97b3Luq15uTQICWo0BdRrB4uJp64WhQ3kjoGu\"', 1, 'ROLE_USER', 'barnman@gmail.com', 'Bernard', 'Rubbal', 'https://st2.depositphotos.com/1724125/8667/v/380/depositphotos_86679502-stock-illustration-cartoon-caveman.jpg?forcejpeg=true', 'I am more sophisticated than your average caveman', '2022-06-01');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `email`, `first_name`, `last_name`, `img_url`, `biography`, `create_date`) VALUES (4, 'nonothingdude', '$2a$10$sLIYZ1C5mcKnE7TaTDa8wO1nqCXlp8LJZg34OQw2lOTNi4PFyKbAW', 1, 'ROLE_USER', 'nonothingdude@gmail.com', 'Socrates', 'Athens', 'https://us.123rf.com/450wm/tigatelu/tigatelu1905/tigatelu190500129/123719594-vector-illustration-of-cartoon-ancient-greek-philosopher-on-white-background.jpg?ver=6', 'I just want to learn', '2022-06-01');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `email`, `first_name`, `last_name`, `img_url`, `biography`, `create_date`) VALUES (5, 'sageOfTheWind', '$2a$10$wEBAHe/0e/705vIXM5AaYuP4tCqvCkp12J3QUkX74hTDhGCkN598e', 1, 'ROLE_USER', 'zhugeliang@gmail.com', 'Zhu Ge', 'Liang', 'https://png.pngtree.com/element_our/20200611/ourlarge/pngtree-zhuge-liang-feather-fan-image_2251665.jpg', 'The keen strategest has never seen a new situation because they have read about it already.', '2022-06-01');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `email`, `first_name`, `last_name`, `img_url`, `biography`, `create_date`) VALUES (6, 'superSpammer', '$2a$10$xTVL/1OX4Tt1n3.emgJdy.nCTSDmDOnTyoPgsuZhx/.rFdoFh7ZcO', 1, 'ROLE_USER', NULL, NULL, NULL, NULL, 'Click here to change your life forever!!!!!--------', '2022-06-01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `language`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `language` (`id`, `name`) VALUES (1, 'English');
INSERT INTO `language` (`id`, `name`) VALUES (2, 'Spanish');

COMMIT;


-- -----------------------------------------------------
-- Data for table `book`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (2, 'The Fellowship of the Ring', 'Presents the epic depicting the Great War of the Ring, a struggle between good and evil in Middle Earth - Part 1 of The lord of the rings.', '0618129022', 1137, 'https://covers.openlibrary.org/b/isbn/0618260242-L.jpg', '2001-01-01', '9780618129027', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (1, 'The Hobbit Or There and Back Again', 'Celebrating 75 years of one of the world\'s most treasured classics with an all new trade paperback edition. Repackaged with new cover art. 500,000 first printing.', '054792822X', 300, 'https://www.pluggedin.com/wp-content/uploads/2020/01/hobbit-cover-670x1024.jpg', '2012-01-01', '9780547928227', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (3, 'The Two Towers', 'This title is also available as a film as a film - Part 2 of The lord of the rings.', '026110358X', 322, 'https://images-na.ssl-images-amazon.com/images/I/919-2hQNB6L.jpg', '1997-01-01', '9780261103580', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (4, 'The Return of the King', 'Concluding the story begun in The Hobbit, this is the final part of Tolkien s epic masterpiece, The Lord of the Rings, featuring an exclusive cover image from the film, the definitive text, and a detailed map of Middle-earth. The armies of the Dark Lord Sauron are massing as his evil shadow spreads ever wider. Men, Dwarves, Elves and Ents unite forces to do battle agains the Dark. Meanwhile, Frodo and Sam struggle further into Mordor in their heroic quest to destroy the One Ring. The devastating conclusion of J.R.R. Tolkien s classic tale of magic and adventure, begun in The Fellowship of the Ring and The Two Towers, features the definitive edition of the text and includes the Appendices and a revised Index in full. To celebrate the release of the first of Peter Jackson s two-part film adaptation of The Hobbit, THE HOBBIT: AN UNEXPECTED JOURNEY, this third part of The Lord of the Rings is available for a limited time with an exclusive cover image from Peter Jackson s award-winning trilogy.', '0007488343', 624, 'https://i0.wp.com/theliteraryphoenix.com/wp-content/uploads/sites/302/2019/05/1-10.jpg?resize=300%2C465&ssl=1', '2012-01-01', '9780007488346', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (5, 'Automate the Boring Stuff with Python', 'If you\'ve ever spent hours renaming files or updating hundreds of spreadsheet cells, you know how tedious tasks like these can be. But what if you could have your computer do them for you? In Automate the Boring Stuff with Python, you+IBk-ll learn how to use Python to write programs that do in minutes what would take you hours to do by hand+IBQ-no prior programming experience required. Once you+IBk-ve mastered the basics of programming, you+IBk-ll create Python programs that effortlessly perform useful and impressive feats of automation to: +IBM-Search for text in a file or across multiple files +IBM-Create, update, move, and rename files and folders +IBM-Search the Web and download online content +IBM-Update and format data in Excel spreadsheets of any size +IBM-Split, merge, watermark, and encrypt PDFs +IBM-Send reminder emails and text notifications +IBM-Fill out online forms Step-by-step instructions walk you through each program, and practice projects at the end of each chapter challenge you to improve those programs and use your newfound skills to automate similar tasks. Don+IBk-t spend your time doing work a well-trained monkey could do. Even if you+IBk-ve never written a line of code, you can make your computer do the grunt work. Learn how in Automate the Boring Stuff with Python. Note: The programs in this book are written to run on Python 3.', '1593276850', 504, 'https://books.google.com/books/publisher/content/images/frontcover/8AcvDwAAQBAJ?fife=w400-h600&source=gbs_api', '2015-04-14', '9781593276850', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (6, 'Drawdown', 'NEW YORK TIMES BESTSELLER For the first time ever, an international coalition of leading researchers, scientists and policymakers has come together to offer a set of realistic and bold solutions to climate change. All of the techniques described here - some well-known, some you may have never heard of - are economically viable, and communities throughout the world are already enacting them. From revolutionizing how we produce and consume food to educating girls in lower-income countries, these are all solutions which, if deployed collectively on a global scale over the next thirty years, could not just slow the earth\'s warming, but reach drawdown: the point when greenhouse gasses in the atmosphere peak and begin todecline. So what are we waiting for?', '141988444', 256, 'https://books.google.com/books/publisher/content/images/frontcover/QhlADwAAQBAJ?fife=w400-h600&source=gbs_api', '2018-02-22', '9780141988443', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (7, 'Accidentally Wes Anderson', 'Wes Anderson\'s beloved films announce themselves through a singular aesthetic - one that seems too vivid, unique, and meticulously constructed to possibly be real. Not so - in Accidentally Wes Anderson, Wally Koval collects the world\'s most Anderson-like sites in all their faded grandeur and pop-pastel colours, telling the story behind each stranger than-fiction-location. Based on the viral online phenomenon and community of the same name, Accidentally Wes Anderson celebrates the unique aesthetic that millions of Anderson fans love - capturing the symmetrical, the atypical, the unexpected, the vibrantly patterned, and distinctively coloured in arresting photographs from around the world. Authorised by Wes Anderson himself, and appealing to the millions who love his films, this book is also for fans of Cabin Porn and Van Life - and avid travellers and aspiring adventurers of all kinds.', '1409197417', 368, 'https://books.google.com/books/publisher/content/images/frontcover/P-rSDwAAQBAJ?fife=w400-h600&source=gbs_api', '2020-10-29', '9781409197416', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (8, 'Measure What Matters', NULL, '525538348', 306, 'https://books.google.com/books/publisher/content/images/frontcover/SIJpswEACAAJ?fife=w400-h600&source=gbs_api', '2018-04-24', '9780525538349', 1, 1, '2022-05-25', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (9, 'How to Enjoy Art', 'An entertaining and lively guide to rediscovering the pleasure in art How to Enjoy Art: A Guide for Everyone provides the tools to understand and enjoy works of art. Debunking the pervasive idea that specialist knowledge is required to understand and appreciate art, instead How to Enjoy Art focuses on experience and pleasure, demonstrating how anyone can find value and enjoyment in art. Examples from around the world and throughout art history+IBQ-from works by Fra Angelico and Berthe Morisot to Kazuo Shiraga and Kara Walker+IBQ-are used to demonstrate how a handful of core strategies and skills can help enhance the experience of viewing art works. With these skills, anyone can encounter any work of art+IBQ-regardless of media, artist or period+IBQ-and find some resonance with their own experiences. How to Enjoy Art encourages us to rediscover the fundamental pleasure in viewing art.', '300263120', 160, 'https://books.google.com/books/publisher/content/images/frontcover/uiQ7EAAAQBAJ?fife=w400-h600&source=gbs_api', '2021-09-14', '9780300263121', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (10, 'Alcoholics Anonymous', NULL, '1258461803', 410, 'https://books.google.com/books/publisher/content/images/frontcover/Go9UMgEACAAJ?fife=w400-h600&source=gbs_api', '2012-08-01', '9781258461805', 1, 1, '2022-05-25', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (11, 'The Associated Press Stylebook 2015', 'A fully revised and updated edition of the bible of the newspaper industry', '465062946', 496, 'https://books.google.com/books/publisher/content/images/frontcover/-6vZoQEACAAJ?fife=w400-h600&source=gbs_api', '2015-07-14', '9780465062942', 1, 1, '2022-05-25', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (12, 'Immunisation against infectious diseases', 'This is the third edition of this publication which contains the latest information on vaccines and vaccination procedures for all the vaccine preventable infectious diseases that may occur in the UK or in travellers going outside of the UK, particularly those immunisations that comprise the routine immunisation programme for all children from birth to adolescence. It is divided into two sections: the first section covers principles, practices and procedures, including issues of consent, contraindications, storage, distribution and disposal of vaccines, surveillance and monitoring, and the Vaccine Damage Payment Scheme; the second section covers the range of different diseases and vaccines.', '113225288', 468, 'https://books.google.com/books/publisher/content/images/frontcover/N0RY-qAyiFIC?fife=w400-h600&source=gbs_api', '2006-12-11', '9780113225286', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (13, 'Palliative Care in Neurology', 'Over the last 50 years palliative care has usually been associated with cancer patients but more recently there has been increased discussion of the role of palliative care for neurological patients. In the past years, neurology has moved from being a purely diagnostic area to a very therapeutically active one. A further step needs to be taken to modify the therapeutic activity from +IBw-cure+IB0 to +IBw-care+IB0 depending on the patient+IBk-s disease trajectory. Palliative care has been associated with care at the end of life, whereas it may be appropriate earlier in the disease progression, and will extend after death in the support of bereaved families. The care of patients with neurological disease, and their families, will encompass the psychological, spiritual and existential issues and neurologists, and the teams in which they work, should develop skills to consider all aspects of care, in order to maximize the quality of life of all involved, and enable patients to die peacefully.', '288963471X', NULL, 'https://books.google.com/books/publisher/content/images/frontcover/uaHVDwAAQBAJ?fife=w400-h600&source=gbs_api', '2020-03-10', '9782889634712', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (14, 'European Genizah', 'This volume includes contributions presented at two conferences, in Mainz (Germany) and Jerusalem (Israel). The articles present a number of new discoveries of binding fragments in several European libraries and beyond.', '9004427929', 368, 'https://books.google.com/books/publisher/content/images/frontcover/JTr1DwAAQBAJ?fife=w400-h600&source=gbs_api', '2020-06-22', '9789004427921', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (15, 'How to Self-Publish Your Book', 'Did you ever consider self-publishing your own book but were daunted by the complex process of actually doing it? Self-published author and expert Carla King gives a simple step-by-step guide to self-publishing your book as an e-book or print book. Plot your success by choosing the reputable tools and services recommended here, along with techniques that will help your book succeed in the market that you choose.', '1627640010', NULL, 'https://books.google.com/books/publisher/content/images/frontcover/mN8eIE5HqL0C?fife=w400-h600&source=gbs_api', '2013-04-04', '9781627640015', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (16, 'Accident Book', NULL, '717664589', NULL, 'https://books.google.com/books/publisher/content/images/frontcover/zag2mgEACAAJ?fife=w400-h600&source=gbs_api', '2012-08-01', '9780717664580', 1, 1, '2022-05-25', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (17, 'Causal Inference', 'The application of causal inference methods is growing exponentially in fields that deal with observational data. Written by pioneers in the field, this practical book presents an authoritative yet accessible overview of the methods and applications of causal inference. With a wide range of detailed, worked examples using real epidemiologic data as well as software for replicating the analyses, the text provides a thorough introduction to the basics of the theory for non-time-varying treatments and the generalization to complex longitudinal data.', '1420076167', 352, 'https://books.google.com/books/publisher/content/images/frontcover/_KnHIAAACAAJ?fife=w400-h600&source=gbs_api', '2019-07-07', '9781420076165', 1, 1, '2022-05-25', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (18, 'StrengthsFinder 2.0', 'An updated version of the StrengthsFinder program developed by Gallup experts to help readers discover their distinct talents and strengths and how they can be translated into personal and career successes.', '159562015X', 175, 'https://books.google.com/books/publisher/content/images/frontcover/gttDCwAAQBAJ?fife=w400-h600&source=gbs_api', '2007-02-01', '9781595620156', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (19, 'bookdown', 'bookdown: Authoring Books and Technical Documents with R Markdown presents a much easier way to write books and technical publications than traditional tools such as LaTeX and Word. The bookdown package inherits the simplicity of syntax and flexibility for data analysis from R Markdown, and extends R Markdown for technical writing, so that you can make better use of document elements such as figures, tables, equations, theorems, citations, and references. Similar to LaTeX, you can number and cross-reference these elements with bookdown. Your document can even include live examples so readers can interact with them while reading the book. The book can be rendered to multiple output formats, including LaTeX/PDF, HTML, EPUB, and Word, thus making it easy to put your documents online. The style and theme of these output formats can be customized. We used books and R primarily for examples in this book, but bookdown is not only for books or R. Most features introduced in this book also apply to other types of publications: journal papers, reports, dissertations, course handouts, study notes, and even novels. You do not have to use R, either. Other choices of computing languages include Python, C, C+-+-, SQL, Bash, Stan, JavaScript, and so on, although R is best supported. You can also leave out computing, for example, to write a fiction. This book itself is an example of publishing with bookdown and R Markdown, and its source is fully available on GitHub.', '1351792601', 138, 'https://books.google.com/books/publisher/content/images/frontcover/8nm0DQAAQBAJ?fife=w400-h600&source=gbs_api', '2016-12-12', '9781351792608', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (20, 'Revelation', 'The final book of the Bible, Revelation prophesies the ultimate judgement of mankind in a series of allegorical visions, grisly images and numerological predictions. According to these, empires will fall, the \"Beast\" will be destroyed and Christ will rule a new Jerusalem. With an introduction by Will Self.', '857861018', 64, 'https://books.google.com/books/publisher/content/images/frontcover/JJqEbvqo0ZgC?fife=w400-h600&source=gbs_api', '1999-01-01', '9780857861016', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (21, 'Gathering Moss', 'Kimmerer blends, with deep attentiveness and musicality, science and personal insights to tell the overlooked story of the planet\'s oldest plants\' Guardian \'Bewitching ... a masterwork ... a glittering read in its entirety\' Maria Popova, Brainpickings Living at the limits of our ordinary perception, mosses are a common but largely unnoticed element of the natural world. Gathering Moss is a beautifully written mix of science and personal reflection that invites readers to explore and learn from the elegantly simple lives of mosses. In these interwoven essays, Robin Wall Kimmerer leads general readers and scientists alike to an understanding of how mosses live and how their lives are intertwined with the lives of countless other beings. Kimmerer explains the biology of mosses clearly and artfully, while at the same time reflecting on what these fascinating organisms have to teach us. Drawing on her experiences as a scientist, a mother, and a Native American, Kimmerer explains the stories of mosses in scientific terms as well as within the framework of indigenous ways of knowing. In her book, the natural history and cultural relationships of mosses become a powerful metaphor for ways of living in the world.', '014199763X', 192, 'https://books.google.com/books/publisher/content/images/frontcover/VXYLEAAAQBAJ?fife=w400-h600&source=gbs_api', '2021-07-01', '9780141997636', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (22, 'This Life', 'This Life is the debut novel by Quntos KunQuest, a longtime inmate at Angola, the infamous Louisiana State Penitentiary. This marks the appearance of a bold, distinctive new voice, one deeply inflected by hiphop, that delves into the meaning of a life spent behind bars, the human bonds formed therein, and the poetry that even those in the most dire places can create. Lil Chris is just nineteen when he arrives at Angola as an AU+IBQ-an admitting unit, a fresh fish, a new vict. He+IBk-s got a life sentence with no chance of parole, but he+IBk-s also got a clear mind and sharp awareness+IBQ-one that picks up quickly on the details of the system, his fellow inmates, and what he can do to claim a place at the top. When he meets Rise, a mature inmate who\'s already spent years in the system, and whose composure and raised consciousness command the respect of the other prisoners, Lil Chris learns to find his way in a system bent on repressing every means he has to express himself. Lil Chris and Rise channel their questions, frustrations, and pain into rap, and This Life flows with the same cadence that powers their charged verses. It pulses with the heat of impassioned inmates, the oppressive daily routines of the prison yard, and the rap contests that bring the men of the prison together. This Life is told in a voice that only a man who+IBk-s lived it could have+IBQ-a clipped, urgent, evocative voice that surges with anger, honesty, playfulness, and a deep sense of ugly history. Angola started out as a plantation+IBQ-and as This Life makes clear, black inmates are still in a kind of enslavement there. This Life is an important debut that commands our attention with the vigor, dynamism, and raw, consciousness-expanding energy of this essential new voice.', '1572848480', NULL, 'https://books.google.com/books/publisher/content/images/frontcover/FW0vEAAAQBAJ?fife=w400-h600&source=gbs_api', '2021-06-08', '9781572848481', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (23, 'Principles', '#1 New York Times Bestseller Significant...The book is both instructive and surprisingly moving. The New York Times Ray Dalio, one of the world most successful investors and entrepreneurs, shares the unconventional principles that he+IBk-s developed, refined, and used over the past forty years to create unique results in both life and business+IBQ-and which any person or organization can adopt to help achieve their goals. In 1975, Ray Dalio founded an investment firm, Bridgewater Associates, out of his two-bedroom apartment in New York City. Forty years later, Bridgewater has made more money for its clients than any other hedge fund in history and grown into the fifth most important private company in the United States, according to Fortune magazine. Dalio himself has been named to Time magazine+IBk-s list of the 100 most influential people in the world. Along the way, Dalio discovered a set of unique principles that have led to Bridgewater+IBk-s exceptionally effective culture, which he describes as +IBw-an idea meritocracy that strives to achieve meaningful work and meaningful relationships through radical transparency.+IB0 It is these principles, and not anything special about Dalio+IBQ-who grew up an ordinary kid in a middle-class Long Island neighborhood+IBQ-that he believes are the reason behind his success. In Principles, Dalio shares what he+IBk-s learned over the course of his remarkable career. He argues that life, management, economics, and investing can all be systemized into rules and understood like machines. The book+IBk-s hundreds of practical lessons, which are built around his cornerstones of +IBw-radical truth+IB0 and +IBw-radical transparency,+IB0 include Dalio laying out the most effective ways for individuals and organizations to make decisions, approach challenges, and build strong teams. He also describes the innovative tools the firm uses to bring an idea meritocracy to life, such as creating +IBw-baseball cards+IB0 for all employees that distill their strengths and weaknesses, and employing computerized decision-making systems to make believability-weighted decisions. While the book brims with novel ideas for organizations and institutions, Principles also offers a clear, straightforward approach to decision-making that Dalio believes anyone can apply, no matter what they+IBk-re seeking to achieve. Here, from a man who has been called both +IBw-the Steve Jobs of investing+IB0 and +IBw-the philosopher king of the financial universe+IB0 (CIO magazine), is a rare opportunity to gain proven advice unlike anything you+IBk-ll find in the conventional business press.', '1982112387', 592, 'https://books.google.com/books/publisher/content/images/frontcover/qNNmDwAAQBAJ?fife=w400-h600&source=gbs_api', '2018-08-07', '9781982112387', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (24, 'Biology 2e', NULL, '1947172514', NULL, 'https://books.google.com/books/publisher/content/images/frontcover/c9zStAEACAAJ?fife=w400-h600&source=gbs_api', '2018-04-01', '9781947172517', 1, 1, '2022-05-25', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (25, 'Moon Witch, Spider King', 'Masterfully flips the first installment on its head... James makes the mythic tantalizingly real. -Esquire \"Even more brilliant than the first. -Buzzfeed An Instant New York Times Bestseller From Marlon James, author of the bestselling National Book Award finalist Black Leopard, Red Wolf, the second book in the Dark Star trilogy. In Black Leopard, Red Wolf, Sogolon the Moon Witch proved a worthy adversary to Tracker as they clashed across a mythical African landscape in search of a mysterious boy who disappeared. In Moon Witch, Spider King, Sogolon takes center stage and gives her own account of what happened to the boy, and how she plotted and fought, triumphed and failed as she looked for him. It+IBk-s also the story of a century-long feud+IBQ-seen through the eyes of a 177-year-old witch+IBQ-that Sogolon had with the Aesi, chancellor to the king. It is said that Aesi works so closely with the king that together they are like the eight limbs of one spider. Aesi+IBk-s power is considerable+IBQ-and deadly. It takes brains and courage to challenge him, which Sogolon does for reasons of her own. Both a brilliant narrative device+IBQ-seeing the story told in Black Leopard, Red Wolf from the perspective of an adversary and a woman+IBQ-as well as a fascinating battle between different versions of empire, Moon Witch, Spider King delves into Sogolon+IBk-s world as she fights to tell her own story. Part adventure tale, part chronicle of an indomitable woman who bows to no man, it is a fascinating novel that explores power, personality, and the places where they overlap.', '735220220', 656, 'https://books.google.com/books/publisher/content/images/frontcover/8ME0EAAAQBAJ?fife=w400-h600&source=gbs_api', '2022-02-15', '9780735220225', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (26, 'SAT Prep Black Book', '\"In addition to extensive and effective training on every aspect of the SAT, the SAT Black Book gives you detailed, systematic, easy-to-follow walkthroughs for every question in 4 of the College Board\'s official SAT Practice Tests. The Black Book is a must-have in your SAT preparation, whether you need to - make a perfect 1600 to be competitive at an Ivy, score a 450 in each section to claim a sports scholarship, or anything in between.\"--Publisher.', '692916164', 630, 'https://books.google.com/books/publisher/content/images/frontcover/hBSLswEACAAJ?fife=w400-h600&source=gbs_api', '2017-07-01', '9780692916162', 1, 1, '2022-05-25', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (27, 'Radical Candor', 'Radical Candor is the sweet spot between managers who are obnoxiously aggressive on the one side and ruinously empathetic on the other. It is about providing guidance, which involves a mix of praise as well as criticism, delivered to produce better results and help employees develop their skills and boundaries of success. Great bosses have a strong relationship with their employees, and Kim Scott Malone has identified three simple principles for building better relationships with your employees: make it personal, get stuff done, and understand why it matters. Radical Candor offers a guide to those bewildered or exhausted by management, written for bosses and those who manage bosses. Drawing on years of first-hand experience, and distilled clearly to give actionable lessons to the reader, Radical Candor shows how to be successful while retaining your integrity and humanity. Radical Candor is the perfect handbook for those who are looking to find meaning in their job and create an environment where people both love their work, their colleagues and are motivated to strive to ever greater success.', '1760553026', NULL, 'https://books.google.com/books/publisher/content/images/frontcover/XSXeDQAAQBAJ?fife=w400-h600&source=gbs_api', '2017-03-28', '9781760553029', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (28, 'Twelve Steps and Twelve Traditions Trade Edition', 'Twelve Steps to recovery.', '916856011', 192, 'https://books.google.com/books/publisher/content/images/frontcover/LTsUuAEACAAJ?fife=w400-h600&source=gbs_api', '1953-01-01', '9780916856014', 1, 1, '2022-05-25', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (29, 'Rework', '\"Rework\" shows you a better, faster, easier way to succeed in business. You\'ll learn how to be more productive, how to get exposure without breaking the bank, and tons more counterintuitive ideas that will inspire and provoke you.', '307463745', 279, 'https://books.google.com/books/publisher/content/images/frontcover/RC6LLYweIEMC?fife=w400-h600&source=gbs_api', '2010-01-01', '9780307463746', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (30, 'The Kids', 'Hannah Lowe taught for a decade in an inner-city London sixth form. At the heart of this book of compassionate and energetic sonnets are \'The Kids\', her students, the teenagers she nurtured. But the poems go further, meeting her own child self as she comes of age in the riotous 80s and 90s, later bearing witness to her small son learning to negotiate contemporary London. Across these deeply felt poems, Lowe interrogates the acts of teaching and learning with empathy and humour. Social class, gender and race - and their fundamental intersection with education - are investigated with an ever critical and introspective eye. The sonnet is re-energised, becoming a classroom, a memory box and even a mind itself as \'The Kids\' learn and negotiate their own unknown futures. These boisterous and musical poems explore and explode the universal experience of what it is to be taught, and to teach, ultimately reaching out and speaking to the child in all of us. The poems in the first section of the book draw on Hannah Lowe\'s experiences as a teacher in the 2000s, but the scenarios are largely fictitious, as are the names of the students. The Kids is a Poetry Book Society Choice.', '1780375794', 80, 'https://books.google.com/books/publisher/content/images/frontcover/e_UdzgEACAAJ?fife=w400-h600&source=gbs_api', '2021-01-01', '9781780375793', 1, 1, '2022-05-25', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (31, 'The Fight for Free Speech', 'A user+IBk-s guide to understanding contemporary free speech issues in the United States Americans today are confronted by a barrage of questions relating to their free speech freedoms. What are libel laws, and do they need to be changed to stop the press from lying? Does Colin Kaepernick have the right to take a knee? Can Saturday Night Live be punished for parody? While citizens are grappling with these questions, they generally have nowhere to turn to learn about the extent of their First Amendment rights. The Fight for Free Speech answers this call with an accessible, engaging user+IBk-s guide to free speech. Media lawyer Ian Rosenberg distills the spectrum of free speech law down to ten critical issues. Each chapter in this book focuses on a contemporary free speech question+IBQ-from student walkouts for gun safety to Samantha Bee+IBk-s expletives, from Nazis marching in Charlottesville to the muting of adult film star Stormy Daniels+IBQ and then identifies, unpacks, and explains the key Supreme Court case that provides the answers. Together these fascinating stories create a practical framework for understanding where our free speech protections originated and how they can develop in the future. As people on all sides of the political spectrum are demanding their right to speak and be heard, The Fight for Free Speech is a handbook for combating authoritarianism, protecting our democracy, and bringing an understanding of free speech law to all.', '1479801542', NULL, 'https://books.google.com/books/publisher/content/images/frontcover/TtnaDwAAQBAJ?fife=w400-h600&source=gbs_api', '2021-02-09', '9781479801541', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (32, 'Rise and Rise of the Private Art Hb', 'Public Spaces / Private Passions critically examines the growth of private museums in the 21st century, their impact on public institutions and what the future might look like. It is essential reading for museum professionals, art collectors, critics and cultural commentators and anyone working in the art trade.', '1848223846', 104, 'https://books.google.com/books/publisher/content/images/frontcover/sPRbzgEACAAJ?fife=w400-h600&source=gbs_api', '2021-09-30', '9781848223844', 1, 1, '2022-05-25', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (33, 'The Monocle Book of Japan', 'A celebration of theendlessly fascinating andculturally rich countryof Japan, this book fromthe Monocle team ispacked with insightsand fully illustrated withstunning photography. Monocle\'s latest book is an ardent paean to Japan, covering everything from design, architecture, and culture to food, fashion, and current affairs. Since it launched in 2007, Monocle has had deep roots in Japan. From day one, the magazine has maintained a Tokyo bureau, which today also encompasses a Monocle shop and radio studio. Over the past decade, the magazine and its team have continued to build upon their appreciation for and understanding of the nation of Japan. Monocle\'s stories have covered everything from a live journey on the emperor\'s jet and the tastiest places to eat in Kagoshima to the fashion designers challenging conventions and the businesses with remarkable stories untold outside Japan. The Monocle Book of Japan reveals the best of the country in the run-up to the 2021 Olympics. Complete with striking photography and captivating essays, this volume showcases some of Japan\'s most intriguing splendors.', '500971072', 304, 'https://books.google.com/books/publisher/content/images/frontcover/flFXygEACAAJ?fife=w400-h600&source=gbs_api', '2020-05-05', '9780500971079', 1, 1, '2022-05-25', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (34, 'Book Traces', 'In most college and university libraries, materials published before 1800 have been moved into special collections, while the post-1923 books remain in general circulation. But books published between these dates are vulnerable to deaccessioning, as libraries increasingly reconfigure access to public-domain texts via digital repositories such as Google Books. Even libraries with strong commitments to their print collections are clearing out the duplicates, assuming that circulating copies of any given nineteenth-century edition are essentially identical to one another. When you look closely, however, you see that they are not. Many nineteenth-century books were donated by alumni or their families decades ago, and many of them bear traces left behind by the people who first owned and used them. In Book Traces, Andrew M. Stauffer adopts what he calls \"guided serendipity\" as a tactic in pursuit of two goals: first, to read nineteenth-century poetry through the clues and objects earlier readers left in their books and, second, to defend the value of keeping the physical volumes on the shelves. Finding in such books of poetry the inscriptions, annotations, and insertions made by their original owners, and using them as exemplary case studies, Stauffer shows how the physical, historical book enables a modern reader to encounter poetry through the eyes of someone for whom it was personal.', '812297490', 288, 'https://books.google.com/books/publisher/content/images/frontcover/hnINEAAAQBAJ?fife=w400-h600&source=gbs_api', '2021-02-05', '9780812297492', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (35, 'The Official DVSA Theory Test for Car Drivers', 'This publication is the official theory test book for car drivers, compiled by the Driver and Vehicle Standards Agency. It contains multiple choice questions from the whole theory test question bank, with answers and explanations, dealing with topics such as: alertness and attitude, vehicle safety and handling, safety margins, hazard awareness, vulnerable road users, motorway rules and rules of the road, road and traffic signs, documents, accidents, and vehicle loading.', '115534199', 512, 'https://books.google.com/books/publisher/content/images/frontcover/qAY4jgEACAAJ?fife=w400-h600&source=gbs_api', '2015-10-26', '9780115534195', 1, 1, '2022-05-25', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (36, 'From Dissertation to Book', 'All new Phd\'s hope that their dissertations can become books. But a dissertation is written for a committee and a book for the larger world. William Germano\'s From Dissertation to Book is the essential guide for academic writers who want to revise a doctoral thesis for publication. The author of Getting It Published, Germano draws upon his extensive experience in academic publishing to provide writers with a state-of-the-art view of how to turn a dissertation into a manuscript that publishers will notice. Acknowledging first that not all theses can become books, Germano shows how some dissertations might have a better life as one or more journal articles or as chapters in a newly conceived book. But even dissertations strong enough to be published as books first need to become book manuscripts, and at the heart of From Dissertation to Book is the idea that revising the dissertation is a fundamental process of adapting from one genre of writing to another. Germano offers clear guidance on how to do just this. Writers will find advice on such topics as rethinking the table of contents, taming runaway footnotes, shaping chapter length, and confronting the limitations of jargon, alongside helpful timetables for light or heavy revision. With crisp directives, engaging examples, and a sympathetic eye for the foibles of academic writing, From Dissertation to Book reveals to recent PhD\'s the process of careful and thoughtful revision+IBQ-a truly invaluable skill as they grow into their new roles as professional writers.', '226288471', 152, 'https://books.google.com/books/publisher/content/images/frontcover/gJVtu6vuBpkC?fife=w400-h600&source=gbs_api', '2008-04-15', '9780226288475', 1, 1, '2022-05-25', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (101, 'Cloud Atlas', 'A postmodern visionary who is also a master of styles of genres, David Mitchell combines flat-out adventure, a Nabokovian lore of puzzles, a keen eye for character, and a taste for mind-bending philosophical and scientific speculation in the tradition of Umberto Eco, Haruki Murakami, and Philip K. Dick. The result is brilliantly original fiction as profund as it is playful. Now in his new novel, David Mitchell explores with daring artistry fundamental questions of reality and identity.', '375507256', 509, 'https://covers.openlibrary.org/b/isbn/0375507256-L.jpg', '2004-01-01', '9780375507250', 1, 1, '2022-05-31', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (102, 'Hatchet (Brian\'s Saga, #1)', 'rian is on his way to Canada to visit his estranged father when the pilot of his small prop plane suffers a heart attack. Brian is forced to crash-land the plane in a lake--and finds himself stranded in the remote Canadian wilderness with only his clothing and the hatchet his mother gave him as a present before his departure.', '689840926', 208, 'https://covers.openlibrary.org/b/isbn/0689840926-L.jpg', '2000-01-01', '9780689840920', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (103, 'Shōgun (Asian Saga, #1)', 'A bold English adventurer. An invincible Japanese warlord. A beautiful woman torn between two ways of life. All brought together in an extraordinary saga aflame with passion, conflict, ambition, and the struggle for power.', '1982537523', 1152, 'https://covers.openlibrary.org/b/isbn/1982537523-L.jpg', '2009-01-01', '', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (104, 'It', 'It+IBk-s a small city, a place as hauntingly familiar as your own hometown. Only in Derry the haunting is real ...', '450411435', 1116, 'https://covers.openlibrary.org/b/isbn/0450411435-L.jpg', '1987-01-01', '9780450411434', 1, 1, '2022-05-31', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (105, 'Harry Potter and the Order of the Phoenix (Harry Potter, #5)', 'There is a door at the end of a silent corridor. And it\'s haunting Harry Pottter\'s dreams. Why else would he be waking in the middle of the night, screaming in terror?', '9955084332', 870, 'https://images-na.ssl-images-amazon.com/images/I/51lFAzVQUxL._SX342_BO1,204,203,200_.jpg', '2004-01-01', '', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (106, 'Death of a Salesman', 'For a salesman, there is no rock bottom to life. He don\'t put a bolt to a nut, he don\'t tell you the law or give you medicine. He\'s a man way out there in the blue, riding on a smile and a shoeshine.\'', '435233076', 117, 'https://covers.openlibrary.org/b/isbn/0435233076-L.jpg', '1994-01-01', '9780435233075', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (107, 'For Whom the Bell Tolls', 'In 1937 Ernest Hemingway traveled to Spain to cover the civil war there for the North American Newspaper Alliance. Three years later he completed the greatest novel to emerge from \"the good fight,\" For Whom the Bell Tolls. The story of Robert Jordan, a young American in the International Brigades attached to an antifascist guerilla unit in the mountains of Spain, it tells', '684717980', 471, 'https://covers.openlibrary.org/b/isbn/0684717980-L.jpg', '1995-01-01', '', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (108, 'Outlander (Outlander, #1)', 'The year is 1945. Claire Randall, a former combat nurse, is just back from the war and reunited with her husband on a second honeymoon when she walks through a standing stone in one of the ancient circles that dot the British Isles. Suddenly she is a Sassenach+IBQ-an +IBw-outlander+IB0gFA-in a Scotland torn by war and raiding border clans in the year of Our Lord...1743.', '440242940', 850, 'https://covers.openlibrary.org/b/isbn/0440242940-L.jpg', '2005-01-01', '9780440242949', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (109, 'Guns, Germs, and Steel: The Fates of Human Societies', '\"Diamond has written a book of remarkable scope ... one of the most important and readable works on the human past published in recent years.\"', '739467352', 498, 'https://covers.openlibrary.org/b/isbn/0739467352-L.jpg', '2005-01-01', '9780739467350', 1, 1, '2022-05-31', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (110, 'A Short History of Nearly Everything', 'In Bryson\'s biggest book, he confronts his greatest challenge: to understand+IBQ-and, if possible, answer+IBQ-the oldest, biggest questions we have posed about the universe and ourselves. Taking as territory everything from the Big Bang to the rise of civilization, Bryson seeks to understand how we got from there being nothing at all to there being us. To that end, he has attached', '076790818X', 544, 'https://covers.openlibrary.org/b/isbn/076790818X-L.jpg', '2004-01-01', '9780767908184', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (111, 'Into the Wild', 'In April, 1992, a young man from a well-to-do family hitchhiked to Alaska and walked alone into the wilderness north of Mt. McKinley. His name was Christopher Johnson McCandless. He had given $25,000 in savings to charity, abandoned his car and most of his possessions, burned all the cash in his wallet, and', '385486804', 203, 'https://covers.openlibrary.org/b/isbn/0385486804-L.jpg', '1997-01-01', '9780385486804', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (112, 'The Lightning Thief (Percy Jackson and the Olympians, #1)', 'Percy Jackson is a good kid, but he can\'t seem to focus on his schoolwork or control his temper. And lately, being away at boarding school is only getting worse - Percy could have sworn his pre-algebra teacher turned into a monster and tried to kill him. When Percy\'s mom finds out, she knows it\'s time that he knew the truth ab', '786856297', 377, 'https://covers.openlibrary.org/b/isbn/0786856297-L.jpg', '2006-01-01', '', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (113, 'The Things They Carried', 'In 1979, Tim O\'Brien\'s Going After Cacciato+IBQ-a novel about the Vietnam War+IBQ-won the National Book Award. In this, his second work of fiction about Vietnam, O\'Brien\'s unique artistic vision is again clearly demonstrated. Neither a novel nor a short story collection, it is an arc of fictional episodes, taking place in the childhoods of its characters, in the jungles of Vietnam', '767902890', 246, 'https://covers.openlibrary.org/b/isbn/0767902890-L.jpg', '1998-01-01', '9780767902892', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (114, 'Roots: The Saga of an American Family', 'When he was a boy in Henning, Tennessee, Alex Haley\'s grandmother used to tell him stories about their family+IBQ-stories that went back to her grandparents, and their grandparents, down through the generations all the way to a man she called \"the African.\" She said he had lived across the ocean near what he called the \"Kamby Bolongo\" and had been out in the forest one day', '440174643', 888, 'https://covers.openlibrary.org/b/isbn/0440174643-L.jpg', '1980-01-01', '9780440174646', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (115, 'The Godfather (The Godfather, #1)', 'Almost fifty years ago, a classic was born. A searing portrayal of the Mafia underworld, The Godfather introduced readers to the first family of American crime fiction, the Corleones, and their powerful legacy of tradition, blood, and honor. The seduction of power, the pitfalls of greed, and ', '2266013378', 448, 'https://covers.openlibrary.org/b/isbn/2266013378-L.jpg', '2002-01-01', '', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (116, 'The Three Musketeers (The D\'Artagnan Romances, #1)', 'This swashbuckling epic of chivalry, honor, and derring-do, set in France during the 1620s, is richly populated with romantic heroes, unattainable heroines, kings, queens, cavaliers, and criminals in a whirl of adventure, espionage, conspiracy, murd', '9753203152', 625, 'https://covers.openlibrary.org/b/isbn/9753203152-L.jpg', '2001-01-01', '', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (117, 'And Then There Were None', 'First, there were ten, a curious assortment of strangers summoned as weekend guests to a little private island off the coast of Devon. Their host, an eccentric millionaire unknown to all of them, is nowhere to be found. All that the guests have in common is a wicked past they\'re unwilling to reveal+IBQ-and a secret that will seal their fate. For each has been marked for murder.', '312330871', 264, 'https://covers.openlibrary.org/b/isbn/0312330871-L.jpg', '2004-01-01', '9780312330873', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (118, 'Where the Red Fern Grows', 'A loving threesome, they ranged the dark hills and river bottoms of Cherokee County. Old Dan had the brawn, Little Ann had the brains+IBQ-and Billy had the will to train them to be the finest hunting team in the valley. Glory and victory were coming to them, but sadness waited too. And close by was the strange and wonderf', '375806814', 272, 'https://covers.openlibrary.org/b/isbn/0375806814-L.jpg', '2000-01-01', '9780375806810', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (119, 'The Hiding Place: The Triumphant True Story of Corrie Ten Boom', 'At one time Corrie ten Boom would have laughed at the idea that there would ever be a story to tell. For the first fifty years of her life nothing at all out of the ordinary had ever happened to her. She was an old-maid watchmaker living contentedly with her spinster sister and their elderly father in the tiny Dutch house over their shop. Their uneventful days, as regulate', '553256696', 242, 'https://covers.openlibrary.org/b/isbn/0553256696-L.jpg', '1984-01-01', '9780553256697', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (120, 'I Know Why the Caged Bird Sings (Maya Angelou\'s Autobiography, #1)', 'Maya Angelou+IBk-s debut memoir is a modern American classic beloved worldwide. Her life story is told in the documentary film And Still I Rise, as seen on PBS+IBk-s American Masters.', '553279378', 289, 'https://covers.openlibrary.org/b/isbn/0553279378-L.jpg', '1993-01-01', '9780553279375', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (121, 'All Quiet on the Western Front', 'In 1914 a room full of German schoolboys, fresh-faced and idealistic, are goaded by their schoolmaster to troop off to the +IBg-glorious war+IBk. With the fire and patriotism of youth they sign up. What follows is the moving story of a young +IBg-unknown soldier+IBk experiencing the horror and disillusionment of life in the trenches.', '449213943', 296, 'https://covers.openlibrary.org/b/isbn/0449213943-L.jpg', '1987-01-01', '9780449213940', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (122, 'A Clockwork Orange', 'In Anthony Burgess\'s influential nightmare vision of the future, criminals take over after dark. Teen gang leader Alex narrates in fantastically inventive slang that echoes the violent intensity of youth rebelling against society. Dazzling and transgressive, A Clockwork Orange is a frightening fable about good and evil and the meaning of human freedom. This edition include', '393341763', 213, 'https://covers.openlibrary.org/b/isbn/0393341763-L.jpg', '2019-01-01', '9780393341768', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (123, 'The Handmaid\'s Tale (The Handmaid\'s Tale, #1)', 'Offred is a Handmaid in the Republic of Gilead. She may leave the home of the Commander and his wife once a day to walk to food markets whose signs are now pictures instead of words because women are no longer allowed to read. She must lie on her back once a month and pray that the Commander makes her pregnant, because in an age of declining births, Offred and the other', '224023489', 314, 'https://covers.openlibrary.org/b/isbn/0224023489-L.jpg', '1998-01-01', '', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (124, 'A Tale of Two Cities', 'A Tale of Two Cities is Charles Dickens+IBk-s great historical novel, set against the violent upheaval of the French Revolution. The most famous and perhaps the most popular of his works, it compresses an event of immense complexity to the scale of a family history, with a cast of characters that includes a bloodthirsty ogress and an antihero as believably flawed as any in mod', '141439602', 489, 'https://covers.openlibrary.org/b/isbn/0141439602-L.jpg', '2003-01-01', '9780141439600', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (125, 'The Count of Monte Cristo', 'Thrown in prison for a crime he has not committed, Edmond Dantes is confined to the grim fortress of If. There he learns of a great hoard of treasure hidden on the Isle of Monte Cristo and he becomes determined not only to escape, but also to unearth the treasure and use it to plot the destruction of the three men responsible for his incarceration. Dumas+IBk epic tale of suff', '140449264', 1276, 'https://covers.openlibrary.org/b/isbn/0140449264-L.jpg', '2003-01-01', '9780140449266', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (126, 'Where the Sidewalk Ends', 'Shel Silverstein, the New York Times bestselling author of The Giving Tree, A Light in the Attic, Falling Up, and Every Thing On It, has created a poetry collection that is outrageously funny and deeply profound.', '60513039', 176, 'https://covers.openlibrary.org/b/isbn/0060513039-L.jpg', '2002-01-01', '9780060513030', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (127, 'The Outsiders', 'The Outsiders is about two weeks in the life of a 14-year-old boy. The novel tells the story of Ponyboy Curtis and his struggles with right and wrong in a society in which he believes that he is an outsider. According to Ponyboy, there are two kinds of people in the world: greasers and socs. A soc (short for \"social\") has money, can get away with just about anything, and', '440967694', 192, 'https://covers.openlibrary.org/b/isbn/0440967694-L.jpg', '1997-01-01', '', 1, 1, '2022-05-31', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (128, 'Brave New World / Brave New World Revisited', 'The astonishing novel Brave New World, originally published in 1932, presents Aldous Huxley\'s vision of the future--of a world utterly transformed. Through the most efficient scientific and psychological engineering, people are genetically designed to be passive and therefore consistently useful to the ruling class. This powerful work of speculative fiction sheds a blazing', '60776099', 340, 'https://covers.openlibrary.org/b/isbn/0060776099-L.jpg', '2005-01-01', '9780060776091', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (129, 'Gone with the Wind', 'Scarlett O\'Hara, the beautiful, spoiled daughter of a well-to-do Georgia plantation owner, must use every means at her disposal to claw her way out of the poverty she finds herself in after Sherman\'s March to the Sea', '446675539', 1037, 'https://covers.openlibrary.org/b/isbn/0446675539-L.jpg', '1999-01-01', '9780446675536', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (130, 'The Picture of Dorian Gray', 'In this celebrated work Wilde forged a devastating portrait of the effects of evil and debauchery on a young aesthete in late-19th-century England. Combining elements of the Gothic horror novel and decadent French fiction, the book centers on a striking premise:', '194216527', 272, 'https://covers.openlibrary.org/b/isbn/0194216527-L.jpg', '2004-01-01', '', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (131, 'The Giving Tree', 'Every day the boy would come to the tree to eat her apples, swing from her branches, or slide down her trunk...and the tree was happy. But as the boy grew older he began to want more from the ', '60256656', 64, 'https://covers.openlibrary.org/b/isbn/0060256656-L.jpg', '1964-01-01', '9780060256654', 1, 1, '2022-05-31', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (132, 'The Kite Runner', 'The unforgettable, heartbreaking story of the unlikely friendship between a wealthy boy and the son of his father\'s servant, The Kite Runner is a beautifully crafted novel set in a country that is in the process of being destroyed. It is about the power of reading, the price of betrayal, and the possibility of redemption, and it is also about the power of fathers over sons', '1585473634', 371, 'https://covers.openlibrary.org/b/isbn/1585473634-L.jpg', '2004-01-01', '', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (133, 'Harry Potter and the Deathly Hallows (Harry Potter, #7)', 'It\'s no longer safe for Harry at Hogwarts, so he and his best friends, Ron and Hermione, are on the run. Professor Dumbledore has given them clues about what they need to do to defeat the dark wizard, Lord Voldemort, once and for all, but it\'s up to them to figure out what these hints and suggestions really mean. Their cross-country odyssey has them searching', '545139708', 759, 'https://covers.openlibrary.org/b/isbn/0545139708-L.jpg', '2007-01-01', '', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (134, 'The Chronicles of Narnia (Chronicles of Narnia, #1-7)', 'Journeys to the end of the world, fantastic creatures, and epic battles between good and evil+IBQ-what more could any reader ask for in one book? The book that has it all is The Lion, the Witch and the Wardrobe, written in 1949 by Clive Staples Lewis. But Lewis did not stop there. Six more books follow', '66238501', 767, 'https://covers.openlibrary.org/b/isbn/0066238501-L.jpg', '2014-01-01', '9780066238500', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (135, 'The Lord of the Rings', 'In ancient times the Rings of Power were crafted by the Elven-smiths, and Sauron, the Dark Lord, forged the One Ring, filling it with his own power so that he could rule all others. But the One Ring was taken from him, and though he sought it throughout Middle-earth', '618260242', 1216, 'https://covers.openlibrary.org/b/isbn/0618260242-L.jpg', '2005-01-01', '', 1, 1, '2022-05-31', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (136, 'The Catcher in the Rye', 'It\'s Christmas time and Holden Caulfield has just been expelled from yet another school. Fleeing the crooks at Pencey Prep, he pinballs around New York City seeking solace in fleeting encounters - shooting the bull with strangers in dive hotels, wandering alone round Central Park, getting beaten up by pimps and cut down by erstwhile girlfriends.', '316769177', 277, 'https://covers.openlibrary.org/b/isbn/0316769177-L.jpg', '2001-01-01', '9780316769174', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (137, 'To Kill a Mockingbird', 'The unforgettable novel of a childhood in a sleepy Southern town and the crisis of conscience that rocked it. \"To Kill A Mockingbird\" became both an instant bestseller and a critical success when it was first published in 1960. It went on to win the Pulitzer Prize in 1961 and was later made into an Academy Award-winning film, also a classic.', '60935464', 336, 'https://covers.openlibrary.org/b/isbn/0060935464-L.jpg', '2006-01-01', '', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (138, 'All the Light We Cannot See', 'Marie-Laure lives in Paris near the Museum of Natural History, where her father works. When she is twelve, the Nazis occupy Paris and father and daughter flee to the walled citadel of Saint-Malo, where Marie-Laure+IBk-s reclusive great uncle lives in a tall house by the sea. With them they carry what might be the museum+IBk-s most valuable and dangerous jewel.', '1476746583', 531, 'https://covers.openlibrary.org/b/isbn/1476746583-L.jpg', '2014-01-01', '9781476746586', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (139, 'Divergent (Divergent, #1)', 'In Beatrice Prior\'s dystopian Chicago world, society is divided into five factions, each dedicated to the cultivation of a particular virtue+IBQ-Candor (the honest), Abnegation (the selfless), Dauntless (the brave), Amity (the peaceful), and Erudite (the intelligent). On an appointed day of every year, all sixteen-year-olds must select the faction to which they will devote', '62024035', 487, 'https://covers.openlibrary.org/b/isbn/0062024035-L.jpg', '2012-01-01', '9780062024039', 1, 1, '2022-05-31', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (140, 'The Grapes of Wrath', 'First published in 1939, Steinbeck+IBk-s Pulitzer Prize-winning epic of the Great Depression chronicles the Dust Bowl migration of the 1930s and tells the story of one Oklahoma farm family, the Joads+IBQ-driven from their homestead and forced to travel west to', '067001690X', 479, 'https://covers.openlibrary.org/b/isbn/067001690X-L.jpg', '2014-01-01', '9780670016907', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (141, 'Ender\'s Game (Ender\'s Saga, #1)', 'Andrew \"Ender\" Wiggin thinks he is playing computer simulated war games; he is, in fact, engaged in something far more desperate. The result of genetic experimentation, Ender may be the military genius Earth desperately needs in a war against an alien enemy seeking to destroy all human life. The only way to find out is to throw Ender into ever harsher training, to chip awa', '812550706', 324, 'https://covers.openlibrary.org/b/isbn/0812550706-L.jpg', '2004-01-01', '9780812550702', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (142, 'Dune (Dune, #1)', 'Set on the desert planet Arrakis, Dune is the story of the boy Paul Atreides, heir to a noble family tasked with ruling an inhospitable world where the only thing of value is the +IBw-spice+IB0 melange, a drug capable of extending life and enhancing consciousness. Coveted across the known universe, melange is a prize worth killing', '059309932X', 658, 'https://covers.openlibrary.org/b/isbn/059309932X-L.jpg', '2019-01-01', '9780593099322', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (143, 'Dune Messiah (Dune Chronicles, #2)', 'Dune Messiah continues the story of Paul Atreides, better known--and feared--as the man christened Muad\'Dib. As Emperor of the Known Universe, he possesses more power than a single man was ever meant to wield. Worshipped as a religious icon by the fanatical Fremens, Paul faces', '593098234', 337, 'https://covers.openlibrary.org/b/isbn/0593098234-L.jpg', '2019-01-01', '9780593098233', 1, 1, '2022-05-31', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (144, 'The Great Gatsby', 'The Great Gatsby, F. Scott Fitzgerald\'s third book, stands as the supreme achievement of his career. This exemplary novel of the Jazz Age has been acclaimed by generations of readers. ', '684717603', 180, 'https://covers.openlibrary.org/b/isbn/0684717603-L.jpg', '2004-01-01', '', 1, 1, '2015-08-16', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (145, 'Of Mice and Men', 'They are an unlikely pair: George is \"small and quick and dark of face\"; Lennie, a man of tremendous size, has the mind of a young child. Yet they have formed a \"family,\" clinging together in the face of loneliness and alienation. Laborers in California\'s dusty vegetable fields, they hustle', '142000671', 112, 'https://covers.openlibrary.org/b/isbn/0142000671-L.jpg', '2002-01-01', '9780142000670', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (146, 'Fahrenheit 451', 'Sixty years after its original publication, Ray Bradbury+IBk-s internationally acclaimed novel Fahrenheit 451 stands as a classic of world literature set in a bleak, dystopian future. Today its message has grown more relevant than ever before.', '1982102608', 194, 'https://covers.openlibrary.org/b/isbn/1982102608-L.jpg', '2011-01-01', '', 1, 1, '2022-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (147, 'Freezing Order: A True Story of Money Laundering, Murder, and Surviving Vladimir Putin\'s Wrath', 'Following his explosive New York Times bestseller Red Notice, Bill Browder returns with another gripping thriller chronicling how he became Vladimir Putin\'s number one enemy by exposing Putin\'s campaign to steal and launder hundreds of billions of dollars and kill anyone who stands in his way.', '1982153288', 336, 'https://covers.openlibrary.org/b/isbn/1982153288-L.jpg', '2022-01-01', '9781982153281', 1, 1, '2022-05-29', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (148, 'The Ultimate Hitchhiker\'s Guide to the Galaxy (Hitchhiker\'s Guide to the Galaxy, #1-5)', 'Seconds before the Earth is demolished for a galactic freeway, Arthur Dent is saved by Ford Prefect, a researcher for the revised Guide. Together they stick out their thumbs to the stars and begin a wild journey through time an', '345453743', 815, 'https://covers.openlibrary.org/b/isbn/0345453743-L.jpg', '2002-01-01', '9780345453747', 1, 1, '2021-03-13', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (149, 'El León, La Bruja Y El Ropero - (Las Cronicas de Narnia)', 'This paperback edition features the original black-and-white illustrations by award-winning artist Pauline Baynes and stunning new cover art by Cliff Nielsen. The extraordinary first adventure of the Pevensie children in the land of Narnia is as enchanting in Spanish as it is in English.', '60086610', 206, 'https://covers.openlibrary.org/b/isbn/0060086610-L.jpg', '2005-01-01', '', 2, 1, '2015-08-16', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (150, 'The Diary of a Young Girl', 'Discovered in the attic in which she spent the last years of her life, Anne Frank+IBk-s remarkable diary has become a world classic+IBQ-a powerful reminder of the horrors of war and an eloquent testament to the human spirit.', '395459966', 283, 'https://covers.openlibrary.org/b/isbn/0395459966-L.jpg', '1993-01-01', '', 1, 1, '2015-08-16', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (151, 'Brave New World', 'Brave New World is a dystopian novel by English author Aldous Huxley, written in 1931 and published in 1932. Largely set in a futuristic World State, inhabited by genetically modified citizens and an intelligence-based social hierarchy, the novel anticipates huge scientific advancements in reproductive technology, sleep-learning, psychological manipulation and classical', '60929871', 268, 'https://covers.openlibrary.org/b/isbn/0060929871-L.jpg', '1998-01-01', '9780060929879', 1, 1, '2020-08-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (152, 'We Should All Be Feminists', 'What does +IBw-feminism+IB0 mean today? That is the question at the heart of We Should All Be Feminists, a personal, eloquently-argued essay+IBQ-adapted from her much-viewed TEDx talk of the same name+IBQ-by Chimamanda Ngozi Adichie, the award-winning author of Americanah and Half of a Yellow Sun.', '110191176X', 65, 'https://covers.openlibrary.org/b/isbn/110191176X-L.jpg', '2014-01-01', '', 1, 1, '2020-05-04', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (153, 'The Lost Colony (The Long Winter, #3)', 'On Eos, the last survivors of the Long Winter face their greatest challenge yet--and race to unravel the deepest secrets of the grid. It\'s a journey across space and time and into humanity\'s past and future--with a twist you\'ll never forget.', '1800241534', 380, 'https://covers.openlibrary.org/b/isbn/1800241534-L.jpg', '2019-01-01', '', 1, 1, '2020-10-10', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (154, 'The Solar War (The Long Winter, #2)', 'They decimated Earth during the Long Winter.', '1940026245', 498, 'https://covers.openlibrary.org/b/isbn/1940026245-L.jpg', '2019-01-01', '', 1, 1, '2020-10-10', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (155, 'Winter World (The Long Winter, #1)', 'Now the grid has returned, and they won\'t stop until the human race is extinct.', '1940026210', 418, 'https://covers.openlibrary.org/b/isbn/1940026210-L.jpg', '2019-01-01', '', 1, 1, '2020-10-10', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (156, 'The Fifth Season (The Broken Earth, #1)', 'Three terrible things happen in a single day. Essun, a woman living an ordinary life in a small town, comes home to find that her husband has brutally murdered their son and kidnapped their daughter. Meanwhile, mighty Sanze -- the world-spanning empire whose innovations have been civilization\'s bedrock for a thousand years ', '356508196', 468, 'https://covers.openlibrary.org/b/isbn/0356508196-L.jpg', '2015-01-01', '', 1, 1, '2020-08-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (157, 'The Master and Margarita', 'An audacious revision of the stories of Faust and Pontius Pilate, The Master and Margarita is recognized as one of the essential classics of modern Russian literature. The novel\'s vision of Soviet life in the 1930s is so ferociously accurate that it could not be published during its', '679760806', 372, 'https://covers.openlibrary.org/b/isbn/0679760806-L.jpg', '1996-01-01', '9780679760801', 1, 1, '2020-07-17', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (158, 'Team of Rivals: The Political Genius of Abraham Lincoln', 'Acclaimed historian Doris Kearns Goodwin illuminates Lincoln\'s political genius in this highly original work, as the one-term congressman and prairie lawyer rises from obscurity to prevail over three gifted rivals of national reputation to become president.', '684824906', 916, 'https://covers.openlibrary.org/b/isbn/0684824906-L.jpg', '2006-01-01', '', 1, 1, '2020-04-30', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (159, 'Sapiens: A Brief History of Humankind', 'How did our species succeed in the battle for dominance? Why did our foraging ancestors come together to create cities and kingdoms? How did we come to believe in gods, nations and human rights; to trust money, books and laws; and to be enslaved by bureaucracy, ', '771038518', 512, 'https://covers.openlibrary.org/b/isbn/0771038518-L.jpg', '2015-01-01', '', 1, 1, '2020-04-30', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (160, 'The Plague', 'A gripping tale of human unrelieved horror, of survival and resilience, and of the ways in which humankind confronts death, The Plague is at once a masterfully crafted novel, eloquently understated and epic in scope, and a parable of ageless moral resonance, profoundly relevant to our times. In Oran, a coastal town in North ', '140180206', 308, 'https://covers.openlibrary.org/b/isbn/0140180206-L.jpg', '1991-01-01', '', 1, 1, '2020-06-28', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (161, 'East of Eden', 'In his journal, Nobel Prize winner John Steinbeck called East of Eden +IBw-the first book,+IB0 and indeed it has the primordial power and simplicity of myth. Set in the rich farmland of California+IBk-s Salinas Valley, this sprawling and often brutal novel follows the intertwined destinies of two families+IBQ-the Trasks and the Hamiltons+IBQ-whose generations helplessly reenact the fall of', '142000655', 601, 'https://covers.openlibrary.org/b/isbn/0142000655-L.jpg', '2002-01-01', '9780142000656', 1, 1, '2020-05-31', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (162, 'A History of the World in 100 Objects', 'Neil MacGregor\'s A History of the World in 100 Objects takes a bold, original approach to human history, exploring past civilizations through the objects that defined them. Encompassing a grand sweep of human history, A History of the World in 100 Objects begins with one of the earliest surviving objects made by human hands, a chopping tool from the Olduvai gorge in Africa', '1846144132', 707, 'https://covers.openlibrary.org/b/isbn/1846144132-L.jpg', '2010-01-01', '9781846144134', 1, 1, '2020-05-14', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (163, 'A Thousand Splendid Suns', 'A Thousand Splendid Suns is a breathtaking story set against the volatile events of Afghanistan\'s last thirty years - from the Soviet invasion to the reign of the Taliban to post-Taliban rebuilding - that puts the violence, fear, hope, and faith of this country in intimate, human terms. It is a tale of two generations of characters brought jarringly together by the tragic', '1594489505', 372, 'https://covers.openlibrary.org/b/isbn/1594489505-L.jpg', '2007-01-01', '9781594489501', 1, 1, '2020-05-04', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (164, 'The Little Prince', 'A pilot stranded in the desert awakes one morning to see, standing before him, the most extraordinary little fellow. \"Please,\" asks the stranger, \"draw me a sheep.\" And the pilot realizes that when life\'s events are too difficult to understand, there is no choice but to succumb to their mysteries. He pulls out pencil and paper... And thus begins this wise and enchanting', '434961604', 96, 'https://covers.openlibrary.org/b/isbn/0434961604-L.jpg', '2000-01-01', '', 1, 1, '2020-05-04', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (165, 'QED: The Strange Theory of Light and Matter', 'Famous the world over for the creative brilliance of his insights into the physical world, Nobel Prize-winning physicist Richard Feynman also possessed an extraordinary talent for explaining difficult concepts to the nonscientist. QED--the edited version of four lectures on quantum electrodynamics that Feynman gave to the general public at UCLA as part of the Alix G.', '691024170', 158, 'https://covers.openlibrary.org/b/isbn/0691024170-L.jpg', '1988-01-01', '9780691024172', 1, 1, '2020-05-04', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (166, 'John Adams', 'In this powerful, epic biography, David McCullough unfolds the adventurous life-journey of John Adams, the brilliant, fiercely independent, often irascible, always honest Yankee patriot -- \"the colossus of independence,\" as Thomas Jefferson called him', '743223136', 751, 'https://covers.openlibrary.org/b/isbn/0743223136-L.jpg', '2001-01-01', '9780743223133', 1, 1, '2020-05-04', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (167, 'Bad Blood: Secrets and Lies in a Silicon Valley Startup', 'The full inside story of the breathtaking rise and shocking collapse of a multibillion-dollar startup, by the prize-winning journalist who first broke the story and pursued it to the end in the face of pressure and threats from the CEO and her lawyers.', '1509868070', 353, 'https://covers.openlibrary.org/b/isbn/1509868070-L.jpg', '2018-01-01', '', 1, 1, '2020-05-04', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (168, 'Enlightenment Now: The Case for Reason, Science, Humanism, and Progress', 'If you think the world is coming to an end, think again: people are living longer, healthier, freer, and happier lives, and while our problems are formidable, the solutions lie in the Enlightenment ideal of using reason and science.', '525427570', 576, 'https://covers.openlibrary.org/b/isbn/0525427570-L.jpg', '2018-01-01', '9780525427575', 1, 1, '2020-05-04', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (169, 'Hillbilly Elegy: A Memoir of a Family and Culture in Crisis', 'Hillbilly Elegy is a passionate and personal analysis of a culture in crisis+IBQ-that of white working-class Americans. The disintegration of this group, a process that has been slowly occurring now for more than forty years, has been reported with growing frequency and alarm, but has never before been written about as searingly from the inside. J. D. Vance tells the true', '62300547', 264, 'https://covers.openlibrary.org/b/isbn/0062300547-L.jpg', '2016-01-01', '9780062300546', 1, 1, '2020-05-04', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (170, 'Shoe Dog: A Memoir by the Creator of Nike', 'The full inside story of the breathtaking rise and shocking collapse of a multibillion-dollar startup, by the prize-winning journalist who first broke the story and pursued it to the end in the face of pressure and threats from the CEO and her lawyers.', '1501135910', 400, 'https://covers.openlibrary.org/b/isbn/1501135910-L.jpg', '2016-01-01', '9781501135910', 1, 1, '2020-05-04', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (171, 'Atlas Shrugged', 'Why did he have to fight his battle, not against his enemies, but against those who needed him most, and his hardest battle against the woman he loved? What is the world+IBk-s motor +IBQ and the motive power of every man? You will know the answer', '452011876', 1168, 'https://covers.openlibrary.org/b/isbn/0452011876-L.jpg', '1999-01-01', '9780452011878', 1, 1, '2020-04-30', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (172, 'The Fountainhead', 'The revolutionary literary vision that sowed the seeds of Objectivism, Ayn Rand\'s groundbreaking philosophy, and brought her immediate worldwide acclaim.', '586012648', 704, 'https://covers.openlibrary.org/b/isbn/0586012648-L.jpg', '1996-01-01', '', 1, 1, '2020-04-30', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (173, 'Elon Musk: Tesla, SpaceX, and the Quest for a Fantastic Future', 'Elon Musk, the entrepreneur and innovator behind SpaceX, Tesla, and SolarCity, sold one of his internet companies, PayPal, for $1.5 billion. Ashlee Vance captures the full spectacle and arc of the genius\'s life and work, from his tumultuous upbringing in South Africa and flight to the United States to his dramatic technical innovations and entrepreneurial pursuits.', '62301268', 416, 'https://covers.openlibrary.org/b/isbn/0062301268-L.jpg', '2015-01-01', '9780062301260', 1, 1, '2015-08-16', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (174, 'Bold: How to Go Big, Create Wealth and Impact the World', 'From the coauthors of the New York Times bestseller Abundance comes their much anticipated follow-up: Bold+IBQ-a radical, how-to guide for using exponential technologies, moonshot thinking, and crowd-powered tools to create extraordinary wealth while also positively impacting the lives of billions.', '1476709564', 336, 'https://covers.openlibrary.org/b/isbn/1476709564-L.jpg', '2015-01-01', '9781476709567', 1, 1, '2015-08-16', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (175, 'The Hot Zone: The Terrifying True Story of the Origins of the Ebola Virus', 'A highly infectious, deadly virus from the central African rain forest suddenly appears in the suburbs of Washington, D.C. There is no cure. In a few days 90 percent of its victims are dead. A secret military SWAT team of soldiers and scientists is mobilized to stop the outbreak of this exotic \"hot\" virus. The Hot Zone tells this dramatic story, giving a hair-raising accou', '385495226', 352, 'https://covers.openlibrary.org/b/isbn/0385495226-L.jpg', '1999-01-01', '9780385495226', 1, 1, '2015-08-16', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (176, 'A Brief History of Time', 'In the ten years since its publication in 1988, Stephen Hawking\'s classic work has become a landmark volume in scientific writing, with more than nine million copies in forty languages sold worldwide. That edition was on the cutting edge of what was then known about the origins and nature of the universe.', '553380168', 213, 'https://covers.openlibrary.org/b/isbn/0553380168-L.jpg', '1998-01-01', '9780553380163', 1, 1, '2015-08-16', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (177, 'The God Delusion', 'A preeminent scientist - and the world\'s most prominent atheist - asserts the irrationality of belief in God, and the grievous harm religion has inflicted on society, from the Crusades to 9/11.', '618680004', 374, 'https://covers.openlibrary.org/b/isbn/0618680004-L.jpg', '2006-01-01', '9780618680009', 1, 1, '2015-08-16', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (178, 'The Old Man and the Sea', 'This short novel, already a modern classic, is the superbly told, tragic story of a Cuban fisherman in the Gulf Stream and the giant Marlin he kills and loses+IBQ-specifically referred to in the citation accompanying the author\'s Nobel Prize for literature in 1954', '684830493', 96, 'https://covers.openlibrary.org/b/isbn/0684830493-L.jpg', '1996-01-01', '9780684830490', 1, 1, '2015-08-16', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (179, 'The Intelligent Investor', 'The greatest investment advisor of the twentieth century, Benjamin Graham taught and inspired people worldwide. Graham\'s philosophy of \"value investing\" -- which shields investors from substantial erro', '60555661', 623, 'https://covers.openlibrary.org/b/isbn/0060555661-L.jpg', '2006-01-01', '9780060555665', 1, 1, '2015-08-16', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (180, 'The Ascent of Money: A Financial History of the World', 'Niall Ferguson follows the money to tell the human story behind the evolution of finance, from its origins in ancient Mesopotamia to the latest upheavals on what he calls Planet Finance. Bread, cash, dosh, dough, loot, lucre, moolah, readies, the wherewithal: Call it what you like, it matters. To Christians, love of it is the root of all evil. ', '1594201927', 442, 'https://covers.openlibrary.org/b/isbn/1594201927-L.jpg', '2008-01-01', '9781594201929', 1, 1, '2015-08-16', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (181, 'The World Is Flat: A Brief History of the Twenty-first Century', 'When scholars write the history of the world twenty years from now, and they come to the chapter Y2K to March 2004 , what will they say was the most crucial development? The attacks on the World Trade Center on 9/11 and the Iraq war? Or the convergence of technology and events that allowed India, China, and so many other countries to become part of the global supply chain', '374292795', 593, 'https://covers.openlibrary.org/b/isbn/0374292795-L.jpg', '2006-01-01', '9780374292799', 1, 1, '2015-08-16', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (182, 'Zero to One: Notes on Startups, or How to Build the Future', 'The great secret of our time is that there are still uncharted frontiers to explore and new inventions to create. In Zero to One, legendary entrepreneur and investor Peter Thiel shows how we can find singular ways to create those new things.', '804139296', 195, 'https://covers.openlibrary.org/b/isbn/0804139296-L.jpg', '2014-01-01', '9780804139298', 1, 1, '2015-08-16', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (183, 'The Big Short: Inside the Doomsday Machine', 'The real story of the crash began in bizarre feeder markets where the sun doesn\'t shine and the SEC doesn\'t dare, or bother, to tread: the bond and real estate derivative markets where geeks invent i', '393338827', 291, 'https://covers.openlibrary.org/b/isbn/0393338827-L.jpg', '2011-01-01', '9780393338829', 1, 1, '2015-08-16', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (184, 'Delivering Happiness: A Path to Profits, Passion, and Purpose', 'You want to learn about the path that we took at Zappos to get to over $1 billion in gross merchandise sales in less than ten years. You want to learn about the path I took that eventually led me to Zappos, and the lessons I learned along the way. You want to learn from all the mistakes we made at Zappos over the years so that your business can avoid making some of the sam', '446563048', 246, 'https://covers.openlibrary.org/b/isbn/0446563048-L.jpg', '2010-01-01', '9780446563048', 1, 1, '2015-08-16', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (185, 'Outliers: The Story of Success', 'In this stunning book, Malcolm Gladwell takes us on an intellectual journey through the world of \"outliers\"--the best and the brightest, the most famous and the most successful. He asks the question: what makes high-achievers ', '316017922', 309, 'https://covers.openlibrary.org/b/isbn/0316017922-L.jpg', '2008-01-01', '9780316017923', 1, 1, '2015-08-16', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (186, 'Freakonomics: A Rogue Economist Explores the Hidden Side of Everything', 'Which is more dangerous, a gun or a swimming pool? What do schoolteachers and sumo wrestlers have in common? Why do drug dealers still live with their moms? How much do parents really matter? What kind of impact did Roe v. Wade have on violent crime? Freakonomics will literally redefine the way we view the modern world.', '61234001', 268, 'https://covers.openlibrary.org/b/isbn/0061234001-L.jpg', '2006-01-01', '9780061234002', 1, 1, '2015-08-16', NULL, 1);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (187, 'The Tipping Point: How Little Things Can Make a Big Difference', 'The tipping point is that magic moment when an idea, trend, or social behavior crosses a threshold, tips, and spreads like wildfire. Just as a single sick person can start an epidemic of the flu, so too can a small but precisely targeted push cause a fashion trend, the popularity of a new product, or a drop in the crime rate. This wid', '316346624', 301, 'https://covers.openlibrary.org/b/isbn/0316346624-L.jpg', '2002-01-01', '9780316346627', 1, 1, '2015-08-16', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (188, 'Decision Points', 'George W. Bush served as president of the United States during eight of the most consequential years in American history. The decisions that reached his desk impacted people around the world and defined the times in which we live.', '307590615', 497, 'https://covers.openlibrary.org/b/isbn/0307590615-L.jpg', '2010-01-01', '9780307590619', 1, 1, '2015-08-16', NULL, 0);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`, `enabled`) VALUES (189, 'The Last Lecture', 'A lot of professors give talks titled \'The Last Lecture\'. Professors are asked to consider their demise and to ruminate on what matters most to them: What wisdom would we impart to the world if we knew it was our last chance? If we had to vanish tomorrow, what would we want as our legacy?', '1401323251', 206, 'https://covers.openlibrary.org/b/isbn/1401323251-L.jpg', '2008-01-01', '9781401323257', 1, 1, '2015-08-16', NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `category`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `category` (`id`, `name`, `description`, `img_url`) VALUES (1, 'Fiction', 'literature in the form of prose, especially short stories and novels, that describes imaginary events and people.', 'https://cdn.pixabay.com/photo/2017/09/10/14/24/manipulation-2735724_960_720.jpg');
INSERT INTO `category` (`id`, `name`, `description`, `img_url`) VALUES (2, 'Business', NULL, NULL);
INSERT INTO `category` (`id`, `name`, `description`, `img_url`) VALUES (3, 'Classics', NULL, NULL);
INSERT INTO `category` (`id`, `name`, `description`, `img_url`) VALUES (4, 'Contemporary', NULL, NULL);
INSERT INTO `category` (`id`, `name`, `description`, `img_url`) VALUES (5, 'Biography', NULL, NULL);
INSERT INTO `category` (`id`, `name`, `description`, `img_url`) VALUES (6, 'History', NULL, NULL);
INSERT INTO `category` (`id`, `name`, `description`, `img_url`) VALUES (7, 'Humor and Comedy', NULL, NULL);
INSERT INTO `category` (`id`, `name`, `description`, `img_url`) VALUES (8, 'Nonfiction', NULL, NULL);
INSERT INTO `category` (`id`, `name`, `description`, `img_url`) VALUES (9, 'Travel', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `author`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (1, 'John Ronald Reuel Tolkien', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (2, 'David Mitchell', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (3, 'Gary Paulsen', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (4, 'James Clavell', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (5, 'Stephen King', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (6, 'J.K. Rowling', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (7, 'Mary GrandPré', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (8, 'Arthur  Miller', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (9, 'Ernest Hemingway', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (10, 'Diana Gabaldon', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (11, 'Jared Diamond', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (12, 'Bill Bryson', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (13, 'Jon Krakauer', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (14, 'Rick Riordan', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (15, 'Tim O\'Brien', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (16, 'Alex Haley', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (17, 'Mario Puzo', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (18, 'Robert Thompson', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (19, 'Peter Bart', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (20, 'Alexandre Dumas', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (21, 'Richard Pevear', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (22, 'Philip Bates', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (23, 'Agatha Christie', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (24, 'Wilson Rawls', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (25, 'Corrie ten Boom', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (26, 'John Sherrill', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (27, 'Elizabeth Sherrill', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (28, 'Maya Angelou', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (29, 'Erich Maria Remarque', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (30, 'Arthur Wesley Wheen', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (31, 'Anthony Burgess', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (32, 'Margaret Atwood', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (33, 'Charles Dickens', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (35, 'Robin Buss', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (36, 'Shel Silverstein', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (37, 'S.E. Hinton', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (38, 'Aldous Huxley', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (39, 'Christopher Hitchens', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (40, 'Margaret Mitchell', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (41, 'Oscar Wilde', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (42, 'Martha Something', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (43, 'Shel Silverstein', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (44, 'Khaled Hosseini', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (46, 'C.S. Lewis', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (47, 'Pauline Baynes', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (48, 'J.R.R. Tolkien', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (49, 'J.D. Salinger', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (50, 'Harper Lee', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (51, 'Anthony Doerr', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (52, 'Veronica Roth', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (53, 'John Steinbeck', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (54, 'Orson Scott Card', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (55, 'Frank Herbert', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (57, 'F. Scott Fitzgerald', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (59, 'Ray Bradbury', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (60, 'Bill Browder', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (61, 'Douglas Adams', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (63, 'Anne Frank', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (65, 'Chimamanda Ngozi Adichie', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (66, 'A.G. Riddle', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (69, 'N.K. Jemisin', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (70, 'Mikhail Bulgakov', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (71, 'Doris Kearns Goodwin', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (72, 'Yuval Noah Harari', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (73, 'Albert Camus', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (75, 'Neil MacGregor', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (77, 'Antoine de Saint-Exupery', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (78, 'Richard P. Feynman', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (79, 'David McCullough', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (80, 'John Carreyrou', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (81, 'Steven Pinker', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (82, 'J.D. Vance', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (83, 'Phil Knight', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (84, 'Ayn Rand', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (86, 'Ashlee Vance', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (87, 'Peter H. Diamandis', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (88, 'Richard   Preston', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (89, 'Stephen Hawking', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (90, 'Richard Dawkins', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (92, 'Benjamin Graham', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (93, 'Niall Ferguson', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (94, 'Thomas L. Friedman', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (95, 'Peter Thiel', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (96, 'Michael   Lewis', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (97, 'Tony Hsieh', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (98, 'Malcolm Gladwell', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (99, 'Steven D. Levitt', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (101, 'George W. Bush', 1);
INSERT INTO `author` (`id`, `full_name`, `enabled`) VALUES (102, 'Randy Pausch', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `post`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `post` (`id`, `content`, `title`, `post_date`, `enabled`, `user_id`) VALUES (1, 'I am here to help. If you have questions or comments, fee free to share.', 'Admin is here to assist!', '2022-05-25 15:10:01 ', 1, 1);
INSERT INTO `post` (`id`, `content`, `title`, `post_date`, `enabled`, `user_id`) VALUES (2, 'I\'m a huge Tolkien fan, but I\'ve only ever watched the movies. I am going to start reading the books and am super excited', 'Tolkien Fan seeking help', '2022-05-25 15:11:34', 1, 3);
INSERT INTO `post` (`id`, `content`, `title`, `post_date`, `enabled`, `user_id`) VALUES (3, 'I would like to find something new to read. I\'m always wanting to learn new things', 'Seeking knowledge', '2022-06-01 17:11:02', 1, 4);
INSERT INTO `post` (`id`, `content`, `title`, `post_date`, `enabled`, `user_id`) VALUES (4, 'Lorem ipsum dolor sit amet, no malis vocent repudiare per. Ea virtute deterruisset qui, inermis consequat id nec. Qui suas unum scribentur no. Alia dicat dolore per eu, ut mutat splendide per.\n\nCum ubique quaestio evertitur ex, at est sumo everti. Omittam petentium maiestatis no vix, natum aliquam accusata sea ei, an solum exerci per. His consul eleifend at. Ea vix iriure latine imperdiet, pri in illud iudico doming. Quo et eius volumus cotidieque. Ex mandamus pericula per, prompta persecuti ex per, eu libris patrioque eos.\n\nVolutpat laboramus et duo. Vitae epicuri mea ex, eum at prompta vivendum eloquentiam. Veniam delenit eu eum. Aliquam ceteros no vis.\n\nAd eum veniam assueverit. At pro eleifend euripidis dissentiet, vel perfecto interesset definitionem no. Et cum vitae tibique, in idque ridens consectetuer vim. Id eum eius dicat eruditi. Ius ignota aliquando te, per te vidit tibique, veri nobis lucilius id per.\n\nGraece meliore ei pri. Ius in exerci interesset, choro oporteat invenire vix te. Ea labores ullamcorper vel. Et nam alterum atomorum intellegam, soluta appetere ocurreret mei ut. Tamquam sapientem no est, bonorum corpora complectitur ne has.', 'Through reading I\'ll never encounter a new problem.', '2022-06-01 17:33:32', 1, 5);
INSERT INTO `post` (`id`, `content`, `title`, `post_date`, `enabled`, `user_id`) VALUES (5, 'Can make book out of rocks?!', 'rock?', '2022-06-01 17:43:21', 1, 2);
INSERT INTO `post` (`id`, `content`, `title`, `post_date`, `enabled`, `user_id`) VALUES (6, 'Change your life forever!!!! CLICK HERE------------->https://skilldistillery.com/full-stack-java-bootcamp/<--------------------------', NULL, '2022-06-01 17:45:39', 1, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `comment` (`id`, `content`, `comment_date`, `enabled`, `user_id`, `post_id`, `in_reply_to_id`) VALUES (1, 'That\'s huge!!! Get ready for an adventure!', '2022-05-25  15:10:10 ', 1, 1, 2, NULL);
INSERT INTO `comment` (`id`, `content`, `comment_date`, `enabled`, `user_id`, `post_id`, `in_reply_to_id`) VALUES (2, 'But be aware that they kind of read like Winnie the Pooh', '2022-05-25 15:11:30', 1, 1, 2, 1);
INSERT INTO `comment` (`id`, `content`, `comment_date`, `enabled`, `user_id`, `post_id`, `in_reply_to_id`) VALUES (3, 'Change your life forever!!!! CLICK HERE------------->https://skilldistillery.com/full-stack-java-bootcamp/<--------------------------', '2022-06-01 18:01:02', 1, 6, 1, NULL);
INSERT INTO `comment` (`id`, `content`, `comment_date`, `enabled`, `user_id`, `post_id`, `in_reply_to_id`) VALUES (4, 'Change your life forever!!!! CLICK HERE------------->https://skilldistillery.com/full-stack-java-bootcamp/<--------------------------', '2022-06-01 18:01:02', 1, 6, 2, NULL);
INSERT INTO `comment` (`id`, `content`, `comment_date`, `enabled`, `user_id`, `post_id`, `in_reply_to_id`) VALUES (5, 'Change your life forever!!!! CLICK HERE------------->https://skilldistillery.com/full-stack-java-bootcamp/<--------------------------', '2022-06-01 18:01:02', 1, 6, 3, NULL);
INSERT INTO `comment` (`id`, `content`, `comment_date`, `enabled`, `user_id`, `post_id`, `in_reply_to_id`) VALUES (6, 'Change your life forever!!!! CLICK HERE------------->https://skilldistillery.com/full-stack-java-bootcamp/<--------------------------', '2022-06-01 18:01:02', 1, 6, 4, NULL);
INSERT INTO `comment` (`id`, `content`, `comment_date`, `enabled`, `user_id`, `post_id`, `in_reply_to_id`) VALUES (7, 'Change your life forever!!!! CLICK HERE------------->https://skilldistillery.com/full-stack-java-bootcamp/<--------------------------', '2022-06-01 18:01:02', 1, 6, 5, NULL);
INSERT INTO `comment` (`id`, `content`, `comment_date`, `enabled`, `user_id`, `post_id`, `in_reply_to_id`) VALUES (8, 'Change your life forever!!!! CLICK HERE------------->https://skilldistillery.com/full-stack-java-bootcamp/<--------------------------', '2022-06-01 18:01:02', 1, 6, 6, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `question`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `question` (`id`, `content`, `question_date`, `enabled`, `user_id`, `book_id`) VALUES (1, 'Should I read The Hobbit if I\'ve already watched the movie?', '2022-05-25', 1, 2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `answer`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `answer` (`id`, `content`, `answer_date`, `enabled`, `user_id`, `question_id`, `in_reply_to_id`) VALUES (1, 'Absolutely you should!', '2022-05-25', 1, 1, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `review`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `review` (`id`, `content`, `rating`, `enabled`, `title`, `review_date`, `user_id`, `book_id`) VALUES (1, 'Honestly, way better than the films. Like did the director even read this?', 5, 1, 'The Hobbit is WAY BETTER as a book', '2022-05-25', 1, 1);
INSERT INTO `review` (`id`, `content`, `rating`, `enabled`, `title`, `review_date`, `user_id`, `book_id`) VALUES (2, 'In terms of western relations in Vladimir Putin, Bill Browder has performed the role of the canary in the coalmine – or perhaps goldmine would be more fitting. A graduate of Stanford Business School, he arrived in Moscow in the late 1990s, via a stint in London, determined to make his fortune.\r\nAs his previous book, Red Notice, detailed, that’s exactly what he did. He set up Hermitage Capital Management, with the help of the Monaco-based billionaire Edmond Safra (later to die in a fire started by one of his servants).\r\nIt was a time of wild profiteering, as post-Soviet state assets were sold off on the cheap, and a venal oligarchy was created. Business feuds were regularly settled by bullets, and the life expectancy of bankers was radically shortened. When Putin came to power on New Year’s Eve 1999, promising to stamp out corruption, Browder was a relieved man.\r\nAnd he remained pro-Putin for the next three years, as the new Russian leader imposed state order on capitalist anarchy. In these years, Browder made a fortune, turning Hermitage into the largest foreign portfolio investor in Russia. His big innovation was shareholder activism, in which he targeted corrupt practices in some of the biggest companies, such as Gazprom, and by doing so raised their share price.\r\n', 5, 1, 'Freezing Order reviewed', '2022-06-01', 4, 147);
INSERT INTO `review` (`id`, `content`, `rating`, `enabled`, `title`, `review_date`, `user_id`, `book_id`) VALUES (3, 'Browder’s analysis is not burdened by subtlety. In his storytelling, there are good guys driven by a thirst for justice and bad guys motivated by greed. For Browder, the baddies are less the Russian officials in question than their enablers in the West, including the improbably named American lawyer John Moscow, who after giving legal advice to Browder ended up representing Prevezon against the U.S. government; Glenn Simpson, a former journalist who founded the investigation firm Fusion GPS and who, Browder writes, provided information about him to the Russians; and Dana Rohrabacher, a mild-mannered Republican congressman from California who, House GOP leader Kevin McCarthy privately asserted, had accepted money from Putin. After 15 terms in the House, Rohrabacher was defeated in 2018. Browder is far from a dispassionate narrator of “Freezing Order.” Indeed, one strength of the work is the passion he brings to the tale.', 5, 1, 'How Russia fought a U.S. rights law ', '2022-06-01', 5, 147);
INSERT INTO `review` (`id`, `content`, `rating`, `enabled`, `title`, `review_date`, `user_id`, `book_id`) VALUES (4, 'Me like book, but confuzing for caveman', 4, 1, 'War no scare cave people', '2022-06-01', 2, 147);
INSERT INTO `review` (`id`, `content`, `rating`, `enabled`, `title`, `review_date`, `user_id`, `book_id`) VALUES (5, 'Browder is an American-born British financier who invested in Russia in the 1990s as the country was privatizing many businesses. His Hermitage Fund emerged as the one of the largest foreign investors in Russia in the early 2000s. As a minority investor in some of Russia’s largest companies, Browder became concerned when his investments suffered because of the fraud and corruption of the majority shareholders, many of whom had close ties to the Kremlin. After revealing the details of the shenanigans, he was barred from Russia in 2005 and was declared a threat to national security.\r\n\r\n“Freezing Order” is a sequel to Browder’s earlier bestseller, “Red Notice: A True Story of High Finance, Murder, and One Man’s Fight for Justice,” which told the tale of Sergei Magnitsky, a lawyer working for Browder’s Moscow investment firm. Magnitsky uncovered a $230 million tax fraud, was arrested by Russian officials to cover up the crime and died in a notorious Moscow prison at age 37 in 2009. The earlier book recounted Browder’s dogged efforts to create a new legal instrument to go after the wealth and mobility of individual perpetrators of human rights violations, rather than target the governments in whose name they claimed to act. “Red Notice” culminated with Congress passing the Magnitsky Act in 2012, landmark legislation that allows for travel bans, asset seizures and visa freezes on human rights violators. The legislation has been copied in more than 30 countries and now is used against a range of individuals with ties to China, Venezuela and Myanmar, among other nations.\r\n', 3, 1, 'Pretty politically motivated', '2022-06-01', 3, 147);
INSERT INTO `review` (`id`, `content`, `rating`, `enabled`, `title`, `review_date`, `user_id`, `book_id`) VALUES (6, 'Click here to change your life ---------------------->https://skilldistillery.com/full-stack-java-bootcamp/<------------------------------', 2, 1, NULL, '2022-06-01', 6, 147);
INSERT INTO `review` (`id`, `content`, `rating`, `enabled`, `title`, `review_date`, `user_id`, `book_id`) VALUES (7, 'Click here to change your life ---------------------->https://skilldistillery.com/full-stack-java-bootcamp/<------------------------------', 4, 1, NULL, '2022-06-01', 6, 134);

COMMIT;


-- -----------------------------------------------------
-- Data for table `wishlist`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `wishlist` (`user_id`, `book_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `currently_reading`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `currently_reading` (`user_id`, `book_id`) VALUES (1, 1);
INSERT INTO `currently_reading` (`user_id`, `book_id`) VALUES (2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `finished`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `finished` (`user_id`, `book_id`) VALUES (1, 2);
INSERT INTO `finished` (`user_id`, `book_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `book_to_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (1, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (2, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (3, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (4, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (101, 5);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (102, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (103, 8);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (104, 2);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (105, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (106, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (107, 8);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (108, 9);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (109, 7);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (110, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (111, 5);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (112, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (113, 7);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (114, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (115, 8);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (116, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (117, 8);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (118, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (119, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (120, 9);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (121, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (122, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (123, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (124, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (125, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (126, 2);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (127, 2);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (128, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (129, 7);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (130, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (131, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (132, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (133, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (134, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (135, 6);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (136, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (137, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (138, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (139, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (140, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (141, 9);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (142, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (143, 8);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (144, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (145, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (146, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (147, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (148, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (149, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (150, 5);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (151, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (152, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (153, 2);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (154, 8);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (155, 7);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (156, 8);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (157, 9);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (158, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (159, 8);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (160, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (161, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (162, 8);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (163, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (164, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (165, 8);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (166, 5);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (167, 8);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (168, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (169, 5);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (170, 5);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (171, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (172, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (173, 5);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (174, 7);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (175, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (176, 8);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (177, 2);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (178, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (179, 8);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (180, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (181, 6);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (182, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (183, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (184, 7);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (185, 6);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (186, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (187, 9);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (188, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (189, 6);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (5, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (6, 7);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (7, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (8, 5);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (9, 9);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (10, 9);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (11, 9);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (12, 8);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (13, 9);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (14, 7);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (15, 7);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (16, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (17, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (18, 5);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (19, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (20, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (21, 8);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (22, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (23, 2);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (24, 7);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (25, 3);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (26, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (27, 2);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (28, 8);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (29, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (30, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (31, 4);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (32, 8);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (33, 9);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (34, 1);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (35, 2);
INSERT INTO `book_to_category` (`book_id`, `category_id`) VALUES (36, 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `author_to_book`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (1, 1);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (1, 2);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (1, 3);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (1, 4);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (2, 101);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (3, 102);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (4, 103);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (5, 104);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (6, 105);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (6, 133);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (7, 105);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (8, 106);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (9, 107);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (9, 178);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (10, 108);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (11, 109);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (12, 110);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (13, 111);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (14, 112);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (15, 113);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (16, 114);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (17, 115);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (18, 115);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (19, 115);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (20, 116);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (20, 125);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (21, 116);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (22, 116);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (23, 117);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (24, 118);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (25, 119);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (26, 119);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (27, 119);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (28, 120);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (29, 121);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (30, 121);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (31, 122);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (32, 123);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (33, 124);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (35, 125);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (36, 126);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (37, 127);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (38, 128);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (38, 151);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (39, 128);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (40, 129);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (41, 130);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (42, 130);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (43, 131);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (44, 132);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (44, 163);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (46, 134);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (46, 149);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (47, 134);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (48, 135);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (49, 136);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (50, 137);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (51, 138);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (52, 139);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (53, 140);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (53, 145);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (53, 161);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (54, 141);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (55, 142);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (55, 143);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (57, 144);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (59, 146);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (60, 147);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (61, 148);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (63, 150);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (65, 152);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (66, 153);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (66, 154);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (66, 155);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (69, 156);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (70, 157);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (71, 158);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (72, 159);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (73, 160);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (75, 162);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (77, 164);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (78, 165);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (79, 166);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (80, 167);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (81, 168);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (82, 169);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (83, 170);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (84, 171);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (84, 172);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (86, 173);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (87, 174);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (88, 175);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (89, 176);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (90, 177);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (92, 179);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (93, 180);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (94, 181);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (95, 182);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (96, 183);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (97, 184);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (98, 185);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (98, 187);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (99, 186);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (101, 188);
INSERT INTO `author_to_book` (`author_id`, `book_id`) VALUES (102, 189);

COMMIT;


-- -----------------------------------------------------
-- Data for table `answer_vote`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `answer_vote` (`answer_id`, `user_id`, `vote`) VALUES (1, 2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `post_vote`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `post_vote` (`post_id`, `user_id`, `vote`) VALUES (1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment_vote`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `comment_vote` (`user_id`, `comment_id`, `vote`) VALUES (2, 1, 1);
INSERT INTO `comment_vote` (`user_id`, `comment_id`, `vote`) VALUES (2, 2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite_categories`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `favorite_categories` (`user_id`, `category_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite_authors`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `favorite_authors` (`user_id`, `author_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `follow_list`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `follow_list` (`user_id`, `follow_to_user_id`) VALUES (2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite_book`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `favorite_book` (`user_id`, `book_id`) VALUES (1, 1);

COMMIT;

