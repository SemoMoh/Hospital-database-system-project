-- Author : Ahmed Khaled Abdelmaksod 
-- date   : 14 Apr 2024
-- brief  : Contain the definations of Tables
-- Person Table
CREATE TABLE
    Person (
        SSN INTEGER NOT NULL IDENTITY (1, 1),
        ID INTEGER NOT NULL,
        Name VARCHAR(30),
        Nationality VARCHAR(30),
        DOB DATE,
        Street VARCHAR(30),
        Zone CHAR,
        PRIMARY KEY (SSN),
        UNIQUE (SSN),
        UNIQUE (ID)
    );

-- Person Phone_Table
CREATE TABLE
    Phone_Table (
        SSN INT,
        Phone char(11),
        PRIMARY KEY (SSN, Phone),
        FOREIGN KEY (SSN) REFERENCES Person ON DELETE CASCADE ON UPDATE CASCADE
    );

-- Patient Table 
CREATE TABLE
    Patient (
        SSN INTEGER NOT NULL,
        Reg_date DATE,
        Nurse_SSN INTEGER NOT NULL,
        PRIMARY KEY (SSN),
        FOREIGN KEY (SSN) REFERENCES Person ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Nurse_SSN) REFERENCES Nurse ON DELETE SET NULL ON UPDATE CASCADE
    );

-- Relative Table
CREATE TABLE
    Relative (
        Patient_SSN INTEGER NOT NULL,
        Name VARCHAR(30) NOT NULL,
        Phone_no CHAR(11),
        Relation VARCHAR(15),
        PRIMARY KEY (Patient_SSN, Name),
        FOREIGN KEY (Patient_SSN) REFERENCES Patient ON DELETE CASCADE ON UPDATE CASCADE
    );

-- Employee Table
CREATE Table
    Employee (
        SSN int NOT NULL PRIMARY KEY,
        Contract_Type VARCHAR(20),
        Contract_Start_Date DATE,
        Contract_ID INTEGER UNIQUE,
        Department_ID int,
        Super_SSN int,
        FOREIGN KEY (SSN) REFERENCES Person ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Department_ID) REFERENCES Department ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Super_SSN) REFERENCES Employee ON DELETE CASCADE ON UPDATE CASCADE
    );

-- Nurse Table 
CREATE TABLE
    Nurse (
        SSN int PRIMARY KEY,
        FOREIGN KEY (SSN) REFERENCES Employee ON UPDATE CASCADE ON DELETE CASCADE
    );

-- Staff Table
CREATE Table
    Staff (
        SSN int NOT NULL PRIMARY,
        Job_Title VARCHAR(20),
        FOREIGN KEY (SSN) REFERENCES Employee ON DELETE CASCADE ON UPDATE CASCADE
    );

-- Department Table
CREATE Table
    Department (
        ID int PRIMARY KEY,
        Name VARCHAR(30),
        Manager_SSN int,
        Manager_Start_Date DATE,
        FOREIGN KEY (Manager_SSN) REFERENCES Employee ON DELETE SET NULL ON UPDATE CASCADE
    );

-- Room Table
CREATE TABLE
    Room (
        Room_NO int PRIMARY KEY,
        Type VARCHAR(15),
        Available char,
        Department_ID int,
        Doctor_SSN int,
        FOREIGN KEY (Department_ID) REFERENCES Department ON DELETE SET NULL ON UPDATE CASCADE,
        FOREIGN KEY (Doctor_SSN) REFERENCES Doctor ON DELETE SET NULL ON UPDATE CASCADE,
    );

-- Doctor Table 
CREATE TABLE
    Doctor (
        SSN int PRIMARY,
        Specialization char(30),
        FOREIGN KEY (SSN) REFERENCES Employee ON DELETE SET NULL ON UPDATE CASCADE,
    );

-- Triage Table
CREATE Table
    Triage (
        ID int PRIMARY IDENTITY (1000, 1),
        Heart_Beats VARCHAR(30),
        Blood_Pressure VARCHAR(30),
        Weight FLOAT,
        Height FLOAT,
        Sugar_Level VARCHAR(20)
    );

-- Appointment Table
CREATE Table
    Appointment (
        ID int PRIMARY UNIQUE,
        Appointment_Date DATE,
        Price FLOAT,
        diagnoses VARCHAR(20)
    );

-- Perform Table
CREATE TABLE
    Perform (
        Nurse_SSN int,
        Triage_ID int,
        Patient_SSN int,
        PRIMARY KEY (Nurse_SSN, Triage_ID, Patient_SSN),
        FOREIGN KEY (Nurse_SSN) REFERENCES Nurse ON DELETE RESTRICT ON UPDATE CASCADE,
        FOREIGN KEY (Triage_ID) REFERENCES Triage ON DELETE RESTRICT ON UPDATE CASCADE,
        FOREIGN KEY (Patient_SSN) REFERENCES Patient ON DELETE RESTRICT ON UPDATE CASCADE,
    );

-- Make Table
CREATE Table
    Make (
        Doctor_SSN int,
        Patient_SSN int,
        Appointment_ID INT,
        Time Date,
        PRIMARY KEY (Doctor_SSN, Patient_SSN, Appointment_ID),
        FOREIGN KEY (Doctor_SSN) REFERENCES Doctor ON DELETE RESTRICT ON UPDATE CASCADE,
        FOREIGN KEY (Patient_SSN) REFERENCES Patient_SSN ON DELETE RESTRICT ON UPDATE CASCADE,
        FOREIGN KEY (Appointment_ID) REFERENCES Appointment ON DELETE RESTRICT ON UPDATE CASCADE,
    );