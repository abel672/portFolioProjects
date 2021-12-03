DELIMITER $$
DROP PROCEDURE IF EXISTS getMalePatients;

CREATE PROCEDURE getMalePatients()
BEGIN
	SELECT person.NAME, person.LAST_NAME FROM patients as p
		JOIN sex_type as s
			ON p.SEX_TYPE_CODE = s.SEX_TYPE_CODE
		JOIN people as person
			ON p.PERSON_CODE = person.PERSON_CODE
	WHERE s.TYPE = 'M';
END$$

DROP PROCEDURE IF EXISTS getFemalePatients;
CREATE PROCEDURE getFemalePatients()
BEGIN
	SELECT person.NAME, person.LAST_NAME FROM patients as p
		JOIN sex_type as s
			ON p.SEX_TYPE_CODE = s.SEX_TYPE_CODE
		JOIN people as person
			ON p.PERSON_CODE = person.PERSON_CODE
	WHERE s.TYPE = 'F';
END$$

DELIMITER ;

call getMalePatients();

call getFemalePatients();
