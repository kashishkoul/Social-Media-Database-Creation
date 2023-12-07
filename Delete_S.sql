delete from ACCOUNT
where Email = 'Toby@gmail.com';

delete from FRIEND
where UserEmail = 'Fulmer@gmail.com';

delete from POST
where PostDate = '02/28/2017' AND PostTime = '23:59:59' and UserEmail = 'Fulmer@gmail.com'

delete REACTION 
where [Type] = 'Smile';

delete from POST_REACTION
where UserEmail = 'Fulmer@gmail.com' and PostID = (select
PostID from POST where UserEmail = 'Fulmer@gmail.com' AND PostDate = '02/28/2017');

delete from POST_COMMENTS
where PostID = (select PostID from POST, ACCOUNT where
Post.UserEmail = ACCOUNT.Email AND POST.UserEmail ='Zack@gmail.com'
AND PostDate = '03/03/2017' AND PostTime = '00:00:01') AND CommentTime = '05:15:35'
AND CommentDate = '03/08/2017' AND CommentContent = 'Good Job' AND Commenter = 'Fulmer@gmail.com'; 
