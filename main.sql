-- Tables

CREATE TABLE [User]
(
    user_id int PRIMARY KEY,
    username varchar(50) UNIQUE NOT NULL,
    email varchar(100) UNIQUE NOT NULL,
    [password] varchar(100) NOT NULL,
    created_at datetime NOT NULL,
    last_login datetime NOT NULL,

    CONSTRAINT password_length_check CHECK (LEN([password]) >= 8)
);

CREATE TABLE Repository
(
    repo_id int PRIMARY KEY,
    [name] varchar(100) NOT NULL,
    [description] text NOT NULL,
    user_id int FOREIGN KEY REFERENCES [User] (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    created_at datetime NOT NULL,
);

CREATE TABLE Issue
(
    issue_id int PRIMARY KEY,
    title varchar(255) NOT NULL,
    [description] text NOT NULL,
    repo_id int FOREIGN KEY REFERENCES Repository (repo_id) ON DELETE CASCADE ON UPDATE CASCADE,
    user_id int FOREIGN KEY REFERENCES [User] (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    created_at datetime NOT NULL,
    updated_at datetime NOT NULL,
    closed_at datetime NOT NULL,
    [status] varchar(20) NOT NULL,
);

CREATE TABLE Comment
(
    comment_id int PRIMARY KEY,
    issue_id int FOREIGN KEY REFERENCES Issue (issue_id) ON DELETE CASCADE ON UPDATE CASCADE,
    user_id int FOREIGN KEY REFERENCES [User] (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    comment_text text NOT NULL,
    created_at datetime NOT NULL,
    updated_at datetime NOT NULL,
);

CREATE TABLE [Commit]
(
    commit_id int PRIMARY KEY,
    repo_id int FOREIGN KEY REFERENCES Repository (repo_id) ON DELETE CASCADE ON UPDATE CASCADE,
    user_id int FOREIGN KEY REFERENCES [User] (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    commit_message text NOT NULL,
    commit_date datetime NOT NULL,
);

CREATE TABLE Branch
(
    branch_id int PRIMARY KEY,
    repo_id int FOREIGN KEY REFERENCES Repository (repo_id) ON DELETE CASCADE ON UPDATE CASCADE,
    [name] varchar(100) NOT NULL,
    created_at datetime NOT NULL,
);

CREATE TABLE Collaborator
(
    collaborator_id int PRIMARY KEY,
    repo_id int FOREIGN KEY REFERENCES Repository (repo_id) ON DELETE CASCADE ON UPDATE CASCADE,
    user_id int FOREIGN KEY REFERENCES [User] (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
);

CREATE TABLE Star
(
    star_id int PRIMARY KEY,
    repo_id int FOREIGN KEY REFERENCES Repository (repo_id) ON DELETE CASCADE ON UPDATE CASCADE,
    user_id int FOREIGN KEY REFERENCES [User] (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
);

CREATE TABLE Follower
(
    follower_id int PRIMARY KEY,
    user_id int FOREIGN KEY REFERENCES [User] (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    follower_user_id int FOREIGN KEY REFERENCES [User] (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
);

-- Log Tables

CREATE TABLE UserLog
(
    log_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    user_id int FOREIGN KEY REFERENCES [User] (user_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    log_text text NOT NULL,
    log_date datetime NOT NULL,
);

CREATE TABLE RepositoryLog
(
    log_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    repo_id int FOREIGN KEY REFERENCES Repository (repo_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    log_text text NOT NULL,
    log_date datetime NOT NULL,
);

CREATE TABLE IssueLog
(
    log_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    issue_id int FOREIGN KEY REFERENCES Issue (issue_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    log_text text NOT NULL,
    log_date datetime NOT NULL,
);

CREATE TABLE CommentLog
(
    log_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    comment_id int FOREIGN KEY REFERENCES Comment (comment_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    log_text text NOT NULL,
    log_date datetime NOT NULL,
);

CREATE TABLE CommitLog
(
    log_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    commit_id int FOREIGN KEY REFERENCES [Commit] (commit_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    log_text text NOT NULL,
    log_date datetime NOT NULL,
);

CREATE TABLE BranchLog
(
    log_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    branch_id int FOREIGN KEY REFERENCES Branch (branch_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    log_text text NOT NULL,
    log_date datetime NOT NULL,
);

CREATE TABLE CollaboratorLog
(
    log_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    collaborator_id int FOREIGN KEY REFERENCES Collaborator (collaborator_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    log_text text NOT NULL,
    log_date datetime NOT NULL,
);

CREATE TABLE StarLog
(
    log_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    star_id int FOREIGN KEY REFERENCES Star (star_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    log_text text NOT NULL,
    log_date datetime NOT NULL,
);

CREATE TABLE FollowerLog
(
    log_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    follower_id int FOREIGN KEY REFERENCES Follower (follower_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    log_text text NOT NULL,
    log_date datetime NOT NULL,
);

-- Data

INSERT INTO [User]
    (user_id, username, email, [password], created_at, last_login)
VALUES
    (1, 'Ali', 'ali@example.com', 'password123', GETDATE(), GETDATE()),
    (2, 'Sana', 'sana@example.com', 'abc123456', GETDATE(), GETDATE()),
    (3, 'Ahmed', 'ahmed@example.com', 'pass12345', GETDATE(), GETDATE()),
    (4, 'Fatima', 'fatima@example.com', 'qwerty123', GETDATE(), GETDATE()),
    (5, 'Hassan', 'hassan@example.com', 'password456', GETDATE(), GETDATE()),
    (6, 'Ayesha', 'ayesha@example.com', '123456789', GETDATE(), GETDATE()),
    (7, 'Bilal', 'bilal@example.com', 'passpass', GETDATE(), GETDATE()),
    (8, 'Zoya', 'zoya@example.com', 'abc123456', GETDATE(), GETDATE()),
    (9, 'Imran', 'imran@example.com', 'password789', GETDATE(), GETDATE()),
    (10, 'Amina', 'amina@example.com', 'pass12345', GETDATE(), GETDATE()),
    (11, 'Yasir', 'yasir@example.com', 'qwerty123', GETDATE(), GETDATE()),
    (12, 'Sadaf', 'sadaf@example.com', 'passwordabc', GETDATE(), GETDATE()),
    (13, 'Nabeel', 'nabeel@example.com', '123456789', GETDATE(), GETDATE()),
    (14, 'Anaya', 'anaya@example.com', 'pass12345', GETDATE(), GETDATE()),
    (15, 'Saad', 'saad@example.com', 'qwerty789', GETDATE(), GETDATE()),
    (16, 'Sadia', 'sadia@example.com', 'passwordpass', GETDATE(), GETDATE()),
    (17, 'Usman', 'usman@example.com', 'abc123456', GETDATE(), GETDATE()),
    (18, 'Nida', 'nida@example.com', 'password123', GETDATE(), GETDATE()),
    (19, 'Fahad', 'fahad@example.com', '123456789', GETDATE(), GETDATE()),
    (20, 'Hira', 'hira@example.com', 'pass12345', GETDATE(), GETDATE()),
    (21, 'Khalid', 'khalid@example.com', 'qwerty789', GETDATE(), GETDATE()),
    (22, 'Farah', 'farah@example.com', 'passwordpass', GETDATE(), GETDATE()),
    (23, 'Tariq', 'tariq@example.com', 'abc123456', GETDATE(), GETDATE()),
    (24, 'Saima', 'saima@example.com', 'password123', GETDATE(), GETDATE()),
    (25, 'Adeel', 'adeel@example.com', '123456789', GETDATE(), GETDATE()),
    (26, 'Rabia', 'rabia@example.com', 'pass12345', GETDATE(), GETDATE()),
    (27, 'Junaid', 'junaid@example.com', 'qwerty789', GETDATE(), GETDATE()),
    (28, 'Zainab', 'zainab@example.com', 'passwordpass', GETDATE(), GETDATE()),
    (29, 'Arif', 'arif@example.com', 'abc123456', GETDATE(), GETDATE()),
    (30, 'Nadia', 'nadia@example.com', 'password123', GETDATE(), GETDATE());

INSERT INTO Repository
    (repo_id, [name], [description], user_id, created_at)
VALUES
    (1, 'Project1', 'Description for Project1', 1, GETDATE()),
    (2, 'Project2', 'Description for Project2', 2, GETDATE()),
    (3, 'Project3', 'Description for Project3', 3, GETDATE()),
    (4, 'Project4', 'Description for Project4', 4, GETDATE()),
    (5, 'Project5', 'Description for Project5', 5, GETDATE()),
    (6, 'Project6', 'Description for Project6', 6, GETDATE()),
    (7, 'Project7', 'Description for Project7', 7, GETDATE()),
    (8, 'Project8', 'Description for Project8', 8, GETDATE()),
    (9, 'Project9', 'Description for Project9', 9, GETDATE()),
    (10, 'Project10', 'Description for Project10', 10, GETDATE()),
    (11, 'Project11', 'Description for Project11', 11, GETDATE()),
    (12, 'Project12', 'Description for Project12', 12, GETDATE()),
    (13, 'Project13', 'Description for Project13', 13, GETDATE()),
    (14, 'Project14', 'Description for Project14', 14, GETDATE()),
    (15, 'Project15', 'Description for Project15', 15, GETDATE()),
    (16, 'Project16', 'Description for Project16', 16, GETDATE()),
    (17, 'Project17', 'Description for Project17', 17, GETDATE()),
    (18, 'Project18', 'Description for Project18', 18, GETDATE()),
    (19, 'Project19', 'Description for Project19', 19, GETDATE()),
    (20, 'Project20', 'Description for Project20', 20, GETDATE()),
    (21, 'Project21', 'Description for Project21', 21, GETDATE()),
    (22, 'Project22', 'Description for Project22', 22, GETDATE()),
    (23, 'Project23', 'Description for Project23', 23, GETDATE()),
    (24, 'Project24', 'Description for Project24', 24, GETDATE()),
    (25, 'Project25', 'Description for Project25', 25, GETDATE()),
    (26, 'Project26', 'Description for Project26', 26, GETDATE()),
    (27, 'Project27', 'Description for Project27', 27, GETDATE()),
    (28, 'Project28', 'Description for Project28', 28, GETDATE()),
    (29, 'Project29', 'Description for Project29', 29, GETDATE()),
    (30, 'Project30', 'Description for Project30', 30, GETDATE());

INSERT INTO Issue
    (issue_id, title, [description], repo_id, user_id, created_at, updated_at, closed_at, [status])
VALUES
    (1, 'Issue Title 1', 'Description for Issue 1', 1, 1, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (2, 'Issue Title 2', 'Description for Issue 2', 1, 2, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (3, 'Issue Title 3', 'Description for Issue 3', 2, 3, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (4, 'Issue Title 4', 'Description for Issue 4', 2, 4, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (5, 'Issue Title 5', 'Description for Issue 5', 3, 5, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (6, 'Issue Title 6', 'Description for Issue 6', 3, 6, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (7, 'Issue Title 7', 'Description for Issue 7', 4, 7, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (8, 'Issue Title 8', 'Description for Issue 8', 4, 8, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (9, 'Issue Title 9', 'Description for Issue 9', 5, 9, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (10, 'Issue Title 10', 'Description for Issue 10', 5, 10, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (11, 'Issue Title 11', 'Description for Issue 11', 6, 11, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (12, 'Issue Title 12', 'Description for Issue 12', 6, 12, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (13, 'Issue Title 13', 'Description for Issue 13', 7, 13, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (14, 'Issue Title 14', 'Description for Issue 14', 7, 14, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (15, 'Issue Title 15', 'Description for Issue 15', 8, 15, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (16, 'Issue Title 16', 'Description for Issue 16', 8, 16, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (17, 'Issue Title 17', 'Description for Issue 17', 9, 17, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (18, 'Issue Title 18', 'Description for Issue 18', 9, 18, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (19, 'Issue Title 19', 'Description for Issue 19', 10, 19, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (20, 'Issue Title 20', 'Description for Issue 20', 10, 20, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (21, 'Issue Title 21', 'Description for Issue 21', 11, 21, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (22, 'Issue Title 22', 'Description for Issue 22', 11, 22, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (23, 'Issue Title 23', 'Description for Issue 23', 12, 23, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (24, 'Issue Title 24', 'Description for Issue 24', 12, 24, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (25, 'Issue Title 25', 'Description for Issue 25', 13, 25, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (26, 'Issue Title 26', 'Description for Issue 26', 13, 26, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (27, 'Issue Title 27', 'Description for Issue 27', 14, 27, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (28, 'Issue Title 28', 'Description for Issue 28', 14, 28, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (29, 'Issue Title 29', 'Description for Issue 29', 15, 29, GETDATE(), GETDATE(), GETDATE(), 'Open'),
    (30, 'Issue Title 30', 'Description for Issue 30', 15, 30, GETDATE(), GETDATE(), GETDATE(), 'Open');

INSERT INTO Comment
    (comment_id, issue_id, user_id, comment_text, created_at, updated_at)
VALUES
    (1, 1, 1, 'Comment text for issue 1', GETDATE(), GETDATE()),
    (2, 1, 2, 'Comment text for issue 1', GETDATE(), GETDATE()),
    (3, 2, 3, 'Comment text for issue 2', GETDATE(), GETDATE()),
    (4, 2, 4, 'Comment text for issue 2', GETDATE(), GETDATE()),
    (5, 3, 5, 'Comment text for issue 3', GETDATE(), GETDATE()),
    (6, 3, 6, 'Comment text for issue 3', GETDATE(), GETDATE()),
    (7, 4, 7, 'Comment text for issue 4', GETDATE(), GETDATE()),
    (8, 4, 8, 'Comment text for issue 4', GETDATE(), GETDATE()),
    (9, 5, 9, 'Comment text for issue 5', GETDATE(), GETDATE()),
    (10, 5, 10, 'Comment text for issue 5', GETDATE(), GETDATE()),
    (11, 6, 11, 'Comment text for issue 6', GETDATE(), GETDATE()),
    (12, 6, 12, 'Comment text for issue 6', GETDATE(), GETDATE()),
    (13, 7, 13, 'Comment text for issue 7', GETDATE(), GETDATE()),
    (14, 7, 14, 'Comment text for issue 7', GETDATE(), GETDATE()),
    (15, 8, 15, 'Comment text for issue 8', GETDATE(), GETDATE()),
    (16, 8, 16, 'Comment text for issue 8', GETDATE(), GETDATE()),
    (17, 9, 17, 'Comment text for issue 9', GETDATE(), GETDATE()),
    (18, 9, 18, 'Comment text for issue 9', GETDATE(), GETDATE()),
    (19, 10, 19, 'Comment text for issue 10', GETDATE(), GETDATE()),
    (20, 10, 20, 'Comment text for issue 10', GETDATE(), GETDATE()),
    (21, 11, 21, 'Comment text for issue 11', GETDATE(), GETDATE()),
    (22, 11, 22, 'Comment text for issue 11', GETDATE(), GETDATE()),
    (23, 12, 23, 'Comment text for issue 12', GETDATE(), GETDATE()),
    (24, 12, 24, 'Comment text for issue 12', GETDATE(), GETDATE()),
    (25, 13, 25, 'Comment text for issue 13', GETDATE(), GETDATE()),
    (26, 13, 26, 'Comment text for issue 13', GETDATE(), GETDATE()),
    (27, 14, 27, 'Comment text for issue 14', GETDATE(), GETDATE()),
    (28, 14, 28, 'Comment text for issue 14', GETDATE(), GETDATE()),
    (29, 15, 29, 'Comment text for issue 15', GETDATE(), GETDATE()),
    (30, 15, 30, 'Comment text for issue 15', GETDATE(), GETDATE());

INSERT INTO [Commit]
    (commit_id, repo_id, user_id, commit_message, commit_date)
VALUES
    (1, 1, 1, 'Commit message for repo 1', GETDATE()),
    (2, 1, 2, 'Commit message for repo 1', GETDATE()),
    (3, 2, 3, 'Commit message for repo 2', GETDATE()),
    (4, 2, 4, 'Commit message for repo 2', GETDATE()),
    (5, 3, 5, 'Commit message for repo 3', GETDATE()),
    (6, 3, 6, 'Commit message for repo 3', GETDATE()),
    (7, 4, 7, 'Commit message for repo 4', GETDATE()),
    (8, 4, 8, 'Commit message for repo 4', GETDATE()),
    (9, 5, 9, 'Commit message for repo 5', GETDATE()),
    (10, 5, 10, 'Commit message for repo 5', GETDATE()),
    (11, 6, 11, 'Commit message for repo 6', GETDATE()),
    (12, 6, 12, 'Commit message for repo 6', GETDATE()),
    (13, 7, 13, 'Commit message for repo 7', GETDATE()),
    (14, 7, 14, 'Commit message for repo 7', GETDATE()),
    (15, 8, 15, 'Commit message for repo 8', GETDATE()),
    (16, 8, 16, 'Commit message for repo 8', GETDATE()),
    (17, 9, 17, 'Commit message for repo 9', GETDATE()),
    (18, 9, 18, 'Commit message for repo 9', GETDATE()),
    (19, 10, 19, 'Commit message for repo 10', GETDATE()),
    (20, 10, 20, 'Commit message for repo 10', GETDATE()),
    (21, 11, 21, 'Commit message for repo 11', GETDATE()),
    (22, 11, 22, 'Commit message for repo 11', GETDATE()),
    (23, 12, 23, 'Commit message for repo 12', GETDATE()),
    (24, 12, 24, 'Commit message for repo 12', GETDATE()),
    (25, 13, 25, 'Commit message for repo 13', GETDATE()),
    (26, 13, 26, 'Commit message for repo 13', GETDATE()),
    (27, 14, 27, 'Commit message for repo 14', GETDATE()),
    (28, 14, 28, 'Commit message for repo 14', GETDATE()),
    (29, 15, 29, 'Commit message for repo 15', GETDATE()),
    (30, 15, 30, 'Commit message for repo 15', GETDATE());

INSERT INTO Branch
    (branch_id, repo_id, [name], created_at)
VALUES
    (1, 1, 'Branch1', GETDATE()),
    (2, 1, 'Branch2', GETDATE()),
    (3, 2, 'Branch3', GETDATE()),
    (4, 2, 'Branch4', GETDATE()),
    (5, 3, 'Branch5', GETDATE()),
    (6, 3, 'Branch6', GETDATE()),
    (7, 4, 'Branch7', GETDATE()),
    (8, 4, 'Branch8', GETDATE()),
    (9, 5, 'Branch9', GETDATE()),
    (10, 5, 'Branch10', GETDATE()),
    (11, 6, 'Branch11', GETDATE()),
    (12, 6, 'Branch12', GETDATE()),
    (13, 7, 'Branch13', GETDATE()),
    (14, 7, 'Branch14', GETDATE()),
    (15, 8, 'Branch15', GETDATE()),
    (16, 8, 'Branch16', GETDATE()),
    (17, 9, 'Branch17', GETDATE()),
    (18, 9, 'Branch18', GETDATE()),
    (19, 10, 'Branch19', GETDATE()),
    (20, 10, 'Branch20', GETDATE()),
    (21, 11, 'Branch21', GETDATE()),
    (22, 11, 'Branch22', GETDATE()),
    (23, 12, 'Branch23', GETDATE()),
    (24, 12, 'Branch24', GETDATE()),
    (25, 13, 'Branch25', GETDATE()),
    (26, 13, 'Branch26', GETDATE()),
    (27, 14, 'Branch27', GETDATE()),
    (28, 14, 'Branch28', GETDATE()),
    (29, 15, 'Branch29', GETDATE()),
    (30, 15, 'Branch30', GETDATE());

INSERT INTO Collaborator
    (collaborator_id, repo_id, user_id)
VALUES
    (1, 1, 1),
    (2, 1, 2),
    (3, 2, 3),
    (4, 2, 4),
    (5, 3, 5),
    (6, 3, 6),
    (7, 4, 7),
    (8, 4, 8),
    (9, 5, 9),
    (10, 5, 10),
    (11, 6, 11),
    (12, 6, 12),
    (13, 7, 13),
    (14, 7, 14),
    (15, 8, 15),
    (16, 8, 16),
    (17, 9, 17),
    (18, 9, 18),
    (19, 10, 19),
    (20, 10, 20),
    (21, 11, 21),
    (22, 11, 22),
    (23, 12, 23),
    (24, 12, 24),
    (25, 13, 25),
    (26, 13, 26),
    (27, 14, 27),
    (28, 14, 28),
    (29, 15, 29),
    (30, 15, 30);

INSERT INTO Star
    (star_id, repo_id, user_id)
VALUES
    (1, 1, 1),
    (2, 1, 2),
    (3, 2, 3),
    (4, 2, 4),
    (5, 3, 5),
    (6, 3, 6),
    (7, 4, 7),
    (8, 4, 8),
    (9, 5, 9),
    (10, 5, 10),
    (11, 6, 11),
    (12, 6, 12),
    (13, 7, 13),
    (14, 7, 14),
    (15, 8, 15),
    (16, 8, 16),
    (17, 9, 17),
    (18, 9, 18),
    (19, 10, 19),
    (20, 10, 20),
    (21, 11, 21),
    (22, 11, 22),
    (23, 12, 23),
    (24, 12, 24),
    (25, 13, 25),
    (26, 13, 26),
    (27, 14, 27),
    (28, 14, 28),
    (29, 15, 29),
    (30, 15, 30);

INSERT INTO Follower
    (follower_id, user_id, follower_user_id)
VALUES
    (1, 1, 2),
    (2, 2, 3),
    (3, 3, 4),
    (4, 4, 5),
    (5, 5, 6),
    (6, 6, 7),
    (7, 7, 8),
    (8, 8, 9),
    (9, 9, 10),
    (10, 10, 11),
    (11, 11, 12),
    (12, 12, 13),
    (13, 13, 14),
    (14, 14, 15),
    (15, 15, 16),
    (16, 16, 17),
    (17, 17, 18),
    (18, 18, 19),
    (19, 19, 20),
    (20, 20, 21),
    (21, 21, 22),
    (22, 22, 23),
    (23, 23, 24),
    (24, 24, 25),
    (25, 25, 26),
    (26, 26, 27),
    (27, 27, 28),
    (28, 28, 29),
    (29, 29, 30),
    (30, 30, 1);

-- Log Triggers


CREATE TRIGGER user_insert_trigger
ON [User]
AFTER INSERT
AS
BEGIN
    INSERT INTO UserLog
        (user_id, log_text, log_date)
    SELECT user_id, 'User inserted', GETDATE()
    FROM inserted;
END;

CREATE TRIGGER user_update_trigger
ON [User]
AFTER UPDATE
AS
BEGIN
    INSERT INTO UserLog
        (user_id, log_text, log_date)
    SELECT user_id, 'User updated', GETDATE()
    FROM inserted;
END;

CREATE TRIGGER user_delete_trigger
ON [User]
AFTER DELETE
AS
BEGIN
    INSERT INTO UserLog
        (user_id, log_text, log_date)
    SELECT user_id, 'User deleted', GETDATE()
    FROM deleted;
END;


CREATE TRIGGER repository_insert_trigger
ON Repository
AFTER INSERT
AS
BEGIN
    INSERT INTO RepositoryLog
        (repo_id, log_text, log_date)
    SELECT repo_id, 'Repository inserted', GETDATE()
    FROM inserted;
END;

CREATE TRIGGER repository_update_trigger
ON Repository
AFTER UPDATE
AS
BEGIN
    INSERT INTO RepositoryLog
        (repo_id, log_text, log_date)
    SELECT repo_id, 'Repository updated', GETDATE()
    FROM inserted;
END;

CREATE TRIGGER repository_delete_trigger
ON Repository
AFTER DELETE
AS
BEGIN
    INSERT INTO RepositoryLog
        (repo_id, log_text, log_date)
    SELECT repo_id, 'Repository deleted', GETDATE()
    FROM deleted;
END;


CREATE TRIGGER issue_insert_trigger
ON Issue
AFTER INSERT
AS
BEGIN
    INSERT INTO IssueLog
        (issue_id, log_text, log_date)
    SELECT issue_id, 'Issue inserted', GETDATE()
    FROM inserted;
END;

CREATE TRIGGER issue_update_trigger
ON Issue
AFTER UPDATE
AS
BEGIN
    INSERT INTO IssueLog
        (issue_id, log_text, log_date)
    SELECT issue_id, 'Issue updated', GETDATE()
    FROM inserted;
END;

CREATE TRIGGER issue_delete_trigger
ON Issue
AFTER DELETE
AS
BEGIN
    INSERT INTO IssueLog
        (issue_id, log_text, log_date)
    SELECT issue_id, 'Issue deleted', GETDATE()
    FROM deleted;
END;


CREATE TRIGGER comment_insert_trigger
ON Comment
AFTER INSERT
AS
BEGIN
    INSERT INTO CommentLog
        (comment_id, log_text, log_date)
    SELECT comment_id, 'Comment inserted', GETDATE()
    FROM inserted;
END;

CREATE TRIGGER comment_update_trigger
ON Comment
AFTER UPDATE
AS
BEGIN
    INSERT INTO CommentLog
        (comment_id, log_text, log_date)
    SELECT comment_id, 'Comment updated', GETDATE()
    FROM inserted;
END;

CREATE TRIGGER comment_delete_trigger
ON Comment
AFTER DELETE
AS
BEGIN
    INSERT INTO CommentLog
        (comment_id, log_text, log_date)
    SELECT comment_id, 'Comment deleted', GETDATE()
    FROM deleted;
END;


CREATE TRIGGER commit_insert_trigger
ON [Commit]
AFTER INSERT
AS
BEGIN
    INSERT INTO CommitLog
        (commit_id, log_text, log_date)
    SELECT commit_id, 'Commit inserted', GETDATE()
    FROM inserted;
END;

CREATE TRIGGER commit_update_trigger
ON [Commit]
AFTER UPDATE
AS
BEGIN
    INSERT INTO CommitLog
        (commit_id, log_text, log_date)
    SELECT commit_id, 'Commit updated', GETDATE()
    FROM inserted;
END;

CREATE TRIGGER commit_delete_trigger
ON Commit
AFTER DELETE
AS
BEGIN
    INSERT INTO CommitLog
        (commit_id, log_text, log_date)
    SELECT commit_id, 'Commit deleted', GETDATE()
    FROM deleted;
END;


CREATE TRIGGER branch_insert_trigger
ON Branch
AFTER INSERT
AS
BEGIN
    INSERT INTO BranchLog
        (branch_id, log_text, log_date)
    SELECT branch_id, 'Branch inserted', GETDATE()
    FROM inserted;
END;

CREATE TRIGGER branch_update_trigger
ON Branch
AFTER UPDATE
AS
BEGIN
    INSERT INTO BranchLog
        (branch_id, log_text, log_date)
    SELECT branch_id, 'Branch updated', GETDATE()
    FROM inserted;
END;

CREATE TRIGGER branch_delete_trigger
ON Branch
AFTER DELETE
AS
BEGIN
    INSERT INTO BranchLog
        (branch_id, log_text, log_date)
    SELECT branch_id, 'Branch deleted', GETDATE()
    FROM deleted;
END;


CREATE TRIGGER star_insert_trigger
ON Star
AFTER INSERT
AS
BEGIN
    INSERT INTO StarLog
        (star_id, log_text, log_date)
    SELECT star_id, 'Star inserted', GETDATE()
    FROM inserted;
END;

CREATE TRIGGER star_delete_trigger
ON Star
AFTER DELETE
AS
BEGIN
    INSERT INTO StarLog
        (star_id, log_text, log_date)
    SELECT star_id, 'Star deleted', GETDATE()
    FROM deleted;
END;


CREATE TRIGGER follower_insert_trigger
ON Follower
AFTER INSERT
AS
BEGIN
    INSERT INTO FollowerLog
        (follower_id, log_text, log_date)
    SELECT follower_id, 'Follower inserted', GETDATE()
    FROM inserted;
END;

CREATE TRIGGER follower_delete_trigger
ON Follower
AFTER DELETE
AS
BEGIN
    INSERT INTO FollowerLog
        (follower_id, log_text, log_date)
    SELECT follower_id, 'Follower deleted', GETDATE()
    FROM deleted;
END;

-- Notification Triggers


CREATE TRIGGER new_follower_trigger
ON Follower
AFTER INSERT
AS
BEGIN
    DECLARE @username NVARCHAR(255);
    SELECT @username = username
    FROM UserAccount
    WHERE user_id = (SELECT follower_id
    FROM inserted);
    PRINT @username + ' has a new follower';
END;


CREATE TRIGGER new_star_trigger
ON Star
AFTER INSERT
AS
BEGIN
    DECLARE @username NVARCHAR(255);
    SELECT @username = username
    FROM UserAccount
    WHERE user_id = (SELECT user_id
    FROM Repository
    WHERE repo_id = (SELECT repo_id
    FROM inserted));
    PRINT @username + ' has a new star';
END;


CREATE TRIGGER new_comment_trigger
ON Comment
AFTER INSERT
AS
BEGIN
    DECLARE @username NVARCHAR(255);
    SELECT @username = username
    FROM UserAccount
    WHERE user_id = (SELECT user_id
    FROM Repository
    WHERE repo_id = (SELECT repo_id
    FROM Issue
    WHERE issue_id = (SELECT issue_id
    FROM inserted)));
    PRINT @username + ' has a new comment';
END;


CREATE TRIGGER new_commit_trigger
ON Commit
AFTER INSERT
AS
BEGIN
    DECLARE @username NVARCHAR(255);
    SELECT @username = username
    FROM UserAccount
    WHERE user_id = (SELECT user_id
    FROM Repository
    WHERE repo_id = (SELECT repo_id
    FROM inserted));
    PRINT @username + ' has a new commit';
END;


-- Views

-- View for Repository and User Relationship:
CREATE VIEW Repository_User_View
AS
    SELECT r.repo_id, r.name AS repository_name, r.description, u.user_id, u.username, u.email
    FROM Repository r INNER JOIN [User] u ON r.user_id = u.user_id;

-- View for Issue and User Relationship:
CREATE VIEW Issue_User_View
AS
    SELECT i.issue_id, i.title, i.description, i.repo_id, i.user_id, u.username AS reporter_username, u.email AS reporter_email,
        i.created_at, i.updated_at, i.closed_at, i.status
    FROM Issue i INNER JOIN [User] u ON i.user_id = u.user_id;

-- View for Comment and User Relationship:
CREATE VIEW Comment_User_View
AS
    SELECT c.comment_id, c.issue_id, c.user_id, u.username, u.email, c.comment_text, c.created_at, c.updated_at
    FROM Comment c INNER JOIN [User] u ON c.user_id = u.user_id;

-- View for Commit and User Relationship:
CREATE VIEW Commit_User_View
AS
    SELECT co.commit_id, co.repo_id, co.user_id, u.username, u.email, co.commit_message, co.commit_date
    FROM [Commit] co INNER JOIN [User] u ON co.user_id = u.user_id;

-- -View for Branch and Repository Relationship:
CREATE VIEW Branch_Repository_View
AS
    SELECT b.branch_id, b.repo_id, r.name AS repository_name, b.name AS branch_name, b.created_at
    FROM Branch b INNER JOIN Repository r ON b.repo_id = r.repo_id;

-- View for Collaborator and Repository Relationship:
CREATE VIEW Collaborator_Repository_View
AS
    SELECT c.collaborator_id, c.repo_id, r.name AS repository_name, u.username, u.email
    FROM Collaborator c INNER JOIN Repository r ON c.repo_id = r.repo_id INNER JOIN [User] u ON c.user_id = u.user_id;

-- View for Star and Repository Relationship:
CREATE VIEW Star_Repository_View
AS
    SELECT s.star_id, s.repo_id, r.name AS repository_name, u.username, u.email
    FROM Star s INNER JOIN Repository r ON s.repo_id = r.repo_id INNER JOIN [User] u ON s.user_id = u.user_id;

-- View for Follower and User Relationship:
CREATE VIEW Follower_User_View
AS
    SELECT f.follower_id, f.user_id, u.username AS follower_username, u.email AS follower_email,
        u2.username AS following_username, u2.email AS following_email
    FROM Follower f INNER JOIN [User] u ON f.follower_user_id = u.user_id INNER JOIN [User] u2 ON f.user_id = u2.user_id;

-- View for Repository, Collaborator, and User Relationship:
CREATE VIEW Repository_Collaborator_User_View
AS
    SELECT r.repo_id, r.name AS repository_name, r.description, c.collaborator_id,
        u.username AS collaborator_username, u.email AS collaborator_email,
        u2.username AS owner_username, u2.email AS owner_email
    FROM Repository r INNER JOIN Collaborator c ON r.repo_id = c.repo_id INNER JOIN [User] u ON c.user_id = u.user_id INNER JOIN [User] u2 ON r.user_id = u2.user_id;

-- View for Issue, Comment, and User Relationship:
CREATE VIEW Issue_Comment_User_View
AS
    SELECT i.issue_id, i.title, i.description, i.repo_id, i.user_id, u.username AS reporter_username,
        u.email AS reporter_email, i.created_at, i.updated_at, i.closed_at, i.status,
        c.comment_id, c.comment_text, c.user_id AS commenter_user_id, u2.username AS commenter_username,
        u2.email AS commenter_email, c.created_at AS comment_created_at, c.updated_at AS comment_updated_at
    FROM Issue i INNER JOIN [User] u ON i.user_id = u.user_id
        LEFT JOIN Comment c ON i.issue_id = c.issue_id
        LEFT JOIN [User] u2 ON c.user_id = u2.user_id;

-- View for Branch, Commit, and Repository Relationship:
CREATE VIEW Branch_Commit_Repository_View
AS
    SELECT b.branch_id, b.repo_id, r.name AS repository_name, b.name AS branch_name, b.created_at AS branch_created_at,
        co.commit_id, co.commit_message, co.user_id AS committer_user_id, u.username AS committer_username,
        u.email AS committer_email, co.commit_date
    FROM Branch b INNER JOIN [Commit] co ON b.repo_id = co.repo_id INNER JOIN [User] u ON co.user_id = u.user_id INNER JOIN Repository r ON b.repo_id = r.repo_id;

-- View for Star, Repository, and User Relationship:
CREATE VIEW Star_Repository_User_View
AS
    SELECT s.star_id, s.repo_id, r.name AS repository_name, r.description, u.username AS star_user_username,
        u.email AS star_user_email, u2.username AS repository_owner_username, u2.email AS repository_owner_email
    FROM Star s INNER JOIN Repository r ON s.repo_id = r.repo_id INNER JOIN [User] u ON s.user_id = u.user_id INNER JOIN [User] u2 ON r.user_id = u2.user_id;


SELECT * FROM [User];
SELECT * FROM Repository;
SELECT * FROM Issue;
SELECT * FROM Comment;
SELECT * FROM [Commit];
SELECT * FROM Branch;
SELECT * FROM Collaborator;
SELECT * FROM Star;
SELECT * FROM Follower;

SELECT * FROM UserLog;
SELECT * FROM RepositoryLog;
SELECT * FROM IssueLog;
SELECT * FROM CommentLog;
SELECT * FROM CommitLog;
SELECT * FROM BranchLog;
SELECT * FROM CollaboratorLog;
SELECT * FROM StarLog;
SELECT * FROM FollowerLog;

SELECT * FROM Repository_User_View;
SELECT * FROM Issue_User_View;
SELECT * FROM Comment_User_View;
SELECT * FROM Commit_User_View;
SELECT * FROM Branch_Repository_View;
SELECT * FROM Collaborator_Repository_View;
SELECT * FROM Star_Repository_View;
SELECT * FROM Follower_User_View;
SELECT * FROM Repository_Collaborator_User_View;
SELECT * FROM Issue_Comment_User_View;
SELECT * FROM Star_Repository_User_View;
SELECT * FROM Branch_Commit_Repository_View;

DROP TRIGGER IF EXISTS user_insert_trigger;
DROP TRIGGER IF EXISTS user_update_trigger;
DROP TRIGGER IF EXISTS user_delete_trigger;
DROP TRIGGER IF EXISTS repository_insert_trigger;
DROP TRIGGER IF EXISTS repository_update_trigger;
DROP TRIGGER IF EXISTS repository_delete_trigger;
DROP TRIGGER IF EXISTS issue_insert_trigger;
DROP TRIGGER IF EXISTS issue_update_trigger;
DROP TRIGGER IF EXISTS issue_delete_trigger;
DROP TRIGGER IF EXISTS comment_insert_trigger;
DROP TRIGGER IF EXISTS comment_update_trigger;
DROP TRIGGER IF EXISTS comment_delete_trigger;
DROP TRIGGER IF EXISTS commit_insert_trigger;
DROP TRIGGER IF EXISTS commit_update_trigger;
DROP TRIGGER IF EXISTS commit_delete_trigger;
DROP TRIGGER IF EXISTS branch_insert_trigger;
DROP TRIGGER IF EXISTS branch_update_trigger;
DROP TRIGGER IF EXISTS branch_delete_trigger;
DROP TRIGGER IF EXISTS star_insert_trigger;
DROP TRIGGER IF EXISTS star_delete_trigger;
DROP TRIGGER IF EXISTS follower_insert_trigger;
DROP TRIGGER IF EXISTS follower_delete_trigger;
DROP TRIGGER IF EXISTS new_follower_trigger;
DROP TRIGGER IF EXISTS new_star_trigger;
DROP TRIGGER IF EXISTS new_comment_trigger;
DROP TRIGGER IF EXISTS new_commit_trigger;
DROP TRIGGER IF EXISTS new_issue_trigger;

DROP TABLE IF EXISTS [Follower]
DROP TABLE IF EXISTS [Star]
DROP TABLE IF EXISTS [Collaborator]
DROP TABLE IF EXISTS [Branch]
DROP TABLE IF EXISTS [Commit]
DROP TABLE IF EXISTS [Comment]
DROP TABLE IF EXISTS [Issue]
DROP TABLE IF EXISTS [Repository]
DROP TABLE IF EXISTS [User]