-- CREATE DATABASE hospital;
-- DROP DATABASE hospital;
USE hospital;

DROP TABLE IF EXISTS clinic_historic;
DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS documents;
DROP TABLE IF EXISTS addresses;
DROP TABLE IF EXISTS document_type;
DROP TABLE IF EXISTS families;
DROP TABLE IF EXISTS phones;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS phone_types;
DROP TABLE IF EXISTS civil_status;
DROP TABLE IF EXISTS cities;
DROP TABLE IF EXISTS provinces;
DROP TABLE IF EXISTS blood_type;
DROP TABLE IF EXISTS sex_type;

CREATE TABLE IF NOT EXISTS sex_type
(
  SEX_TYPE_CODE INT PRIMARY KEY AUTO_INCREMENT,
  TYPE VARCHAR(1) NOT NULL
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS blood_type
(
  BLOOD_TYPE_CODE INT PRIMARY KEY AUTO_INCREMENT,
  BLOOD_CLASS ENUM('A+','A-','B+','B-','AB+','AB-','O+','O-') NOT NULL
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS provinces
(
  PROVINCE_CODE INT PRIMARY KEY AUTO_INCREMENT,
  NAME VARCHAR(20) NOT NULL
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS cities
(
  CITY_CODE INT PRIMARY KEY AUTO_INCREMENT,
  CITY_NAME NVARCHAR(20) NOT NULL,
  POSTAL_CODE INT NOT NULL,
  PROVINCE_CODE INT,
  FOREIGN KEY (PROVINCE_CODE) REFERENCES provinces(PROVINCE_CODE)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS civil_status
(
  STATUS_CODE INT PRIMARY KEY AUTO_INCREMENT,
  STATUS VARCHAR(20) NOT NULL
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS phone_types
(
  PHONE_TYPE_CODE INT PRIMARY KEY AUTO_INCREMENT,
  PHONE_TYPE NVARCHAR(20) NOT NULL
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS people
(
  PERSON_CODE INT PRIMARY KEY AUTO_INCREMENT,
  NAME NVARCHAR(20) NOT NULL,
  LAST_NAME NVARCHAR(30) NOT NULL
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS phones
(
  PHONE_CODE INT PRIMARY KEY AUTO_INCREMENT,
  PHONE_NUMBER VARCHAR(15) NOT NULL,
  PHONE_TYPE_CODE INT,
  PERSON_CODE INT,
  FOREIGN KEY (PHONE_TYPE_CODE) REFERENCES phone_types(PHONE_TYPE_CODE),
  FOREIGN KEY (PERSON_CODE) REFERENCES people(PERSON_CODE)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS families
(
  FAMILY_CODE INT PRIMARY KEY AUTO_INCREMENT,
  PERSON_CODE INT,
  RELATIVE_CODE INT,
  PARENTSHIP_TYPE ENUM('Father', 'Mother', 'Son', 'Daughter', 'Brother', 'Sister', 'Uncle', 'Aunt', 'Cousin', 'Nephew', 'Niece', 'Husband', 'Wife', 'GrandMother', 'GrandFather'),
  FOREIGN KEY (RELATIVE_CODE) REFERENCES people(PERSON_CODE)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS document_type
(
  DOCUMENT_TYPE_CODE INT PRIMARY KEY AUTO_INCREMENT,
  DOCUMENT_TYPE NVARCHAR(20) NOT NULL
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS addresses
(
  ADDRESS_CODE INT PRIMARY KEY AUTO_INCREMENT,
  ADDRESS NVARCHAR(100) NOT NULL,
  PERSON_CODE INT,
  FOREIGN KEY (PERSON_CODE) REFERENCES people(PERSON_CODE)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS documents
(
  DOCUMENT_CODE INT PRIMARY KEY AUTO_INCREMENT,
  DOCUMENT_NUMBER VARCHAR(20) NOT NULL,
  DOCUMENT_TYPE_CODE INT,
  PERSON_CODE INT,
  FOREIGN KEY (DOCUMENT_TYPE_CODE) REFERENCES document_type(DOCUMENT_TYPE_CODE),
  FOREIGN KEY (PERSON_CODE) REFERENCES people(PERSON_CODE)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS patients
(
  PATIENT_CODE INT PRIMARY KEY AUTO_INCREMENT,
  DATE VARCHAR(20),
  PHOTO VARCHAR(200),
  PERSON_CODE INT,
  BLOOD_TYPE_CODE INT,
  SEX_TYPE_CODE INT,
  STATUS_CODE INT,
  CITY_CODE INT,
  PATIENT_STATUS ENUM('Healed', 'Sick'),
  FOREIGN KEY (PERSON_CODE) REFERENCES people(PERSON_CODE),
  FOREIGN KEY (BLOOD_TYPE_CODE) REFERENCES blood_type(BLOOD_TYPE_CODE),
  FOREIGN KEY (SEX_TYPE_CODE) REFERENCES sex_type(SEX_TYPE_CODE),
  FOREIGN KEY (STATUS_CODE) REFERENCES civil_status(STATUS_CODE),
  FOREIGN KEY (CITY_CODE) REFERENCES cities(CITY_CODE)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS clinic_historic
(
  CLINIC_HISTORIC_CODE INT PRIMARY KEY AUTO_INCREMENT,
  HISTORIC NVARCHAR(200) NOT NULL,
  PATIENT_CODE INT,
  FOREIGN KEY (PATIENT_CODE) REFERENCES patients(PATIENT_CODE)
) ENGINE=INNODB;	
