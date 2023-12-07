INSERT INTO ACCOUNT values ('Aayush', 'Mishra', 'aayushmishra', 'aayushmishra12@yahoo.com', 'Password', 'M');
INSERT INTO ACCOUNT values ('Shriya', 'Pandey', 'Shree', 'shriya_pandey@gmail.com', 'cat123', 'F');
INSERT INTO ACCOUNT values ('Rahul', 'Gupta', 'Ragu', 'rahul_gupta01@gmail.com', 'keys11', 'M');
INSERT INTO ACCOUNT values ('Kashish', 'Koul', 'kash', 'kashishKoul@gmail.com', 'pass2', 'F');

INSERT INTO FRIEND values ('aayushmishra12@yahoo.com', 'shriya_pandey@gmail.com');
INSERT INTO FRIEND values ('aayushmishra12@yahoo.com', 'rahul_gupta01@gmail.com');
INSERT INTO FRIEND values ('shriya_pandey@gmail.com', 'rahul_gupta01@gmail.com');
INSERT INTO FRIEND values ('kashishKoul@gmail.com', 'aayushmishra12@yahoo.com');

INSERT INTO POST (Content, PostDate, PostTime, UserEmail) values ('I got a new phone today!', '07/16/2010', '12:07:05', 'aayushmishra12@yahoo.com');
INSERT INTO POST (Content, PostDate, PostTime, UserEmail) values ('I overslept today. Missed my bus...', '03/27/2015', '8:30:18', 'rahul_gupta01@gmail.com');

/* MEDIA insertion */
INSERT INTO MEDIA ([Type], Caption, PostID, [FileName]) 
values ('Image', 'New phone!', 
(select PostID from POST where UserEmail = 'aayushmishra12@yahoo.com' AND PostDate = '07/16/2010' AND PostTime = '12:07:05'), 'iphone.jpg'); 

INSERT INTO MEDIA ([Type], Caption, PostID, [FileName])
values ('Image', 'No bus & now it is raining :(', 
(select PostID from POST where UserEmail = 'rahul_gupta01@gmail.com' AND PostDate = '03/27/2015' AND PostTime = '8:30:18'),
'busStopSign.jpg');

/* REACTION insertion */
INSERT INTO REACTION values ('Angry');
INSERT INTO REACTION values ('Dislike');

/* POST_REACTION insertion */
INSERT INTO POST_REACTION (UserEmail, PostID, ReactionType)
values ('shriya_pandey@gmail.com', 
(select PostID from POST where UserEmail = 'aayushmishra12@yahoo.com' AND PostDate = '07/16/2010' AND PostTime = '12:07:05'),'Love');

INSERT INTO POST_REACTION (UserEmail, PostID, ReactionType)
values ('shriya_pandey@gmail.com',
(select PostID from POST where UserEmail = 'rahul_gupta01@gmail.com' AND PostDate = '03/27/2015' AND PostTime = '8:30:18'),
'It is sad');

INSERT INTO POST_REACTION (UserEmail, PostID, ReactionType)
values ('aayushmishra12@yahoo.com',
(select PostID from POST where UserEmail = 'rahul_gupta01@gmail.com' AND PostDate = '03/27/2015' AND PostTime = '8:30:18'),
'Sad');

/* POST_COMMENTS insertion */
INSERT INTO POST_COMMENTS (PostID, CommentTime, CommentDate, CommentContent, Commenter)
values ((select PostID from POST where UserEmail = 'aayushmishra12@yahoo.com' AND PostDate = '07/16/2010' AND PostTime = '12:07:05'), 
'14:25:49','07/16/2010', 'That is great!', 'shriya_pandey@gmail.com');

INSERT INTO POST_COMMENTS (PostID, CommentTime, CommentDate, CommentContent, Commenter)
values ((select PostID from POST where UserEmail = 'rahul_gupta01@gamil.com' AND PostDate = '03/27/2015' AND PostTime = '8:30:18'), 
 '9:30:05', '03/27/2015','That sucks, man. Stay dry!', 'aayushmishra12@yahoo.com');

INSERT INTO POST_COMMENTS (PostID, CommentTime, CommentDate, CommentContent, Commenter)
values ((select PostID from POST where UserEmail = 'aayushmishra12@yahoo.com' AND PostDate = '07/16/2010' AND PostTime = '12:07:05'), 
'13:07:46', '07/16/2010', 'Did you change your number?', 'kashishKoul@gmail.com');

INSERT INTO POST_COMMENTS (PostID, CommentTime, CommentDate, CommentContent, Commenter)
values ((select PostID from POST where UserEmail = 'aayushmishra12@yahoo.com' AND PostDate = '07/16/2010' AND PostTime = '12:07:05'),
'16:15:59', '07/16/2010', 'Thanks, currently learning how to use it', 'aayushmishra12@yahoo.com');

/* MESSAGE_TRHEAD insertion */
INSERT INTO MESSAGE_THREAD (OwnerEmail) values ('aayushmishra12@yahoo.com');


/* THREAD_PARTICIPANT insertion */
INSERT INTO THREAD_PARTICIPANT (ThreadID, UserEmail)
values ((select ThreadID from MESSAGE_THREAD where OwnerEmail = 'aayushmishra12@yahoo.com'),
'aayushmishra12@yahoo.com');

INSERT INTO THREAD_PARTICIPANT (ThreadID, UserEmail)
values ((select ThreadID from MESSAGE_THREAD where OwnerEmail = 'aayushmishra12@yahoo.com'), 
'rahul_gupta01@gmail.com');

/* MESSAGE insertion */
INSERT INTO [MESSAGE] (ThreadID, Sender, MsgDate, MsgTime, Content)
values ((select ThreadID from MESSAGE_THREAD where OwnerEmail = 'aayushmishra12@yahoo.com'), 
'aayushmishra12@yahoo.com', '05/25/2009', '15:31:56', 'Hey, we should hangout sometime!');

INSERT INTO [MESSAGE] (ThreadID, Sender, MsgDate, MsgTime, Content)
values ((select ThreadID from MESSAGE_THREAD where OwnerEmail = 'aayushmishra12@yahoo.com'), 
'rahul_gupta01@gmail.com', '05/25/2009', '20:46:13', 'Sure, want to do Saturday night?');

INSERT INTO [MESSAGE] (ThreadID, Sender, MsgDate, MsgTime, Content)
values ((select ThreadID from MESSAGE_THREAD where OwnerEmail = 'aayushmishra12@yahoo.com'),
'aayushmishra12@yahoo.com', '05/25/2009', '20:47:05', 'Yeah! Sounds good!');
