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
  `isbn_10` CHAR(10) NULL,
  `page_count` INT NULL,
  `img_url` VARCHAR(2000) NULL,
  `publish_date` DATE NULL,
  `isbn_13` CHAR(13) NULL,
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
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (1, 'The Fellowship of the Ring', 'Presents the epic depicting the Great War of the Ring, a struggle between good and evil in Middle Earth.', '0618129022', 1137, 'https://books.google.com/books/publisher/content/images/frontcover/ptHZAAAAMAAJ?fife=w400-h600&source=gbs_api', '2001-01-01', '9780618129027', 1, 1, '2022-05-25', '2022-05-25');
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (2, 'The Hobbit Or There and Back Again', 'Celebrating 75 years of one of the world\'s most treasured classics with an all new trade paperback edition. Repackaged with new cover art. 500,000 first printing.', '054792822X', 300, 'https://books.google.com/books/publisher/content/images/frontcover/LLSpngEACAAJ?fife=w400-h600&source=gbs_api', '2012-01-01', '9780547928227', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (3, 'The Two Towers', 'This title is also available as a film as a film - Part 2 of The lord of the rings.', '026110358X', 322, 'https://books.google.com/books/publisher/content/images/frontcover/_yI_c7_c4ZMC?fife=w400-h600&source=gbs_api', '1997-01-01', '9780261103580', 1, 1, '2022-05-25', NULL);
INSERT INTO `book` (`id`, `title`, `description`, `isbn_10`, `page_count`, `img_url`, `publish_date`, `isbn_13`, `language_id`, `user_id`, `date_added`, `last_updated`) VALUES (4, 'The Return of the King', 'Concluding the story begun in The Hobbit, this is the final part of Tolkien s epic masterpiece, The Lord of the Rings, featuring an exclusive cover image from the film, the definitive text, and a detailed map of Middle-earth. The armies of the Dark Lord Sauron are massing as his evil shadow spreads ever wider. Men, Dwarves, Elves and Ents unite forces to do battle agains the Dark. Meanwhile, Frodo and Sam struggle further into Mordor in their heroic quest to destroy the One Ring. The devastating conclusion of J.R.R. Tolkien s classic tale of magic and adventure, begun in The Fellowship of the Ring and The Two Towers, features the definitive edition of the text and includes the Appendices and a revised Index in full. To celebrate the release of the first of Peter Jackson s two-part film adaptation of The Hobbit, THE HOBBIT: AN UNEXPECTED JOURNEY, this third part of The Lord of the Rings is available for a limited time with an exclusive cover image from Peter Jackson s award-winning trilogy.', '0007488343', 624, 'https://books.google.com/books/publisher/content/images/frontcover/1EcBuwAACAAJ?fife=w400-h600&source=gbs_api', '2012-01-01', '9780007488346', 1, 1, '2022-05-25', NULL);

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

