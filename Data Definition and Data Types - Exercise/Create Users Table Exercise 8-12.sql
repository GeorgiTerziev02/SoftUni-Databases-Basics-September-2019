CREATE TABLE Users(
    Id BIGINT PRIMARY KEY IDENTITY,
	Username VARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(MAX),
	CHECK(DATALENGTH(ProfilePicture)<= 921600),
	LastLoginTime DATETIME2,
	IsDeleted BIT
)

INSERT INTO Users(Username, [Password], ProfilePicture, LastLoginTime, IsDeleted) VALUES
    ('Pesho', '1238', NULL, NULL, 0),
	('Gosho', '1237', NULL, NULL, 0),
	('Ivan', '1236', NULL, NULL, 0),
	('Test', '1235', NULL, NULL, 0),
	('Test123', '1234', NULL, NULL, 0)

SELECT * FROM Users
--change primary key exercise 9
ALTER TABLE Users
DROP CONSTRAINT PK__Users__3214EC078250B297

ALTER TABLE Users
ADD CONSTRAINT Add_PK
PRIMARY KEY(Id, Username)

--check constraint exercise 10

ALTER TABLE Users
ADD CONSTRAINT PLCheck_Password CHECK (LEN([Password])>=5)

INSERT INTO Users(Username, [Password], ProfilePicture,IsDeleted) VALUES
    ('Pes2', '1238', NULL, 1)

--default value exercise 11
ALTER TABLE Users
ADD CONSTRAINT DF_LastLoginTime
DEFAULT GETDATE() FOR LastLoginTime

INSERT INTO Users(Username, [Password], ProfilePicture,IsDeleted) VALUES
    ('Pesho12', '123821', NULL, 1)

SELECT * FROM Users

--set unique field exercise 12
ALTER TABLE Users
DROP CONSTRAINT Add_PK

ALTER TABLE Users
ADD CONSTRAINT Add_PKId
PRIMARY KEY (Id)

ALTER TABLE Users
ADD CONSTRAINT UQ_Username
UNIQUE (Username)

ALTER TABLE Users
ADD CONSTRAINT PLCheck_Username CHECK (LEN(Username)>=3)

SELECT * FROM Users

