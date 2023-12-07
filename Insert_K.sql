INSERT INTO ACCOUNT VALUES
('Bunty', 'Chaddha', null, 'bunty8@uw.edu', 'foodie', 'M'),
('Kaushal', 'Yadav', '007', 'kaushal@uw.edu', 'coder', 'M'),
('Nikhil', 'Mehta', null, 'nikhil@uw.edu', 'nick', 'M'),
('Devanshi', 'Sharma', null, 'debs@uw.edu', 'swiftie', 'F');

INSERT INTO FRIEND VALUES
('bunty8@uw.edu', 'kaushal@uw.edu'),
('nikhil@uw.edu', 'kaushal@uw.edu'),
('bunty8@uw.edu', 'nikhil@uw.edu'),
('debs@uw.edu', 'bunty8@uw.edu'),
('debs@uw.edu', 'kaushal@uw.edu');

INSERT INTO POST VALUES
(20, 'Oh God, I *love* cats!', '03/01/2017', '16:20:00', 'nikhil@uw.edu'),
(21, 'School is so tough :<', '03/05/2017', '23:20:29', 'bunty8@uw.edu'),
(22, 'Lovin my new Lamborghini', '03/05/2017', '23:57:11', 'kaushal@uw.edu'),
(23, 'rip my laptop', '03/06/2017', '11:33:19', 'bunty8@uw.edu'),
(24, 'drank 5 shots before my live performance. FeelsGreatMan!', '03/07/2017', '17:49:37', 'debs@uw.edu'),
(25, 'ooo your cats is so cute. can i come over to play? :D @nikhil', '03/09/2017', '23:13:22', 'debs@uw.edu');

INSERT INTO MEDIA VALUES
('Photos', 'Oh God, I *love* cats!', 20);

INSERT INTO REACTION VALUES
('Like'),
('Love'),
('Surprised');

INSERT INTO POST_REACTION VALUES
('bunty8@uw.edu', 20, 'Love'),
('kaushal@uw.edu', 20, 'Like'),
('bunty8@uw.edu', 22, 'Like'),
('debs@uw.edu', 22, 'Love'),
('nikhil@uw.edu', 22, 'Surprised');

INSERT INTO POST_COMMENTS VALUES
(20, '03/01/2017', '16:21:00', 'same', 'bunty8@uw.edu'),
(20, '03/01/2017', '17:01:29', 'nice. they are cute indeed', 'kaushal@uw.edu'),
(20, '03/01/2017', '17:02:49', 'OMG THEIR SO CUTE!!', 'debs@uw.edu');

INSERT INTO MESSAGE_THREAD VALUES
(20, 'debs@uw.edu');


INSERT INTO THREAD_PARTICIPANT VALUES
(20, 'debs@uw.edu'), -- Is already the owner doesn't need to be the participant anymore
(20, 'kaushal@uw.edu');

INSERT INTO [MESSAGE] VALUES
(20, 'debs@uw.edu', '03/01/2017', '17:03:11', 'hey james, did you see nickis cats?? their so cute!'),
(20, 'kaushal@uw.edu', '03/01/2017', '17:03:29', 'ye, what about it? lemme guess. you want them?'),
(20, 'debs@uw.edu', '03/01/2017', '17:04:01', 'yes! your so understanding james! thats my boy! kidnap them for me plz :) thx! xoxo'),
(20, 'kaushal@uw.edu', '03/01/2017', '17:04:21', 'gotchu honey'),
(20, 'debs@uw.edu', '03/02/2017', '13:41:23', 'actually nvm, nicki is a nice person'),
(20, 'kaushal@uw.edu', '03/02/2017', '13:50:21', 'kk. can you do the chores later?'),
(20, 'debs@uw.edu', '03/02/2017', '13:52:57', 'what? i have been doing them since 2 weeks now. Its your turn!'),
(20, 'kaushal@uw.edu', '03/02/2017', '14:00:41', 'aww kk'),
(20, 'kaushal@uw.edu', '03/02/2017', '14:00:46', 'mean');
