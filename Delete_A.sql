delete from ACCOUNT 
where Email = 'rahul_gupta01@gmail.com';

delete from FRIEND 
where FriendEmail = 'kashishKoul@mgail.com' AND UserEmail = 'aayushmishra12@yahoo.com';

delete from POST 
where PostDate = '07/16/2010' AND PostTime = '12:07:05' AND UserEmail = 'aayushmishra12@yahoo.com';

delete from MEDIA 
where PostID = (select PostID from POST where UserEmail = 'rahul_gupta01@gmail.com' AND PostDate = '03/27/2015' 
AND PostTime = '8:30:18');

delete from POST_REACTION 
where UserEmail = 'shriya_pandey@gmail.com' AND PostID = (select PostID from POST where UserEmail = 'aayushmishra12@yahoo.com' 
AND PostDate = '07/16/2010' AND PostTime = '12:07:05');

delete from POST_COMMENTS 
where CommentTime = '16:15:59' AND CommentDate = '07/16/2010' AND Commenter = 'aayushmishra12@yahoo.com';
