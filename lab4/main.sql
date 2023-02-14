CREATE TABLE University(
  name varchar(225) NOT NULL PRIMARY KEY, 
  location varchar(225)
);

CREATE TABLE Course(
  name varchar(225) NOT NULL PRIMARY KEY, 
  credits int,
  U_name varchar(225) NOT NULL,
  FOREIGN KEY(U_name) REFERENCES University(name)
);

CREATE TABLE Student(
  id int NOT NULL PRIMARY KEY,
  S_name varchar(125),
  native_language varchar(225),
  U_name varchar(225) NOT NULL,
  FOREIGN KEY(U_name) REFERENCES University(U_name)
);

CREATE TABLE Enrollment(
  S_id int NOT NULL,
  C_name varchar(225) NOT NULL,
  CONSTRAINT PK_Enrollment PRIMARY KEY (S_id, C_name),
  FOREIGN KEY (S_id) REFERENCES Student(S_id),
  FOREIGN KEY (C_name) REFERENCES Course(C_name)
);
 
insert into University(name, location) values
    ("Innopolis", "Russia"),
    ("MIPT", "Russia"),
    ("MSU", "Russia"),
    ("MIT", "USA"),
    ("Harvard", "USA"),
    ("ASU", "USA"),
    ("Oxford", "England"),
    ("NYUAD", "Abu Dhabi");

insert into Course(name, credits, U_name) values
    ("ML", 2, "Innopolis"),
    ("Networking", 3, "MIPT"),
    ("Databases", 4, "MIT"),
    ("SNA", 5, "Harvard"),
    ("OS", 6, "Innopolis"),
    ("AI", 7, "Oxford"),
    ("DE", 8, "NYUAD");
    
insert into Student(id, S_name, native_language, U_name) values
    (1111, "Khabib Nur", "russian", "Innopolis"),
    (1112, "Jone Jones", "english", "MIPT"),
    (1113, "Conor McGregor", "english", "MIT"),
    (1114, "Daniel Cormie", "arabic", "NYUAD"),
    (2222, "Petr Yan", "russioa", "Innopolis"),
    (2223, "Sterling", "english", "Oxford"),
    (3333, "Mohammad Mokaev", "russian", "Harvard"),
    (4444, "Ivan Ivanov", "russian", "ASU"),
    (5555, "Islam Mac", "russian", "NYUAD");
    
-- Queries

-- a    
SELECT University.name FROM University
WHERE location = 'Russia';

-- b
SELECT University.location, University.name 
FROM University 
JOIN Student ON University.name = Student.U_name
WHERE University.location != 'Russia' AND Student.native_language = 'russian';

-- c
SELECT id FROM Student
WHERE Student.U_name = 'Innopolis';

-- d
SELECT name, U_name FROM Course
WHERE Course.credits > 5;

-- e
SELECT U_name 
FROM Student
JOIN University ON University.name = Student.U_name
WHERE Student.native_language = 'english'
