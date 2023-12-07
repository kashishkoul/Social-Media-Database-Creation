/* 
	This is to drop the database if one already exists do avoid conflicts.
	Will fail if the database is in use.
*/
USE master
GO
DECLARE @dbname nvarchar(128)
SET @dbname = N'SocialMedia'

IF (EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE ('[' + name + ']' = @dbname OR name = @dbname)))
DROP DATABASE SocialMedia
GO

---------------------- CREATE ----------------------

Create Database SocialMedia
Go
Use SocialMedia
GO

Create Table ACCOUNT
(
	Firstname varchar(40) NOT NULL,
	Lastname varchar(40) NOT NULL,
	Nickname varchar(40) ,
	Email varchar(40) NOT NULL,
	[Password] varchar(40) NOT NULL,
	Gender varchar(10) NOT NULL,
	PRIMARY KEY (Email),
	CONSTRAINT CHK_Gender CHECK (Gender IN ('Male', 'Female', 'Other', 'No Answer'))
)

Create Table FRIEND
(
	UserEmail varchar(40) NOT NULL,
	FriendEmail varchar(40) NOT NULL,
	PRIMARY KEY(UserEmail,FriendEmail),
	FOREIGN KEY (UserEmail) REFERENCES ACCOUNT(Email) ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY (FriendEmail) REFERENCES ACCOUNT(Email) ON UPDATE NO ACTION ON DELETE NO ACTION,
)

Create Table POST
(
	PostID int NOT NULL,
	Content varchar(120) NOT NULL,
	PostDate date NOT NULL,
	PostTime time NOT NULL,
	UserEmail varchar(40) NOT NULL,
	PRIMARY KEY(PostID),
	FOREIGN KEY(UserEmail) REFERENCES ACCOUNT(Email) ON UPDATE CASCADE ON DELETE CASCADE
)

Create Table MEDIA
(
	[Type] varchar(40) NOT NULL,
	Caption varchar(120) NOT NULL,
	PostID int NOT NULL,
	[FileName] varchar(40) NOT NULL,
	PRIMARY KEY(PostID,Caption),
	FOREIGN KEY (PostID) REFERENCES POST(PostID) ON UPDATE CASCADE ON DELETE CASCADE
)

Create Table REACTION
(
	[Type] varchar(40) NOT NULL,
	PRIMARY KEY(Type)
);

