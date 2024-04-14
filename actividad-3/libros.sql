CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE IF NOT EXISTS "Users" (
	`UserID`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`Location`	TEXT,
	`Age`	INTEGER
);
CREATE TABLE IF NOT EXISTS "Ratings" (
	`ID`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
	`UserID`	INTEGER,
	`ISBN`	TEXT,
	`Rating`	TEXT
);
CREATE TABLE IF NOT EXISTS "Books" (
	`ISBN`	TEXT NOT NULL UNIQUE,
	`Title`	TEXT,
	`Author`	TEXT,
	`YearPublication`	INTEGER,
	`Publisher`	TEXT,
	`ImageS`	TEXT,
	`ImageM`	TEXT,
	`ImageL`	TEXT,
	PRIMARY KEY(`ISBN`)
);
CREATE VIEW librouser as
select Books.Title, Users.Location
from Books
join Ratings on Ratings.ISBN=Books.isbn
join Users on Users.userID=Ratings.userID
/* librouser(Title,Location) */;
