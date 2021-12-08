-- See patient info (VIEW)
CREATE VIEW patientsInfo
AS
SELECT p.DATE, s.TYPE AS 'Sex Type', person.NAME, person.LAST_NAME, b.BLOOD_CLASS, cs.STATUS
FROM patients AS p 
	JOIN blood_type as b
		ON p.BLOOD_TYPE_CODE = b.BLOOD_TYPE_CODE
	JOIN people as person
		ON p.PERSON_CODE = person.PERSON_CODE
	JOIN sex_type as s
		ON p.SEX_TYPE_CODE = s.SEX_TYPE_CODE
	JOIN civil_status as cs
		ON p.STATUS_CODE = cs.STATUS_CODE;

SELECT * FROM patientsInfo;        

-- See patient address
CREATE VIEW patientAddress
AS    
SELECT p.PATIENT_CODE, person.NAME, person.LAST_NAME, a.ADDRESS
FROM patients as p
	JOIN people as person
		ON p.PERSON_CODE = person.PERSON_CODE
	JOIN addresses as a
		ON person.PERSON_CODE = a.PERSON_CODE;

DROP VIEW patientAddress;

SELECT * FROM patientAddress;

-- See patient relatives
CREATE VIEW patientsRelative
AS
SELECT person.*, relative.NAME AS RelativeName, relative.LAST_NAME as RelativeLastName, f.PARENTSHIP_TYPE as Parentship
FROM people as person
	JOIN families as f
		ON person.PERSON_CODE = f.PERSON_CODE
	JOIN people as relative
		ON f.RELATIVE_CODE = relative.PERSON_CODE;

SELECT * FROM patientsRelative;

-- patient personal information (address, phone, document, civil status)
CREATE VIEW patientsPersonalInformation
AS
SELECT p.PATIENT_CODE as PatientNumber, person.NAME, person.LAST_NAME,
		dt.DOCUMENT_TYPE as DocumentType, d.DOCUMENT_NUMBER as DocumentNumber,
        ph.PHONE_TYPE_CODE, ph.PHONE_NUMBER as PhoneNumber,
        ad.ADDRESS
FROM patients as p
	JOIN people as person
		ON p.PERSON_CODE = person.PERSON_CODE
	JOIN addresses as ad
		ON person.PERSON_CODE = ad.PERSON_CODE
	JOIN phones as ph
		ON person.PERSON_CODE = ph.PERSON_CODE
		JOIN phone_types as pt
			ON ph.PHONE_TYPE_CODE = pt.PHONE_TYPE_CODE
	JOIN documents as d
		ON person.PERSON_CODE = d.PERSON_CODE
        JOIN document_type as dt
			ON d.DOCUMENT_TYPE_CODE = dt.DOCUMENT_TYPE_CODE;
            
SELECT * FROM patientsPersonalInformation;

-- Patient ClinicalHistoric
CREATE VIEW patientClinicalHistory
AS
SELECT p.PATIENT_CODE as PatientCode, person.NAME as FirstName, person.LAST_NAME as LastName, ch.HISTORIC as Historic
FROM patients as p
	JOIN clinic_historic as ch
		ON p.PATIENT_CODE = ch.PATIENT_CODE
	JOIN people as person
		ON p.PERSON_CODE = person.PERSON_CODE;

SELECT * FROM patientClinicalHistory;
