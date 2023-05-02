DROP PROCEDURE IF EXISTS DESKTOPFX$LOGIN_PROFS;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$LOGIN_PROFS (
-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------
    IN  _WSS_USER_CODE      VARCHAR(100),
    IN  _WSS_PROFILE_CODE   INTEGER,
    IN  _WSS_STATION_CODE   VARCHAR(100),
    -- ----------------------------------
    IN  _USER_WORD          VARCHAR(200),
    IN  _PROFILES_MAX       INTEGER
)
BEGIN
    DECLARE _REAL_WORD    VARCHAR(200);
    DECLARE _MESSAGE_TEXT VARCHAR(200);

    -- Obtain real user word
    SELECT RTRIM(PASSWORD) INTO _REAL_WORD
    FROM   EcuACCUSU
    WHERE  USU_CODIGO = _WSS_USER_CODE;
    IF (FOUND_ROWS() = 0) THEN
        SET _MESSAGE_TEXT = 'Usuario especificado no existe';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Check that real word matches supplied user word
    IF (_USER_WORD != _REAL_WORD) THEN
        SET _MESSAGE_TEXT = 'El usuario y/o la contraseña son incorrectos';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- #ResultSet PROFILE PROFILES
    --   #Column  PROFILE_CODE INTEGER
    --   #Column  PROFILE_NAME VARCHAR
    -- #EndResultSet
    SELECT
           P.V_ACC_CODE_NUM     AS PROFILE_CODE, 
           RTRIM(P.V_ACC_NAME)  AS PROFILE_NAME
    FROM  EcuACCPER P, EcuACCU2P X
    WHERE P.V_ACC_CODE_NUM = X.CODIGO_ECU
    AND   X.CODIGO_ADI = _WSS_USER_CODE
    ORDER BY P.V_ACC_CODE_NUM ASC
    LIMIT _PROFILES_MAX;
END$$
DELIMITER ;
