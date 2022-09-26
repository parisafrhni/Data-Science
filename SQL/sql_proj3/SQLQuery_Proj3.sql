CREATE TABLE Employee(
SSN char(9) UNIQUE NOT NULL,
DOB datetime,
Fname varchar(80),
Minit varchar(80),
Lname varchar(80),
address varchar(200),
PRIMARY KEY (SSN)
);

CREATE TABLE SalariedEmp
(
SSN1 char(9) UNIQUE NOT NULL,
monthly_pay numeric(8, 2),
Primary key (SSN1),
Foreign Key (SSN1) REFERENCES Employee(SSN)
);

CREATE TABLE HourlyEmp
(
SSN2 char(9) UNIQUE NOT NULL,
hourPay numeric(5, 2) CONSTRAINT CHK_hourPay CHECK (hourPay > 7.5),
Primary key (SSN2),
Foreign Key (SSN2) REFERENCES Employee(SSN)
);

CREATE TABLE Dependent
(
Name varchar(80) NOT NULL,
SSN char(9) UNIQUE NOT NULL,
relationship varchar(80) NOT NULL,
Primary key (SSN),
Foreign Key (SSN) REFERENCES Employee(SSN)
);

CREATE TABLE Department
(
deptNum char(3) UNIQUE NOT NULL,
deptName varchar(80),
Manager_SSN char(9),
PRIMARY KEY (deptNum),
Foreign Key (Manager_SSN) REFERENCES SalariedEmp(SSN1)
);

CREATE TABLE Location
(
Locations varchar(80) NOT NULL,
deptNum char(3) NOT NULL,
PRIMARY KEY (Locations, deptNum),
Foreign Key (deptNum) REFERENCES Department(deptNum)
);


CREATE TABLE Project
(
ProjName varchar(80) UNIQUE NOT NULL,
ProjNum char(4) UNIQUE NOT NULL,
ProjDesc varchar(100)
PRIMARY KEY (ProjName, ProjNum)
);

CREATE TABLE Works_On(
SSN char(9) NOT NULL,
ProjName varchar(80)  NOT NULL,
ProjNum char(4)  NOT NULL,
deptNum char(3)  NOT NULL,
Primary Key (SSN, ProjName,ProjNum, deptNum),
Foreign Key (SSN) REFERENCES Employee,
Foreign Key (ProjName, ProjNum) REFERENCES Project,
Foreign Key (deptNum) REFERENCES Department
);


INSERT INTO Employee Values ('111286793',1990/01/12, 'Ali', null, 'Rajabi', '180 L Street')
INSERT INTO Employee Values ('111286794',1986/11/25, 'Sima', null,'Pirouzi', '103 A Street')
INSERT INTO Employee Values ('111286795',1991/06/18, 'Sama', null, 'Iraj', '45 Good Street')
INSERT INTO Employee Values ('111286796',1989/07/21, 'Mona', null, 'Sari', '307 K Street')
INSERT INTO Employee Values ('111286797',1983/08/12, 'Shayan', null, 'Sohrabi', '119 Lake Street')
INSERT INTO Employee Values ('111286798',1990/06/23, 'Iman', null, 'Ilkhani', '580 wood Street')
INSERT INTO Employee Values ('111286799',1994/10/22, 'Omid', null, 'Sheykhi', '186 L Street')
INSERT INTO Employee Values ('111286811',1993/11/24, 'Anita', null, 'Hamedi', '173 Gate Street')
INSERT INTO Employee Values ('111286812',1990/09/22, 'Amir', null, 'Farhadi', '109 O Street')

SELECT * FROM Employee

INSERT INTO SalariedEmp Values ('111286793', 5700.00)
INSERT INTO SalariedEmp Values ('111286794', 7700.00)
INSERT INTO SalariedEmp Values ('111286795', 6800.00)
INSERT INTO SalariedEmp Values ('111286796', 9700.00)


SELECT * FROM SalariedEmp


