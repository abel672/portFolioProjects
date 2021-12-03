
-- AFTER delete patient, delete all the corresponding data 
DROP TRIGGER tr_tblPatient;
DELIMITER $$
CREATE TRIGGER tr_tblPatient
	AFTER DELETE
	ON clinic_historic FOR EACH ROW
BEGIN
	DELETE FROM patients WHERE PATIENT_CODE = OLD.PATIENT_CODE;
END$$

DELIMITER ;


-- Test
START TRANSACTION;
	DELETE FROM clinic_historic WHERE PATIENT_CODE = 1;
    
    SELECT * FROM patients WHERE PATIENT_CODE = 1; -- no result
ROLLBACK;

SELECT * FROM patients WHERE PATIENT_CODE = 1; -- result

-- Test local
START TRANSACTION;
	DELETE FROM people WHERE PERSON_CODE = 1;
ROLLBACK;

