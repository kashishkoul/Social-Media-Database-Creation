Create Database SocialMedia
Go
Use  SocialMedia
GO

Create Table ACCOUNT
(
	/*
	 SQL Server does not like 40 for PK
	*/
	Fname varchar(40) NOT NULL,
	Lname varchar(40) NOT NULL,
	NickName varchar(40) ,
	Email varchar(40) NOT NULL,
	[Password] varchar(40) NOT NULL,
	Gender varchar(40) NOT NULL,
	PRIMARY KEY (Email)
);

Create Table FRIEND
(
	UserEmail varchar(40) NOT NULL,
	FriendEmail varchar(40) NOT NULL,
	PRIMARY KEY(UserEmail,FriendEmail),
	/*
	SQL Server does not like on update cascade and on delete cascade
	Changed to NO ACTION. Kinda don't make sense if Account Deleted bu Friend still have that email
	*/
	FOREIGN KEY (UserEmail) REFERENCES ACCOUNT(Email)  on update NO ACTION on delete NO ACTION,
	FOREIGN KEY (FriendEmail) REFERENCES ACCOUNT(Email)  on update NO ACTION on delete NO ACTION,
);

create Table POST
(
	PostID int Identity(1001,1),
	Content varchar(120) NOT NULL,
	PostDate date NOT NULL,
	PostTime time NOT NULL,
	UserEmail varchar(40) NOT NULL,
	PRIMARY KEY(PostID),
	FOREIGN KEY(UserEmail) REFERENCES ACCOUNT(Email)  on update cascade on delete cascade
	);

Create Table MEDIA
(

	[Type] varchar(40) NOT NULL,
	Caption varchar(120) NOT NULL,
	PostID int NOT NULL,
	FileName varchar(40) NOT NULL,
	PRIMARY KEY(PostID,Caption),
	FOREIGN KEY (PostID) REFERENCES POST(PostID)  on update cascade on delete cascade
);

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
	/*
		Same as above, only accept NO ACTION
	*/ 
	FOREIGN KEY(UserEmail) REFERENCES ACCOUNT(Email)  on update NO ACTION on delete NO ACTION,
	FOREIGN KEY(PostID) REFERENCES POST(PostID)  on update NO ACTION on delete NO ACTION,
	FOREIGN KEY(ReactionType) REFERENCES REACTION(Type) on update NO ACTION on delete NO ACTION,
);

Create Table POST_COMMENTS
(
	PostID int NOT NULL,
	
	CommentTime time NOT NULL,
	CommentDate date NOT NULL,
	
	CommentContent varchar(40) NOT NULL,
	Commenter varchar(40) NOT NULL,
	PRIMARY KEY(PostID, CommentTime,CommentDate, Commenter ) ,
	/*
	Same NO ACTION
	*/
	FOREIGN KEY (PostID) REFERENCES POST(PostID)  on update NO ACTION on delete NO ACTION,
	FOREIGN KEY(Commenter) REFERENCES ACCOUNT(Email) on update NO ACTION on delete NO ACTION,
);

create table MESSAGE_THREAD
(
	ThreadID int Identity(1001,1),
	OwnerEmail varchar(40) NOT NULL,
	PRIMARY KEY(ThreadID),
	FOREIGN KEY(OwnerEmail) REFERENCES ACCOUNT(Email)  on update cascade on delete cascade
);

create table MESSAGE
(
	ThreadID int NOT NULL,
	Sender varchar(40) NOT NULL,
	MsgDate date NOT NULL,
	MsgTime time NOT NULL,
	Content varchar(120) NOT NULL,
	
	PRIMARY KEY(ThreadID,Sender,MsgDate, MsgTime),
	/*
	Same
	*/
	FOREIGN KEY(ThreadID) REFERENCES MESSAGE_THREAD(ThreadID)  on update NO ACTION on delete NO ACTION,
	FOREIGN KEY(Sender) REFERENCES ACCOUNT(Email)  on update NO ACTION on delete NO ACTION,
);

Create Table THREAD_PARTICIPANT
(
	ThreadID int NOT NULL,
	UserEmail varchar(40) NOT NULL,
	PRIMARY KEY(ThreadID,UserEmail),
	FOREIGN KEY(ThreadID) REFERENCES MESSAGE_THREAD(ThreadID)  on update NO ACTION on delete NO ACTION,
	FOREIGN KEY(UserEmail) REFERENCES ACCOUNT(Email) on update NO ACTION on delete NO ACTION
);

