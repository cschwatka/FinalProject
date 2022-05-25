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
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `post` ;

CREATE TABLE IF NOT EXISTS `post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NOT NULL,
  `title` VARCHAR(45) NULL,
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

COMMIT;


-- -----------------------------------------------------
-- Data for table `language`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `language` (`id`, `name`) VALUES (1, 'English');

COMMIT;


-- -----------------------------------------------------
-- Data for table `book`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (1, 'The Fellowship of the Ring', 'Presents the epic depicting the Great War of the Ring, a struggle between good and evil in Middle Earth.', '0618129022', 1137, 'https://books.google.com/books/publisher/content/images/frontcover/ptHZAAAAMAAJ?fife=w400-h600&source=gbs_api', '2001-01-01', '9780618129027', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (2, 'The Hobbit Or There and Back Again', 'Celebrating 75 years of one of the world\'s most treasured classics with an all new trade paperback edition. Repackaged with new cover art. 500,000 first printing.', '054792822X', 300, 'https://books.google.com/books/publisher/content/images/frontcover/LLSpngEACAAJ?fife=w400-h600&source=gbs_api', '2012-01-01', '9780547928227', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (3, 'The Two Towers', 'This title is also available as a film as a film - Part 2 of The lord of the rings.', '026110358X', 322, 'https://books.google.com/books/publisher/content/images/frontcover/_yI_c7_c4ZMC?fife=w400-h600&source=gbs_api', '1997-01-01', '9780261103580', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (4, 'The Return of the King', 'Concluding the story begun in The Hobbit, this is the final part of Tolkien s epic masterpiece, The Lord of the Rings, featuring an exclusive cover image from the film, the definitive text, and a detailed map of Middle-earth. The armies of the Dark Lord Sauron are massing as his evil shadow spreads ever wider. Men, Dwarves, Elves and Ents unite forces to do battle agains the Dark. Meanwhile, Frodo and Sam struggle further into Mordor in their heroic quest to destroy the One Ring. The devastating conclusion of J.R.R. Tolkien s classic tale of magic and adventure, begun in The Fellowship of the Ring and The Two Towers, features the definitive edition of the text and includes the Appendices and a revised Index in full. To celebrate the release of the first of Peter Jackson s two-part film adaptation of The Hobbit, THE HOBBIT: AN UNEXPECTED JOURNEY, this third part of The Lord of the Rings is available for a limited time with an exclusive cover image from Peter Jackson s award-winning trilogy.', '0007488343', 624, 'https://books.google.com/books/publisher/content/images/frontcover/1EcBuwAACAAJ?fife=w400-h600&source=gbs_api', '2012-01-01', '9780007488346', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (5, 'Automate the Boring Stuff with Python', 'If you+IBk-ve ever spent hours renaming files or updating hundreds of spreadsheet cells, you know how tedious tasks like these can be. But what if you could have your computer do them for you? In Automate the Boring Stuff with Python, you+IBk-ll learn how to use Python to write programs that do in minutes what would take you hours to do by hand+IBQ-no prior programming experience required. Once you+IBk-ve mastered the basics of programming, you+IBk-ll create Python programs that effortlessly perform useful and impressive feats of automation to: +IBM-Search for text in a file or across multiple files +IBM-Create, update, move, and rename files and folders +IBM-Search the Web and download online content +IBM-Update and format data in Excel spreadsheets of any size +IBM-Split, merge, watermark, and encrypt PDFs +IBM-Send reminder emails and text notifications +IBM-Fill out online forms Step-by-step instructions walk you through each program, and practice projects at the end of each chapter challenge you to improve those programs and use your newfound skills to automate similar tasks. Don+IBk-t spend your time doing work a well-trained monkey could do. Even if you+IBk-ve never written a line of code, you can make your computer do the grunt work. Learn how in Automate the Boring Stuff with Python. Note: The programs in this book are written to run on Python 3.', '1593276850', 504, 'https://books.google.com/books/publisher/content/images/frontcover/8AcvDwAAQBAJ?fife=w400-h600&source=gbs_api', '2015-04-14', '9781593276850', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (6, 'Drawdown', 'NEW YORK TIMES BESTSELLER For the first time ever, an international coalition of leading researchers, scientists and policymakers has come together to offer a set of realistic and bold solutions to climate change. All of the techniques described here - some well-known, some you may have never heard of - are economically viable, and communities throughout the world are already enacting them. From revolutionizing how we produce and consume food to educating girls in lower-income countries, these are all solutions which, if deployed collectively on a global scale over the next thirty years, could not just slow the earth\'s warming, but reach drawdown: the point when greenhouse gasses in the atmosphere peak and begin todecline. So what are we waiting for?', '141988444', 256, 'https://books.google.com/books/publisher/content/images/frontcover/QhlADwAAQBAJ?fife=w400-h600&source=gbs_api', '2018-02-22', '9780141988443', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (7, 'Accidentally Wes Anderson', 'Wes Anderson\'s beloved films announce themselves through a singular aesthetic - one that seems too vivid, unique, and meticulously constructed to possibly be real. Not so - in Accidentally Wes Anderson, Wally Koval collects the world\'s most Anderson-like sites in all their faded grandeur and pop-pastel colours, telling the story behind each stranger than-fiction-location. Based on the viral online phenomenon and community of the same name, Accidentally Wes Anderson celebrates the unique aesthetic that millions of Anderson fans love - capturing the symmetrical, the atypical, the unexpected, the vibrantly patterned, and distinctively coloured in arresting photographs from around the world. Authorised by Wes Anderson himself, and appealing to the millions who love his films, this book is also for fans of Cabin Porn and Van Life - and avid travellers and aspiring adventurers of all kinds.', '1409197417', 368, 'https://books.google.com/books/publisher/content/images/frontcover/P-rSDwAAQBAJ?fife=w400-h600&source=gbs_api', '2020-10-29', '9781409197416', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (8, 'Measure What Matters', NULL, '525538348', 306, 'https://books.google.com/books/publisher/content/images/frontcover/SIJpswEACAAJ?fife=w400-h600&source=gbs_api', '2018-04-24', '9780525538349', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (9, 'How to Enjoy Art', 'An entertaining and lively guide to rediscovering the pleasure in art How to Enjoy Art: A Guide for Everyone provides the tools to understand and enjoy works of art. Debunking the pervasive idea that specialist knowledge is required to understand and appreciate art, instead How to Enjoy Art focuses on experience and pleasure, demonstrating how anyone can find value and enjoyment in art. Examples from around the world and throughout art history+IBQ-from works by Fra Angelico and Berthe Morisot to Kazuo Shiraga and Kara Walker+IBQ-are used to demonstrate how a handful of core strategies and skills can help enhance the experience of viewing art works. With these skills, anyone can encounter any work of art+IBQ-regardless of media, artist or period+IBQ-and find some resonance with their own experiences. How to Enjoy Art encourages us to rediscover the fundamental pleasure in viewing art.', '300263120', 160, 'https://books.google.com/books/publisher/content/images/frontcover/uiQ7EAAAQBAJ?fife=w400-h600&source=gbs_api', '2021-09-14', '9780300263121', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (10, 'Alcoholics Anonymous', NULL, '1258461803', 410, 'https://books.google.com/books/publisher/content/images/frontcover/Go9UMgEACAAJ?fife=w400-h600&source=gbs_api', '2012-08-01', '9781258461805', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (11, 'The Associated Press Stylebook 2015', 'A fully revised and updated edition of the bible of the newspaper industry', '465062946', 496, 'https://books.google.com/books/publisher/content/images/frontcover/-6vZoQEACAAJ?fife=w400-h600&source=gbs_api', '2015-07-14', '9780465062942', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (12, 'Immunisation against infectious diseases', 'This is the third edition of this publication which contains the latest information on vaccines and vaccination procedures for all the vaccine preventable infectious diseases that may occur in the UK or in travellers going outside of the UK, particularly those immunisations that comprise the routine immunisation programme for all children from birth to adolescence. It is divided into two sections: the first section covers principles, practices and procedures, including issues of consent, contraindications, storage, distribution and disposal of vaccines, surveillance and monitoring, and the Vaccine Damage Payment Scheme; the second section covers the range of different diseases and vaccines.', '113225288', 468, 'https://books.google.com/books/publisher/content/images/frontcover/N0RY-qAyiFIC?fife=w400-h600&source=gbs_api', '2006-12-11', '9780113225286', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (13, 'Palliative Care in Neurology', 'Over the last 50 years palliative care has usually been associated with cancer patients but more recently there has been increased discussion of the role of palliative care for neurological patients. In the past years, neurology has moved from being a purely diagnostic area to a very therapeutically active one. A further step needs to be taken to modify the therapeutic activity from +IBw-cure+IB0 to +IBw-care+IB0 depending on the patient+IBk-s disease trajectory. Palliative care has been associated with care at the end of life, whereas it may be appropriate earlier in the disease progression, and will extend after death in the support of bereaved families. The care of patients with neurological disease, and their families, will encompass the psychological, spiritual and existential issues and neurologists, and the teams in which they work, should develop skills to consider all aspects of care, in order to maximize the quality of life of all involved, and enable patients to die peacefully.', '288963471X', NULL, 'https://books.google.com/books/publisher/content/images/frontcover/uaHVDwAAQBAJ?fife=w400-h600&source=gbs_api', '2020-03-10', '9782889634712', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (14, 'European Genizah', 'This volume includes contributions presented at two conferences, in Mainz (Germany) and Jerusalem (Israel). The articles present a number of new discoveries of binding fragments in several European libraries and beyond.', '9004427929', 368, 'https://books.google.com/books/publisher/content/images/frontcover/JTr1DwAAQBAJ?fife=w400-h600&source=gbs_api', '2020-06-22', '9789004427921', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (15, 'How to Self-Publish Your Book', 'Did you ever consider self-publishing your own book but were daunted by the complex process of actually doing it? Self-published author and expert Carla King gives a simple step-by-step guide to self-publishing your book as an e-book or print book. Plot your success by choosing the reputable tools and services recommended here, along with techniques that will help your book succeed in the market that you choose.', '1627640010', NULL, 'https://books.google.com/books/publisher/content/images/frontcover/mN8eIE5HqL0C?fife=w400-h600&source=gbs_api', '2013-04-04', '9781627640015', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (16, 'Accident Book', NULL, '717664589', NULL, 'https://books.google.com/books/publisher/content/images/frontcover/zag2mgEACAAJ?fife=w400-h600&source=gbs_api', '2012-08-01', '9780717664580', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (17, 'Causal Inference', 'The application of causal inference methods is growing exponentially in fields that deal with observational data. Written by pioneers in the field, this practical book presents an authoritative yet accessible overview of the methods and applications of causal inference. With a wide range of detailed, worked examples using real epidemiologic data as well as software for replicating the analyses, the text provides a thorough introduction to the basics of the theory for non-time-varying treatments and the generalization to complex longitudinal data.', '1420076167', 352, 'https://books.google.com/books/publisher/content/images/frontcover/_KnHIAAACAAJ?fife=w400-h600&source=gbs_api', '2019-07-07', '9781420076165', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (18, 'StrengthsFinder 2.0', 'An updated version of the StrengthsFinder program developed by Gallup experts to help readers discover their distinct talents and strengths and how they can be translated into personal and career successes.', '159562015X', 175, 'https://books.google.com/books/publisher/content/images/frontcover/gttDCwAAQBAJ?fife=w400-h600&source=gbs_api', '2007-02-01', '9781595620156', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (19, 'bookdown', 'bookdown: Authoring Books and Technical Documents with R Markdown presents a much easier way to write books and technical publications than traditional tools such as LaTeX and Word. The bookdown package inherits the simplicity of syntax and flexibility for data analysis from R Markdown, and extends R Markdown for technical writing, so that you can make better use of document elements such as figures, tables, equations, theorems, citations, and references. Similar to LaTeX, you can number and cross-reference these elements with bookdown. Your document can even include live examples so readers can interact with them while reading the book. The book can be rendered to multiple output formats, including LaTeX/PDF, HTML, EPUB, and Word, thus making it easy to put your documents online. The style and theme of these output formats can be customized. We used books and R primarily for examples in this book, but bookdown is not only for books or R. Most features introduced in this book also apply to other types of publications: journal papers, reports, dissertations, course handouts, study notes, and even novels. You do not have to use R, either. Other choices of computing languages include Python, C, C+-+-, SQL, Bash, Stan, JavaScript, and so on, although R is best supported. You can also leave out computing, for example, to write a fiction. This book itself is an example of publishing with bookdown and R Markdown, and its source is fully available on GitHub.', '1351792601', 138, 'https://books.google.com/books/publisher/content/images/frontcover/8nm0DQAAQBAJ?fife=w400-h600&source=gbs_api', '2016-12-12', '9781351792608', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (20, 'Revelation', 'The final book of the Bible, Revelation prophesies the ultimate judgement of mankind in a series of allegorical visions, grisly images and numerological predictions. According to these, empires will fall, the \"Beast\" will be destroyed and Christ will rule a new Jerusalem. With an introduction by Will Self.', '857861018', 64, 'https://books.google.com/books/publisher/content/images/frontcover/JJqEbvqo0ZgC?fife=w400-h600&source=gbs_api', '1999-01-01', '9780857861016', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (21, 'Gathering Moss', 'Kimmerer blends, with deep attentiveness and musicality, science and personal insights to tell the overlooked story of the planet\'s oldest plants\' Guardian \'Bewitching ... a masterwork ... a glittering read in its entirety\' Maria Popova, Brainpickings Living at the limits of our ordinary perception, mosses are a common but largely unnoticed element of the natural world. Gathering Moss is a beautifully written mix of science and personal reflection that invites readers to explore and learn from the elegantly simple lives of mosses. In these interwoven essays, Robin Wall Kimmerer leads general readers and scientists alike to an understanding of how mosses live and how their lives are intertwined with the lives of countless other beings. Kimmerer explains the biology of mosses clearly and artfully, while at the same time reflecting on what these fascinating organisms have to teach us. Drawing on her experiences as a scientist, a mother, and a Native American, Kimmerer explains the stories of mosses in scientific terms as well as within the framework of indigenous ways of knowing. In her book, the natural history and cultural relationships of mosses become a powerful metaphor for ways of living in the world.', '014199763X', 192, 'https://books.google.com/books/publisher/content/images/frontcover/VXYLEAAAQBAJ?fife=w400-h600&source=gbs_api', '2021-07-01', '9780141997636', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (22, 'This Life', 'This Life is the debut novel by Quntos KunQuest, a longtime inmate at Angola, the infamous Louisiana State Penitentiary. This marks the appearance of a bold, distinctive new voice, one deeply inflected by hiphop, that delves into the meaning of a life spent behind bars, the human bonds formed therein, and the poetry that even those in the most dire places can create. Lil Chris is just nineteen when he arrives at Angola as an AU+IBQ-an admitting unit, a fresh fish, a new vict. He+IBk-s got a life sentence with no chance of parole, but he+IBk-s also got a clear mind and sharp awareness+IBQ-one that picks up quickly on the details of the system, his fellow inmates, and what he can do to claim a place at the top. When he meets Rise, a mature inmate who\'s already spent years in the system, and whose composure and raised consciousness command the respect of the other prisoners, Lil Chris learns to find his way in a system bent on repressing every means he has to express himself. Lil Chris and Rise channel their questions, frustrations, and pain into rap, and This Life flows with the same cadence that powers their charged verses. It pulses with the heat of impassioned inmates, the oppressive daily routines of the prison yard, and the rap contests that bring the men of the prison together. This Life is told in a voice that only a man who+IBk-s lived it could have+IBQ-a clipped, urgent, evocative voice that surges with anger, honesty, playfulness, and a deep sense of ugly history. Angola started out as a plantation+IBQ-and as This Life makes clear, black inmates are still in a kind of enslavement there. This Life is an important debut that commands our attention with the vigor, dynamism, and raw, consciousness-expanding energy of this essential new voice.', '1572848480', NULL, 'https://books.google.com/books/publisher/content/images/frontcover/FW0vEAAAQBAJ?fife=w400-h600&source=gbs_api', '2021-06-08', '9781572848481', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (23, 'Principles', '#1 New York Times Bestseller +IBw-Significant...The book is both instructive and surprisingly moving.+IB0 +IBQ-The New York Times Ray Dalio, one of the world+IBk-s most successful investors and entrepreneurs, shares the unconventional principles that he+IBk-s developed, refined, and used over the past forty years to create unique results in both life and business+IBQ-and which any person or organization can adopt to help achieve their goals. In 1975, Ray Dalio founded an investment firm, Bridgewater Associates, out of his two-bedroom apartment in New York City. Forty years later, Bridgewater has made more money for its clients than any other hedge fund in history and grown into the fifth most important private company in the United States, according to Fortune magazine. Dalio himself has been named to Time magazine+IBk-s list of the 100 most influential people in the world. Along the way, Dalio discovered a set of unique principles that have led to Bridgewater+IBk-s exceptionally effective culture, which he describes as +IBw-an idea meritocracy that strives to achieve meaningful work and meaningful relationships through radical transparency.+IB0 It is these principles, and not anything special about Dalio+IBQ-who grew up an ordinary kid in a middle-class Long Island neighborhood+IBQ-that he believes are the reason behind his success. In Principles, Dalio shares what he+IBk-s learned over the course of his remarkable career. He argues that life, management, economics, and investing can all be systemized into rules and understood like machines. The book+IBk-s hundreds of practical lessons, which are built around his cornerstones of +IBw-radical truth+IB0 and +IBw-radical transparency,+IB0 include Dalio laying out the most effective ways for individuals and organizations to make decisions, approach challenges, and build strong teams. He also describes the innovative tools the firm uses to bring an idea meritocracy to life, such as creating +IBw-baseball cards+IB0 for all employees that distill their strengths and weaknesses, and employing computerized decision-making systems to make believability-weighted decisions. While the book brims with novel ideas for organizations and institutions, Principles also offers a clear, straightforward approach to decision-making that Dalio believes anyone can apply, no matter what they+IBk-re seeking to achieve. Here, from a man who has been called both +IBw-the Steve Jobs of investing+IB0 and +IBw-the philosopher king of the financial universe+IB0 (CIO magazine), is a rare opportunity to gain proven advice unlike anything you+IBk-ll find in the conventional business press.', '1982112387', 592, 'https://books.google.com/books/publisher/content/images/frontcover/qNNmDwAAQBAJ?fife=w400-h600&source=gbs_api', '2018-08-07', '9781982112387', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (24, 'Biology 2e', NULL, '1947172514', NULL, 'https://books.google.com/books/publisher/content/images/frontcover/c9zStAEACAAJ?fife=w400-h600&source=gbs_api', '2018-04-01', '9781947172517', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (25, 'Moon Witch, Spider King', '+IBw-Masterfully flips the first installment on its head... James makes the mythic tantalizingly real.+IBkgHQ +IBQ-Esquire \"Even more brilliant than the first.+IB0 +IBQ-Buzzfeed An Instant New York Times Bestseller From Marlon James, author of the bestselling National Book Award finalist Black Leopard, Red Wolf, the second book in the Dark Star trilogy. In Black Leopard, Red Wolf, Sogolon the Moon Witch proved a worthy adversary to Tracker as they clashed across a mythical African landscape in search of a mysterious boy who disappeared. In Moon Witch, Spider King, Sogolon takes center stage and gives her own account of what happened to the boy, and how she plotted and fought, triumphed and failed as she looked for him. It+IBk-s also the story of a century-long feud+IBQ-seen through the eyes of a 177-year-old witch+IBQ-that Sogolon had with the Aesi, chancellor to the king. It is said that Aesi works so closely with the king that together they are like the eight limbs of one spider. Aesi+IBk-s power is considerable+IBQ-and deadly. It takes brains and courage to challenge him, which Sogolon does for reasons of her own. Both a brilliant narrative device+IBQ-seeing the story told in Black Leopard, Red Wolf from the perspective of an adversary and a woman+IBQ-as well as a fascinating battle between different versions of empire, Moon Witch, Spider King delves into Sogolon+IBk-s world as she fights to tell her own story. Part adventure tale, part chronicle of an indomitable woman who bows to no man, it is a fascinating novel that explores power, personality, and the places where they overlap.', '735220220', 656, 'https://books.google.com/books/publisher/content/images/frontcover/8ME0EAAAQBAJ?fife=w400-h600&source=gbs_api', '2022-02-15', '9780735220225', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (26, 'SAT Prep Black Book', '\"In addition to extensive and effective training on every aspect of the SAT, the SAT Black Book gives you detailed, systematic, easy-to-follow walkthroughs for every question in 4 of the College Board\'s official SAT Practice Tests. The Black Book is a must-have in your SAT preparation, whether you need to - make a perfect 1600 to be competitive at an Ivy, score a 450 in each section to claim a sports scholarship, or anything in between.\"--Publisher.', '692916164', 630, 'https://books.google.com/books/publisher/content/images/frontcover/hBSLswEACAAJ?fife=w400-h600&source=gbs_api', '2017-07-01', '9780692916162', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (27, 'Radical Candor', 'Radical Candor is the sweet spot between managers who are obnoxiously aggressive on the one side and ruinously empathetic on the other. It is about providing guidance, which involves a mix of praise as well as criticism, delivered to produce better results and help employees develop their skills and boundaries of success. Great bosses have a strong relationship with their employees, and Kim Scott Malone has identified three simple principles for building better relationships with your employees: make it personal, get stuff done, and understand why it matters. Radical Candor offers a guide to those bewildered or exhausted by management, written for bosses and those who manage bosses. Drawing on years of first-hand experience, and distilled clearly to give actionable lessons to the reader, Radical Candor shows how to be successful while retaining your integrity and humanity. Radical Candor is the perfect handbook for those who are looking to find meaning in their job and create an environment where people both love their work, their colleagues and are motivated to strive to ever greater success.', '1760553026', NULL, 'https://books.google.com/books/publisher/content/images/frontcover/XSXeDQAAQBAJ?fife=w400-h600&source=gbs_api', '2017-03-28', '9781760553029', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (28, 'Twelve Steps and Twelve Traditions Trade Edition', 'Twelve Steps to recovery.', '916856011', 192, 'https://books.google.com/books/publisher/content/images/frontcover/LTsUuAEACAAJ?fife=w400-h600&source=gbs_api', '1953-01-01', '9780916856014', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (29, 'Rework', '\"Rework\" shows you a better, faster, easier way to succeed in business. You\'ll learn how to be more productive, how to get exposure without breaking the bank, and tons more counterintuitive ideas that will inspire and provoke you.', '307463745', 279, 'https://books.google.com/books/publisher/content/images/frontcover/RC6LLYweIEMC?fife=w400-h600&source=gbs_api', '2010-01-01', '9780307463746', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (30, 'The Kids', 'Hannah Lowe taught for a decade in an inner-city London sixth form. At the heart of this book of compassionate and energetic sonnets are \'The Kids\', her students, the teenagers she nurtured. But the poems go further, meeting her own child self as she comes of age in the riotous 80s and 90s, later bearing witness to her small son learning to negotiate contemporary London. Across these deeply felt poems, Lowe interrogates the acts of teaching and learning with empathy and humour. Social class, gender and race - and their fundamental intersection with education - are investigated with an ever critical and introspective eye. The sonnet is re-energised, becoming a classroom, a memory box and even a mind itself as \'The Kids\' learn and negotiate their own unknown futures. These boisterous and musical poems explore and explode the universal experience of what it is to be taught, and to teach, ultimately reaching out and speaking to the child in all of us. The poems in the first section of the book draw on Hannah Lowe\'s experiences as a teacher in the 2000s, but the scenarios are largely fictitious, as are the names of the students. The Kids is a Poetry Book Society Choice.', '1780375794', 80, 'https://books.google.com/books/publisher/content/images/frontcover/e_UdzgEACAAJ?fife=w400-h600&source=gbs_api', '2021-01-01', '9781780375793', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (31, 'The Fight for Free Speech', 'A user+IBk-s guide to understanding contemporary free speech issues in the United States Americans today are confronted by a barrage of questions relating to their free speech freedoms. What are libel laws, and do they need to be changed to stop the press from lying? Does Colin Kaepernick have the right to take a knee? Can Saturday Night Live be punished for parody? While citizens are grappling with these questions, they generally have nowhere to turn to learn about the extent of their First Amendment rights. The Fight for Free Speech answers this call with an accessible, engaging user+IBk-s guide to free speech. Media lawyer Ian Rosenberg distills the spectrum of free speech law down to ten critical issues. Each chapter in this book focuses on a contemporary free speech question+IBQ-from student walkouts for gun safety to Samantha Bee+IBk-s expletives, from Nazis marching in Charlottesville to the muting of adult film star Stormy Daniels+IBQ and then identifies, unpacks, and explains the key Supreme Court case that provides the answers. Together these fascinating stories create a practical framework for understanding where our free speech protections originated and how they can develop in the future. As people on all sides of the political spectrum are demanding their right to speak and be heard, The Fight for Free Speech is a handbook for combating authoritarianism, protecting our democracy, and bringing an understanding of free speech law to all.', '1479801542', NULL, 'https://books.google.com/books/publisher/content/images/frontcover/TtnaDwAAQBAJ?fife=w400-h600&source=gbs_api', '2021-02-09', '9781479801541', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (32, 'Rise and Rise of the Private Art Hb', 'Public Spaces / Private Passions critically examines the growth of private museums in the 21st century, their impact on public institutions and what the future might look like. It is essential reading for museum professionals, art collectors, critics and cultural commentators and anyone working in the art trade.', '1848223846', 104, 'https://books.google.com/books/publisher/content/images/frontcover/sPRbzgEACAAJ?fife=w400-h600&source=gbs_api', '2021-09-30', '9781848223844', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (33, 'The Monocle Book of Japan', 'A celebration of theendlessly fascinating andculturally rich countryof Japan, this book fromthe Monocle team ispacked with insightsand fully illustrated withstunning photography. Monocle\'s latest book is an ardent paean to Japan, covering everything from design, architecture, and culture to food, fashion, and current affairs. Since it launched in 2007, Monocle has had deep roots in Japan. From day one, the magazine has maintained a Tokyo bureau, which today also encompasses a Monocle shop and radio studio. Over the past decade, the magazine and its team have continued to build upon their appreciation for and understanding of the nation of Japan. Monocle\'s stories have covered everything from a live journey on the emperor\'s jet and the tastiest places to eat in Kagoshima to the fashion designers challenging conventions and the businesses with remarkable stories untold outside Japan. The Monocle Book of Japan reveals the best of the country in the run-up to the 2021 Olympics. Complete with striking photography and captivating essays, this volume showcases some of Japan\'s most intriguing splendors.', '500971072', 304, 'https://books.google.com/books/publisher/content/images/frontcover/flFXygEACAAJ?fife=w400-h600&source=gbs_api', '2020-05-05', '9780500971079', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (34, 'Book Traces', 'In most college and university libraries, materials published before 1800 have been moved into special collections, while the post-1923 books remain in general circulation. But books published between these dates are vulnerable to deaccessioning, as libraries increasingly reconfigure access to public-domain texts via digital repositories such as Google Books. Even libraries with strong commitments to their print collections are clearing out the duplicates, assuming that circulating copies of any given nineteenth-century edition are essentially identical to one another. When you look closely, however, you see that they are not. Many nineteenth-century books were donated by alumni or their families decades ago, and many of them bear traces left behind by the people who first owned and used them. In Book Traces, Andrew M. Stauffer adopts what he calls \"guided serendipity\" as a tactic in pursuit of two goals: first, to read nineteenth-century poetry through the clues and objects earlier readers left in their books and, second, to defend the value of keeping the physical volumes on the shelves. Finding in such books of poetry the inscriptions, annotations, and insertions made by their original owners, and using them as exemplary case studies, Stauffer shows how the physical, historical book enables a modern reader to encounter poetry through the eyes of someone for whom it was personal.', '812297490', 288, 'https://books.google.com/books/publisher/content/images/frontcover/hnINEAAAQBAJ?fife=w400-h600&source=gbs_api', '2021-02-05', '9780812297492', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (35, 'The Official DVSA Theory Test for Car Drivers', 'This publication is the official theory test book for car drivers, compiled by the Driver and Vehicle Standards Agency. It contains multiple choice questions from the whole theory test question bank, with answers and explanations, dealing with topics such as: alertness and attitude, vehicle safety and handling, safety margins, hazard awareness, vulnerable road users, motorway rules and rules of the road, road and traffic signs, documents, accidents, and vehicle loading.', '115534199', 512, 'https://books.google.com/books/publisher/content/images/frontcover/qAY4jgEACAAJ?fife=w400-h600&source=gbs_api', '2015-10-26', '9780115534195', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (36, 'From Dissertation to Book', 'All new Phd\'s hope that their dissertations can become books. But a dissertation is written for a committee and a book for the larger world. William Germano\'s From Dissertation to Book is the essential guide for academic writers who want to revise a doctoral thesis for publication. The author of Getting It Published, Germano draws upon his extensive experience in academic publishing to provide writers with a state-of-the-art view of how to turn a dissertation into a manuscript that publishers will notice. Acknowledging first that not all theses can become books, Germano shows how some dissertations might have a better life as one or more journal articles or as chapters in a newly conceived book. But even dissertations strong enough to be published as books first need to become book manuscripts, and at the heart of From Dissertation to Book is the idea that revising the dissertation is a fundamental process of adapting from one genre of writing to another. Germano offers clear guidance on how to do just this. Writers will find advice on such topics as rethinking the table of contents, taming runaway footnotes, shaping chapter length, and confronting the limitations of jargon, alongside helpful timetables for light or heavy revision. With crisp directives, engaging examples, and a sympathetic eye for the foibles of academic writing, From Dissertation to Book reveals to recent PhD\'s the process of careful and thoughtful revision+IBQ-a truly invaluable skill as they grow into their new roles as professional writers.', '226288471', 152, 'https://books.google.com/books/publisher/content/images/frontcover/gJVtu6vuBpkC?fife=w400-h600&source=gbs_api', '2008-04-15', '9780226288475', 1, 1, '2022-05-25', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `category`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `category` (`id`, `name`, `description`, `img_url`) VALUES (1, 'Fiction', 'literature in the form of prose, especially short stories and novels, that describes imaginary events and people.', 'https://cdn.pixabay.com/photo/2017/09/10/14/24/manipulation-2735724_960_720.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `author`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `author` (`id`, `full_name`) VALUES (1, 'John Ronald Reuel Tolkien');

COMMIT;


-- -----------------------------------------------------
-- Data for table `post`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `post` (`id`, `content`, `title`, `post_date`, `enabled`, `user_id`) VALUES (1, 'I\'m a huge Tolkien fan, but I\'ve only ever watched the movies. I am going to start reading the books and am super excited', 'New Tolkien fan!', '2022-05-25 15:10:01 ', 1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `comment` (`id`, `content`, `comment_date`, `enabled`, `user_id`, `post_id`, `in_reply_to_id`) VALUES (1, 'That\'s huge!!! Get ready for an adventure!', '2022-05-25  15:10:10 ', 1, 1, 1, NULL);
INSERT INTO `comment` (`id`, `content`, `comment_date`, `enabled`, `user_id`, `post_id`, `in_reply_to_id`) VALUES (2, 'But be aware that they kind of read like Winnie the Pooh', '2022-05-25 15:11:30', 1, 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `question`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `question` (`id`, `content`, `question_date`, `enabled`, `user_id`, `book_id`) VALUES (1, 'Should I read The Hobbit if I\'ve already watched the movie?', '2022-05-25', 1, 2, 2);

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
INSERT INTO `review` (`id`, `content`, `rating`, `enabled`, `title`, `review_date`, `user_id`, `book_id`) VALUES (1, 'Honestly, way better than the films. Like did the director even read this?', 5, 1, 'The Hobbit is WAY BETTER as a book', '2022-05-25', 1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `wishlist`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `wishlist` (`user_id`, `book_id`) VALUES (1, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `currently_reading`
-- -----------------------------------------------------
START TRANSACTION;
USE `booknookdb`;
INSERT INTO `currently_reading` (`user_id`, `book_id`) VALUES (1, 3);

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
INSERT INTO `favorite_book` (`user_id`, `book_id`) VALUES (1, 2);

COMMIT;