Create Table POST_REACTION
(

	UserEmail varchar(40) NOT NULL,
	PostID int NOT NULL,
	ReactionType varchar(40) NOT NULL,
	PRIMARY KEY(UserEmail,PostID),
	FOREIGN KEY(UserEmail) REFERENCES ACCOUNT(Email) ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY(PostID) REFERENCES POST(PostID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(ReactionType) REFERENCES REACTION(Type) ON UPDATE CASCADE ON DELETE CASCADE,
)

Create Table POST_COMMENT
(
	PostID int NOT NULL,
	CommentTime time NOT NULL,
	CommentDate date NOT NULL,
	Content varchar(40) NOT NULL,
	UserEmail varchar(40) NOT NULL,
	PRIMARY KEY(PostID, CommentTime,CommentDate, UserEmail),
	FOREIGN KEY (PostID) REFERENCES POST(PostID) ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY(UserEmail) REFERENCES ACCOUNT(Email) ON UPDATE NO ACTION ON DELETE NO ACTION,
)

Create table MESSAGE_THREAD
(
	ThreadID int,
	OwnerEmail varchar(40) NOT NULL,
	ThDate date NOT NULL,
	ThTime time NOT NULL,
	PRIMARY KEY(ThreadID),
	FOREIGN KEY(OwnerEmail) REFERENCES ACCOUNT(Email) ON UPDATE CASCADE ON DELETE CASCADE
)

Create Table THREAD_PARTICIPANT
(
	ThreadID int NOT NULL,
	UserEmail varchar(40) NOT NULL,
	PRIMARY KEY(ThreadID,UserEmail),
	FOREIGN KEY(ThreadID) REFERENCES MESSAGE_THREAD(ThreadID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(UserEmail) REFERENCES ACCOUNT(Email) ON UPDATE NO ACTION ON DELETE NO ACTION
)

Create table MESSAGE
(
	ThreadID int NOT NULL,
	Sender varchar(40) NOT NULL,
	MsgDate date NOT NULL,
	MsgTime time NOT NULL,
	Content varchar(120) NOT NULL,
	PRIMARY KEY(ThreadID,Sender,MsgDate, MsgTime),
	FOREIGN KEY(ThreadID) REFERENCES MESSAGE_THREAD(ThreadID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(Sender) REFERENCES ACCOUNT(Email) ON UPDATE NO ACTION ON DELETE NO ACTION,
)

---------------------- INSERT ----------------------
/*
	These delete commands are just added to reduce the chance
	of existing data, so our unique ids don't conflict.
*/ 
DELETE FROM MESSAGE
DELETE FROM THREAD_PARTICIPANT
DELETE FROM MESSAGE_THREAD
DELETE FROM POST_COMMENT
DELETE FROM POST_REACTION
DELETE FROM REACTION
DELETE FROM MEDIA
DELETE FROM POST
DELETE FROM FRIEND
DELETE FROM ACCOUNT

INSERT INTO ACCOUNT VALUES
('Toby', 'Fisher', 'TobyGuy', 'Toby@gmail.com', 'Password', 'Male'),
('Zack', 'Fulmer', 'Mike', 'Zack@gmail.com', 'Password1', 'Male'),
('Ned', 'Fulmer', 'John', 'Fulmer@gmail.com', 'Password2', 'Male'),
('John', 'Fulmer', 'jFulmer', 'jFulmer12@yahoo.com', 'Password', 'Male'),
('Shriya', 'Pandey', 'Shree', 'shriya_pandey@gmail.com', 'cat123', 'Female'),
('Rahul', 'Gupta', 'ragu', 'rahul_gupta01@gmail.com', 'keys11', 'Male'),
('Kashish', 'Koul', 'kash', 'kashishKoul@gmail.com', 'pass2', 'Female'),
('Bunty', 'Chaddha', null, 'Bunty8@uw.edu', 'foodie', 'Male'),
('Kaushal', 'Yadav', '007', 'kaushal@uw.edu', 'coder', 'Male'),
('Nikhil', 'Mehta', null, 'nikhil@uw.edu', 'nick', 'Male'),
('Devanshi', 'Sharma', null, 'debs@uw.edu', 'swiftie', 'Female')

INSERT INTO FRIEND VALUES
('Toby@gmail.com', 'Zack@gmail.com'),
('Zack@gmail.com', 'Fulmer@gmail.com'),
('Fulmer@gmail.com', 'Toby@gmail.com'),
('jFulmer12@yahoo.com', 'shriya_pandey@gmail.com'),
('jFulmer12@yahoo.com', 'rahul_gupta01@gmail.com'),
('shriya_pandey@gmail.com', 'rahul_gupta01@gmail.com'),
('kashishKoul@gmail.com', 'jFulmer12@yahoo.com'),
('Bunty8@uw.edu', 'kaushal@uw.edu'),
('nikhil@uw.edu', 'kaushal@uw.edu'),
('Bunty8@uw.edu', 'nikhil@uw.edu'),
('debs@uw.edu', 'Bunty8@uw.edu'),
('debs@uw.edu', 'kaushal@uw.edu')

INSERT INTO POST VALUES
(10, 'Today is a wonderful day', '03/02/2017', '13:00:00', 'Toby@gmail.com'),
(11, 'Time to browse 9Gag', '02/28/2017', '23:59:59', 'Fulmer@gmail.com'),
(12, 'Time to get a Nintendo Switch' , '03/03/2017', '00:00:01', 'Zack@gmail.com'),
(15, 'Got a new phone today!', '07/16/2010', '12:07:05', 'jFulmer12@yahoo.com'),
(16, 'Overslept today. Miss my bus...', '03/27/2015', '8:30:18', 'rahul_gupta01@gmail.com'),
(20, 'Oh God, I *love* cats!', '03/01/2017', '16:20:00', 'nikhil@uw.edu'),
(21, 'School is so tough :<', '03/05/2017', '23:20:29', 'Bunty8@uw.edu'),
(22, 'Lovin my new Lamborghini', '03/05/2017', '23:57:11', 'kaushal@uw.edu'),
(23, 'rip my laptop', '03/06/2017', '11:33:19', 'Bunty8@uw.edu'),
(24, 'drank 5 shots before my live performance. FeelsGreatMan!', '03/07/2017', '17:49:37', 'debs@uw.edu'),
(25, 'ooo your cats is so cute. can i come over to play? :D @nikhil', '03/09/2017', '23:13:22', 'debs@uw.edu')

INSERT INTO MEDIA VALUES 
('Image', 'Sunny day', 10, 'Sunny.jpg'),
('Image', 'Sunny day', 11, 'Selfie.jpg'),
('Video', 'Hands on the Switch', 12, 'NintendoSwitch.mp4'),
('Image', 'New phone!', 15, 'iphone.jpg'),
('Image', 'No bus & now raining :(', 16, 'busstop.jpg'),
('Image', 'Oh God, I *love* cats!', 20, 'cat.jpg')

INSERT INTO REACTION VALUES
('Smile'),
('Sad'),
('Excited'),
('Angry'),
('Dislike'),
('Like'),
('Love'),
('Surprised')

INSERT INTO POST_REACTION VALUES
('Fulmer@gmail.com', 10, 'Smile'),
('Fulmer@gmail.com', 12, 'Excited'),
('Zack@gmail.com', 11, 'Sad'),
('shriya_pandey@gmail.com', 15, 'Love'),
('shriya_pandey@gmail.com', 16, 'Sad'),
('jFulmer12@yahoo.com', 16, 'Sad'),
('Bunty8@uw.edu', 20, 'Love'),
('kaushal@uw.edu', 20, 'Like'),
('Bunty8@uw.edu', 22, 'Like'),
('debs@uw.edu', 22, 'Love'),
('nikhil@uw.edu', 22, 'Surprised')


INSERT INTO POST_COMMENT VALUES
(11, '05:06:30', '03/08/2017', 'Nice one', 'Toby@gmail.com'),
(12, '05:15:38', '03/08/2017', 'Good Job', 'Fulmer@gmail.com'),
(12, '05:15:30', '03/08/2017', 'Good Job', 'Toby@gmail.com'),
(15, '14:25:49','07/16/2010', 'That is awesome!', 'shriya_pandey@gmail.com'),
(15, '13:07:46', '07/16/2010', 'Did you change your number?', 'kashishKoul@gmail.com'),
(15, '16:15:59', '07/16/2010', 'Thanks, currently learning how to use it', 'jFulmer12@yahoo.com'),
(16, '9:30:05', '03/27/2015','That sucks, man. Stay dry!', 'jFulmer12@yahoo.com'),
(20, '03/01/2017', '16:21:00', 'same', 'Bunty8@uw.edu'),
(20, '03/01/2017', '17:01:29', 'nice. they are cute indeed', 'kaushal@uw.edu'),
(20, '03/01/2017', '17:02:49', 'OMG THEIR SO CUTE!!', 'debs@uw.edu')

INSERT INTO MESSAGE_THREAD VALUES 
(10, 'Toby@gmail.com', '05/03/2017','03:05:08'),
(11, 'Zack@gmail.com', '07/16/2010','01:00:00'),
(15, 'jFulmer12@yahoo.com', '05/03/2017','06:15:08'),
(20, 'debs@uw.edu', '05/13/2017','03:05:00')

INSERT INTO THREAD_PARTICIPANT VALUES
(10, 'Zack@gmail.com'),
(10, 'Fulmer@gmail.com'),
(11, 'Toby@gmail.com'),
(15, 'rahul_gupta01@gmail.com'),
(15, 'kaushal@uw.edu'),
(20, 'shriya_pandey@gmail.com'),
(20, 'kaushal@uw.edu'),
(20, 'Zack@gmail.com')

INSERT INTO MESSAGE VALUES
(10, 'Zack@gmail.com', '05/03/2017','03:05:08', 'Hey'),
(11, 'Toby@gmail.com', '05/03/2017','03:05:10', 'Dude'),
(10, 'Fulmer@gmail.com', '05/03/2017','03:05:09', 'Hey'),
(15, 'jFulmer12@yahoo.com', '05/25/2009', '15:31:56', 'Hey, we should hangout sometime!'),
(15, 'rahul_gupta01@gmail.com', '05/25/2009', '20:46:13', 'Sure, want to do Saturday night?'),
(15, 'jFulmer12@yahoo.com', '05/25/2009', '20:47:05', 'Yeah! Sounds good!'),
(20, 'debs@uw.edu', '03/01/2017', '17:03:11', 'hey james, did you see nickis cats?? their so cute!'),
(20, 'kaushal@uw.edu', '03/01/2017', '17:03:29', 'ye, what about it? lemme guess. you want them?'),
(20, 'debs@uw.edu', '03/01/2017', '17:04:01', 'yes! your so understanding james! thats my boy! kidnap them for me plz :) thx! xoxo'),
(20, 'kaushal@uw.edu', '03/01/2017', '17:04:21', 'gotchu honey'),
(20, 'debs@uw.edu', '03/02/2017', '13:41:23', 'actually nvm, nicki is a nice person'),
(20, 'kaushal@uw.edu', '03/02/2017', '13:50:21', 'kk. can you do the chores later?'),
(20, 'debs@uw.edu', '03/02/2017', '13:52:57', 'what? i have been doing them since 2 weeks now. Its your turn!'),
(20, 'kaushal@uw.edu', '03/02/2017', '14:00:41', 'aww kk'),
(20, 'kaushal@uw.edu', '03/02/2017', '14:00:46', 'mean')

---------------------- Sample Updates ----------------------

UPDATE ACCOUNT Set Lastname = 'Nguyen' Where Email = 'Toby@gmail.com'

UPDATE MEDIA Set [Type] = 'Video', [Filename] = 'Selfie.mp4', Caption = 'Selfie 360' Where Caption = 'Sunny Day' and PostId = 11

UPDATE POST Set Content = 'I am bored' Where PostID = 11

UPDATE POST_COMMENT Set Content = 'Too bad' Where UserEmail = 'Toby@gmail.com' AND CommentTime = '05:06:30' AND CommentDate = '03/08/2017'

UPDATE ACCOUNT Set NickName = 'joker' Where Email = 'jFulmer12@yahoo.com'

UPDATE POST Set Content = 'Why does it always rain when I am late?' Where PostId = 16 AND UserEmail = 'rahul_gupta01@gmail.com'

UPDATE POST Set Content = 'New phone with silver back!' Where PostId = 15 AND UserEmail = 'jFulmer12@yahoo.com'

UPDATE ACCOUNT SET Lastname = 'Swift' WHERE Email = 'debs@uw.edu'

UPDATE POST SET Content = 'Life is so tough :<' WHERE PostID = 21

UPDATE POST SET Content = 'nvm DELL fixed my laptop for me. yay!' WHERE PostID = 23;

UPDATE POST SET Content = 'oops! you saw nothing!' WHERE PostID = 24;

---------------------- SELECT ----------------------

-- Select all users
Select * from ACCOUNT

-- Select a user�s friends
Select * from FRIEND Where UserEmail = 'Bunty8@uw.edu' OR FriendEmail = 'Bunty8@uw.edu'

-- Select a user�s friends count
Select COUNT(*) AS 'Total Friends' from FRIEND Where UserEmail = 'Bunty8@uw.edu' OR FriendEmail = 'Bunty8@uw.edu'

-- Select a user�s posts
Select * from POST Where UserEmail = 'nikhil@uw.edu'

-- Select a post�s comments
Select * from POST_COMMENT Where PostId = 20

-- Select a post's reactions
Select * from POST_REACTION Where PostId = 20

-- Select a user�s posts
Select * from POST Where UserEmail = 'jFulmer12@yahoo.com'

-- Select a post�s comments
Select * from POST_COMMENT Where PostId = 15

-- Select a user�s conversations that they own the thread
Select * from MESSAGE M, MESSAGE_THREAD T
Where M.ThreadID = T.ThreadID AND M.ThreadID IN (Select ThreadID from MESSAGE_THREAD Where OwnerEmail = 'debs@uw.edu' AND ThDate = '05/13/2017' AND ThTime = '03:05:00')

-- Select message thread's participants and owner
Select T.OwnerEmail AS Owner, P.UserEmail AS Participant from MESSAGE_THREAD T, THREAD_PARTICIPANT P
Where T.ThreadID = P.ThreadID AND P.ThreadID IN (Select ThreadID from MESSAGE_THREAD Where OwnerEmail = 'debs@uw.edu' AND ThDate = '05/13/2017' AND ThTime = '03:05:00')

-- Select message thread's total participant count
Select T.ThreadID, T.OwnerEmail, COUNT(P.UserEmail) AS 'Total Participants' from MESSAGE_THREAD T, THREAD_PARTICIPANT P
Where T.ThreadID = P.ThreadID
Group By T.ThreadID, T.OwnerEmail

-- Select post�s photos or videos
Select * from MEDIA Where PostId = 10

-- Select user with the most posts
Select MAX(UserEmail) AS 'Big Contributor' from POST

-- Select last 20 posts from a user's friend 
Select TOP 20 * from POST P
Where P.UserEmail IN (Select UserEmail from FRIEND Where FriendEmail = 'Bunty8@uw.edu')
OR P.UserEmail IN (Select FriendEmail from FRIEND Where UserEmail = 'Bunty8@uw.edu')

-- Select last 20 posts from a user's friend and # of comments and total # of reactions in descending order of post date and time
Select TOP 20 P.UserEmail, P.Content, P.PostDate, P.PostTime, COUNT(C.PostId) AS 'Total Comments', COUNT(R.PostId) AS 'Total Reactions'
From Post P Left Join POST_COMMENT C ON P.PostID = C.PostID Left Join POST_REACTION R ON P.PostID = R.PostID
Where P.UserEmail IN (Select UserEmail from FRIEND Where FriendEmail = 'Bunty8@uw.edu')
OR P.UserEmail IN (Select FriendEmail from FRIEND Where UserEmail = 'Bunty8@uw.edu')
Group By P.UserEmail, P.Content, P.PostDate, P.PostTime
Order By P.PostDate, P.PostTime Desc

-- Select all posts with total # of comments and total # of reactions in descending order of total comments
Select P.UserEmail, P.Content, P.PostDate, P.PostTime, COUNT(C.PostId) AS 'Total Comments', COUNT(R.PostId) AS 'Total Reactions'
From POST P, POST_COMMENT C, POST_REACTION R
Where P.PostID = C.PostID AND P.PostID = R.PostID
Group By P.UserEmail, P.Content, P.PostDate, P.PostTime
Order By 'Total Comments' Desc

-- Select all reaction types
Select * from REACTION

-- Select reaction type that have been used
Select DISTINCT R.ReactionType From POST_REACTION R

-- Select thread with most participants
Select TOP 1 P.ThreadID, T.OwnerEmail, COUNT(P.ThreadID) AS 'Total Participants' from THREAD_PARTICIPANT P, MESSAGE_THREAD T
Where P.ThreadID = T.ThreadID
Group By P.ThreadID, T.OwnerEmail
Order By 'Total Participants' Desc
