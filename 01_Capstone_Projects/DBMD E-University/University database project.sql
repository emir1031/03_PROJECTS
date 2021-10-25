

--DBMD Lecture
--University Database Project 



--Create Database

Use Master


Create Database University

Use University


--//////////////////////////////


--Create Tables 
--Make sure you add the necessary constraints.
--You can define some check constraints while creating the table, but some you must define later with the help of a scalar-valued function you'll write.
--Check whether the constraints you defined work or not.
--Import Values (Use the Data provided in the Github repo). 
--You must create the tables as they should be and define the constraints as they should be. 
--You will be expected to get errors in some points. If everything is not as it should be, you will not get the expected results or errors.
--Read the errors you will get and try to understand the cause of the errors.


CREATE TABLE Region
(
RegionID INT IDENTITY(1, 1),
RegionName VARCHAR(25) CHECK (RegionName IN ('England', 'Scotland', 'Wales', 'Northern Ireland')) NOT NULL,
PRIMARY KEY (RegionID)
);




INSERT Region (RegionName)
VALUES('England'),
('Scotland'),
('Wales'),
('Northern Ireland');




CREATE TABLE Staff
(
StaffID INT IDENTITY(10, 1),
FirstName nVARCHAR(50) NOT NULL,
LastName nVARCHAR(50) NOT NULL,
RegionID INT NOT NULL,
PRIMARY KEY (StaffID),
FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);



INSERT Staff (FirstName, LastName,  RegionID)
VALUES('Kellie', 'Pear',  1),
('Harry', 'Smith', 1),
('Margeret', 'Nolan', 1),
('Neil', 'Mango', 2),
('Ross', 'Island', 2),
('October', 'Lime', 3),
('Tom', 'Garden', 4),
('Victor', 'Fig', 3),
('Yavette', 'Berry', 4)




--Her öðrencinin sadece ve mutlaka bir staff' ý olabileceði için (null deðer olamayacaðý için)
--staff id 'nin student tablosunda olmasýnýn herhangi bir sakýncasý bulunmamaktadýr.
--Yani staff ile student arasýndaki danýþmanlýk iliþkisi student tablosunda saðlanmýþ oldu



CREATE TABLE Student
(
StudentID INT IDENTITY(20, 1),
FirstName nVARCHAR(50) NOT NULL,
LastName nVARCHAR(50) NOT NULL,
Register_date Date NOT NULL DEFAULT '2020-05-12',
RegionID INT NOT NULL,
StaffID INT NOT NULL,
PRIMARY KEY (StudentID),
FOREIGN KEY (StaffID) REFERENCES Staff (StaffID),
FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);


INSERT INTO Student (FirstName, LastName, StaffID, RegionID)
VALUES('Zorro', 'Apple', 10, 1),
('Debbie', 'Orange', 17, 3),
('Charlie','Apricot', 11, 1),
('Ursula', 'Douglas', 13, 2),
('Bronwin', 'Blueberry', 14, 2),
('Alec', 'Hunter', 15, 3);



CREATE TABLE Course
(
CourseID INT IDENTITY(30, 1),
Title VARCHAR(50) NOT NULL,
Credit INT CHECK (Credit in (15,30)) NOT NULL,
PRIMARY KEY (CourseID)
);


INSERT Course (Title, Credit)
VALUES('French', 30),
('Physics', 30),
('Psychology', 30),
('History', 30),
('Biology', 15),
('Fine Arts', 15),
('German', 15),
('Music', 30),
('Chemistry', 30);



CREATE TABLE Enrollment
(
StudentID INT  NOT NULL, 
CourseID INT NOT NULL, 
PRIMARY KEY (StudentID, CourseID),
FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);



INSERT Enrollment
VALUES (22, 35),
(23, 35),
(24, 35),
(25, 35),
(22, 36),
(23, 36),
(24, 36),
(25, 36);





---////////////////////////////


CREATE TABLE StaffCourse
(
StaffID INT NOT NULL,
CourseID INT NOT NULL, 
PRIMARY KEY (StaffID, CourseID),
FOREIGN KEY (StaffID) REFERENCES Staff(StaffID), --ON DELETE CASCADE
FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);



INSERT INTO StaffCourse (StaffID, CourseID)
VALUES(10, 30),
(12, 30),
(10, 31),
(11, 31),
(12, 38),
(13, 35),
(11, 36),
(18, 34)




--////////////////////


--constraints

--Students are constrained in the number of courses they can be enrolled in at any one time. 
--They may not take courses simultaneously if their combined points total exceeds 180 points.



Create FUNCTION dbo.check_credit()
RETURNS INT
AS
BEGIN
	DECLARE @REJECT int

	IF EXISTS (
				SELECT 1
				FROM	(
						SELECT	B.StudentID, sum(Credit) sum_credit
						FROM	Course A 
						INNER JOIN Enrollment B 
						ON		A.CourseID = B.CourseID
						GROUP BY B.StudentID
						) A
				WHERE sum_credit > 180
			) 
		SET @REJECT = 1 
	ELSE
		SET @REJECT = 0

RETURN @REJECT
END;



ALTER TABLE Enrollment
ADD CONSTRAINT CK_check_credit CHECK(dbo.check_credit() = 0);



ALTER TABLE COURSE
ADD CONSTRAINT CK_check_credit2 CHECK(dbo.check_credit() = 0);







-------------------



