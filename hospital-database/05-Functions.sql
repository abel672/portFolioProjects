DELIMITER $$
CREATE FUNCTION tableExists (_tableName nvarchar(255))
RETURNS BOOLEAN
BEGIN
	IF (SELECT COUNT(*) FROM information_schema.tables
		WHERE table_schema = DATABASE()
		AND table_name = 'clinic_historic1') = 1
	THEN
		RETURN TRUE;
	ELSE
		RETURN FALSE;
        END IF;
END$$
DELIMITER ;
