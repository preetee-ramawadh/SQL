use bookstore;

insert into genres values(1, 'Fiction','1996-07-04 00:00:00.000','1996-08-01 00:00:00.000');
insert into genres values(2, 'Classical','1996-07-04 00:00:00.000','1996-08-01 00:00:00.000');
insert into genres values(3, 'Educational','1996-07-04 00:00:00.000','1996-08-01 00:00:00.000');
insert into genres values(4, 'Biography','1996-07-04 00:00:00.000','1996-08-01 00:00:00.000');

select * from genres;

insert into authors values(9, 'Abc', 'this is abc biography', '1996-07-04 00:00:00.000','1996-08-01 00:00:00.000');
insert into authors values(11, 'pqr', 'this is pqr biography', '1996-08-04 00:00:00.000','1996-08-01 00:00:00.000');
insert into authors values(12, 'xyz', 'this is xyz biography', '1996-09-04 00:00:00.000','1996-09-01 00:00:00.000');
insert into authors values(13, 'cds', 'this is cds biography', '1996-10-04 00:00:00.000','1996-11-01 00:00:00.000');
insert into authors values(14, 'opt', 'this is opt biography', '1996-11-04 00:00:00.000','1996-12-01 00:00:00.000');

select * from authors;

insert into books values(1, 'title1', 10.00, '1996-07-04 00:00:00.000','1996-08-01 00:00:00.000', '1996-07-04 00:00:00.000',10,2);
insert into books values(2, 'titlenew', 10.00, '1996-07-04 00:00:00.000','1996-08-01 00:00:00.000', '1996-07-04 00:00:00.000',12,3);
insert into books values(3, 'title3', 10.00, '1996-07-04 00:00:00.000','1996-08-01 00:00:00.000', '1996-07-04 00:00:00.000',12,4);
insert into books values(4, 'title4', 10.00, '1996-07-04 00:00:00.000','1996-08-01 00:00:00.000', '1996-07-04 00:00:00.000',14,3);
insert into books values(5, 'title5', 12.00, '1996-07-04 00:00:00.000','1996-08-01 00:00:00.000', '1996-07-04 00:00:00.000',10,3);

select * from books;

CREATE TABLE `Authors` (
  `author_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `biography` text NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Books` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `publication_date` datetime NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `author_id` int DEFAULT NULL,
  `genre_id` int DEFAULT NULL,
  PRIMARY KEY (`book_id`),
  KEY `author_id` (`author_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `books_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `Authors` (`author_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `books_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `Genres` (`genre_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

