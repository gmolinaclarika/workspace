DROP PROCEDURE IF EXISTS DESKTOPFX$WORD_SET;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$WORD_SET (
-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------
    IN  _USER_CODE          VARCHAR(100),
    IN  _USER_WORD          VARCHAR(200),
    OUT _UPDATED            INTEGER
)
BEGIN
    DECLARE _PASSWORD           CHAR(51);
    DECLARE _PSW_ULTIMAS_001    CHAR(51);
    DECLARE _PSW_ULTIMAS_002    CHAR(51);
    DECLARE _PSW_ULTIMAS_003    CHAR(51);
    DECLARE _PSW_ULTIMAS_004    CHAR(51);
    DECLARE _PSW_ULTIMAS_005    CHAR(51);
    DECLARE _PSW_ULTIMAS_006    CHAR(51);
    DECLARE _FEC_VIG_DESD       DECIMAL(8);
    DECLARE _FEC_VIG_HAST       DECIMAL(8);
    DECLARE _YYYYMMDD           DECIMAL(8);
    DECLARE _USU_ESTADO         CHAR(2);
    DECLARE _PSW_TIPO           CHAR(3);
    DECLARE _MESSAGE_TEXT       VARCHAR(200);

    -- Obtain properties of specified user
    SELECT PASSWORD,
           PSW_ULTIMAS_001,
           PSW_ULTIMAS_002,
           PSW_ULTIMAS_003,
           PSW_ULTIMAS_004,
           PSW_ULTIMAS_005,
           PSW_ULTIMAS_006,
           FEC_VIG_DESD,
           FEC_VIG_HAST,
           USU_ESTADO,
           PSW_TIPO
    INTO   _PASSWORD,
           _PSW_ULTIMAS_001,
           _PSW_ULTIMAS_002,
           _PSW_ULTIMAS_003,
           _PSW_ULTIMAS_004,
           _PSW_ULTIMAS_005,
           _PSW_ULTIMAS_006,
           _FEC_VIG_DESD,
           _FEC_VIG_HAST,
           _USU_ESTADO,
           _PSW_TIPO
    FROM  EcuACCUSU
    WHERE USU_CODIGO = _USER_CODE;
    IF (FOUND_ROWS() = 0) THEN
        SET _MESSAGE_TEXT = CONCAT('Usuario no está definido: ', _USER_CODE);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Obtain current date in "YYYYMMDD" decimal format
    SET _YYYYMMDD = CONVERT(DATE_FORMAT(NOW(3), '%Y%m%d'), DECIMAL(8));

    -- Check the user is working in valid date range
    IF (_YYYYMMDD < _FEC_VIG_DESD) OR (_YYYYMMDD > _FEC_VIG_HAST) THEN
        SET _MESSAGE_TEXT = CONCAT('Usuario no autorizado en esta fecha: ', _USER_CODE);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Check the password can be changed (is not 'FIJ')
    IF (_PSW_TIPO != 'CAD') AND (_PSW_TIPO != 'NCA') THEN
        SET _MESSAGE_TEXT = 'La contraseña no se puede cambiar porque está bloqueada';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Check the user is not disabled ('HA' = habilitado)
    IF (_USU_ESTADO != 'HA') THEN
        SET _MESSAGE_TEXT = CONCAT('Usuario está deshabilitado: ', _USER_CODE);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Check new password has not been used before
    IF (_PASSWORD        = _USER_WORD)
    OR (_PSW_ULTIMAS_001 = _USER_WORD)
    OR (_PSW_ULTIMAS_002 = _USER_WORD)
    OR (_PSW_ULTIMAS_003 = _USER_WORD)
    OR (_PSW_ULTIMAS_004 = _USER_WORD)
    OR (_PSW_ULTIMAS_005 = _USER_WORD)
    OR (_PSW_ULTIMAS_006 = _USER_WORD) 
    THEN
        SET _MESSAGE_TEXT = 'Contraseña ya se utilizó anteriormente';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Update user password info
    UPDATE EcuACCUSU
    SET    PSW_ULTIMAS_006 = PSW_ULTIMAS_005,
           PSW_ULTIMAS_005 = PSW_ULTIMAS_004,
           PSW_ULTIMAS_004 = PSW_ULTIMAS_003,
           PSW_ULTIMAS_003 = PSW_ULTIMAS_002,
           PSW_ULTIMAS_002 = PSW_ULTIMAS_001,
           PSW_ULTIMAS_001 = PASSWORD,
           PASSWORD        = _USER_WORD,
           PSW_VIG_DESD    = _YYYYMMDD,
           PSW_ESTADO      = 'VIG'
    WHERE  USU_CODIGO = _USER_CODE
    AND    USU_ESTADO = 'HA'
    AND    PSW_TIPO  IN ('CAD', 'NCA')
    AND    _YYYYMMDD BETWEEN FEC_VIG_DESD AND FEC_VIG_HAST;
    IF (ROW_COUNT() = 0) THEN
        SET _MESSAGE_TEXT = CONCAT('No se pudo cambiar la contraseña de ', _USER_CODE);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- User updated
    SET _UPDATED = 1;
END$$
DELIMITER ;