INSERT INTO HourlyEmp VALUES ('111286797',27.00 )
INSERT INTO HourlyEmp VALUES ('111286798',30.00 )
INSERT INTO HourlyEmp VALUES ('111286799',27.00 )
INSERT INTO HourlyEmp VALUES ('111286811',32.00 )
INSERT INTO HourlyEmp VALUES ('111286812',28.00 )

SELECT * FROM HourlyEmp

INSERT INTO Dependent Values('Shima','111286797','wife')
INSERT INTO Dependent Values('Mahan','111286798','Son')
INSERT INTO Dependent Values('Sara','111286793','daughter')
INSERT INTO Dependent Values('Foad','111286811','husband')

SELECT * FROM Dependent


INSERT INTO Project Values('Java', '1763', 'Developing New Soft Ware')
INSERT INTO Project Values('LBridge', '3678', 'Repairing Bridge')
INSERT INTO Project Values('Watersupply', '1372', 'Solving Problem')
INSERT INTO Project Values('WindTurbin', '3254', 'Solving Problem')
SELECT * FROM Project

INSERT INTO Department Values('210', 'Computer Sci', '111286793')
INSERT INTO Department Values('406', 'Electrical Eng', '111286794')
INSERT INTO Department Values('407', 'Civil Eng', '111286795')
INSERT INTO Department Values('306', 'Physic', '111286796')
SELECT * FROM Department


INSERT INTO Location Values('Shin Street', '210')
INSERT INTO Location Values('Mall Street', '210')
INSERT INTO Location Values('Golden Street', '406')
INSERT INTO Location Values('Sali Street', '407')
INSERT INTO Location Values('End Street', '306')
SELECT * FROM Location


INSERT INTO Works_On Values('111286793', 'Java', '1763', '210')
INSERT INTO Works_On Values('111286794', 'WindTurbin', '3254', '406')
INSERT INTO Works_On Values('111286795', 'LBridge', '3678', '407')
INSERT INTO Works_On Values('111286796', 'WaterSupply', '1372', '306')
INSERT INTO Works_On Values('111286797', 'WaterSupply', '1372', '407')
INSERT INTO Works_On Values('111286798', 'Java', '1763', '210')
INSERT INTO Works_On Values('111286799', 'LBridge', '3678', '407')
INSERT INTO Works_On Values('111286812', 'Java', '1763', '210')
INSERT INTO Works_On Values('111286811', 'WindTurbin', '3254', '406')
INSERT INTO Works_On Values('111286795', 'WaterSupply', '1372', '407')



SELECT * FROM Works_On

UPDATE Employee
  SET Fname = 'Alireza'
  WHERE SSN = '111286793';


SELECT * FROM Employee

UPDATE HourlyEmp
SET hourPay = hourPay + 2
WHERE HourlyEmp.hourPay <= 30;

SELECT * FROM HourlyEmp

UPDATE SalariedEmp
SET monthly_pay = 10000.00
WHERE SSN1 IN(
SELECT SSN FROM Employee 
WHERE Fname = 'Sima');

SELECT * FROM SalariedEmp

SELECT * FROM Works_On

SELECT DISTINCT e.SSN, e.Fname
FROM Employee e
JOIN Works_On w ON w.SSN = e.SSN;

SELECT Employee.SSN, Employee.Fname, deptNum 
FROM Employee 
INNER JOIN Works_On w ON w.SSN = Employee.SSN;


SELECT Fname, Lname, SSN
FROM Employee
WHERE SSN IN (SELECT Manager_SSN FROM Department);

SELECT ProjName, COUNT(SSN)
FROM Works_On
GROUP BY ProjName
HAVING ProjName = 'Java';

SELECT Employee.SSN,Employee.Fname,Employee.Lname, Name, relationship
FROM Employee 
INNER JOIN Dependent w ON w.SSN = Employee.SSN;

SELECT address
FROM Employee 
UNION
SELECT Locations
FROM Location;