--------///////////////////


--öðrencinin region' u ile danýþmanýnýn region' u ayný olmalý

CREATE FUNCTION check_region2()
RETURNS INT
AS
BEGIN
	DECLARE @REJECT int
		IF EXISTS(
					SELECT 1
					FROM Student A INNER JOIN Staff B ON A.StaffID = B.StaffID 
					WHERE A.RegionID != B.RegionID
				)
			SET @REJECT =1
		ELSE 
			SET @REJECT = 0

RETURN @REJECT
END;


ALTER TABLE Student
ADD CONSTRAINT CK_check_region2 CHECK(dbo.check_region2() = 0);









--///////////////////////////////



------ADDITIONALLY TASKS



--Test the credit limit constraint



INSERT INTO Enrollment (StudentID, CourseID)
VALUES (21, 30),
(21, 31),
(21, 32),
(21, 33),
(21, 35),
(21, 36),
(21, 37)




select * from COURSE

--constraint' i test edelim. kabul etmiyor çalýþýyor

INSERT Enrollment VALUES (21, 38)



--//////////////////////////////////

--Test that you have correctly defined the constraint for the student counsel's region. 

--aþaðýdaki öðrenciler ile danýþmanlarýnýn regionid' leri uyuþtuðu için kabul ediyor
INSERT INTO Student (FirstName, LastName, StaffID, RegionID)
VALUES
('Fred', 'Udress', 16, 4),
('Irene', 'Roland', 15, 3),
('Jack', 'Quince', 15, 3);




--fakat burada 16 nolu staff' in region' u 5 olmadýðý için bu insert' ý kabul etmiyor yani constraint çalýþýyor.
INSERT INTO Student (FirstName, LastName, StaffID, RegionID)
VALUES
('Paul', 'King', 16, 5)




--/////////////////////////


--Try to set the credits of the History course to 20. (You should get an error.)

UPDATE Course
SET Credit = 20
WHERE CourseID = 33



--/////////////////////////////

--Try to set the credits of the Fine Arts course to 30.(You should get an error.)

UPDATE Course
SET Credit = 30
WHERE CourseID = 35



SELECT  * FROM Course


--////////////////////////////////////

--Debbie Orange wants to enroll in Chemistry instead of German. (You should get an error.)



UPDATE Enrollment
SET CourseID = 38
WHERE StudentID = 21
AND CourseID = 36



SELECT * FROM Course







--//////////////////////////


--Try to set Tom Garden as counsel of Alec Hunter (You should get an error.)

UPDATE Student
SET StaffID = 16
WHERE StudentID = 25;


--/////////////////////////

--Swap counselors of Ursula Douglas and Bronwin Blueberry.


SELECT * FROM Student


--aþaðýdaki þekilde deðiþiklik yapamayýz. Çünkü ilk deðiþiklik gerçekleþtikten sonra ikincinin bir anlamý kalmýyor.

UPDATE Student
SET StaffID = (SELECT StaffID FROM Student WHERE StudentID=24) 
WHERE StudentID = 23;


UPDATE Student
SET StaffID = (SELECT StaffID FROM Student WHERE StudentID=23) 
WHERE StudentID = 24



---bu iþlemi aþaðýdaki þekilde yapmalýyýz.
--önce danýþmanlarýný deðiþtireceðimiz öðrencilerin staffid' lerini bir deðiþkene atýyoruz,
--Sonrasýndaki update iþleminde yeni deðer olarak bu deðiþkenleri belirtiyoruz.



DECLARE @FIRST_STAFF INT;
DECLARE @SECOND_STAFF INT;

SET @FIRST_STAFF = (SELECT StaffID FROM Student WHERE StudentID=23);
SET @SECOND_STAFF = (SELECT StaffID FROM Student WHERE StudentID=24);


UPDATE Student
SET StaffID = @FIRST_STAFF -- eski deðer 14
WHERE StudentID = 24;


UPDATE Student
SET StaffID = @SECOND_STAFF -- eski deðer 13
WHERE StudentID = 23




--///////////////////



-- Remove a staff member from the staff table.
--If you get an error, read the error and update the reference rules for the relevant foreign key.


--Þu haliyle delete iþleminden hata almanýz olasýdýr. Hatayý okuyunuz.
--StaffCourse tablosundaki bir foreign key kýsýtýnýn buna izin vermediðini söyleyecektir.
--Yani hata, foreign key rules diye ifade edilen ON DELETE/UPDATE koþullarýnýn foreign key iþlemine koyduðu kýsýtlar sebebiyle meydana geliyor.
--StaffCourse tablosunda staffid için foreign key constraint tanýmlarken (yukarýya dönüp bakýnýz) foreign key rule' u tanýmlamamýþ defoult ayarýyla býrakmýþtýk
--Defoult olarak ON DELETE NO ACTION olduðu için foreign key için yapýlacak olan delete iþlemine bloke koyuyor.
--StaffCourse tablosunda Staffid için tanýmlanan foreign key constraint' i ON DELETE CASCADE olarak yeniden oluþturursanýz delete iþlemini yapabilirsiniz.
--StaffCourse tablosunu drop edip yeniden create edebilirsiniz veya sadece foreign key constraint' i önce drop edip sonra yeni halini tabloya ekleyebilirsiniz.


SELECT * FROM Staff



DELETE FROM Staff 
WHERE StaffID = 15






 



















