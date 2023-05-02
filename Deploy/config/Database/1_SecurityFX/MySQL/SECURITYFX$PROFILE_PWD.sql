DROP PROCEDURE IF EXISTS SECURITYFX$PROFILE_PWD;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$PROFILE_PWD (
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
    IN  _PROFILE_CODE       INTEGER,
    IN  _PROFILE_WORD       DECIMAL(18)
)
BEGIN
    DECLARE _MESSAGE_TEXT VARCHAR(200);

    -- Update the password of the Profile
    UPDATE EcuACCPER
    SET    V_ACC_OTRAS_PASSW_006 = V_ACC_OTRAS_PASSW_005,
           V_ACC_OTRAS_PASSW_005 = V_ACC_OTRAS_PASSW_004,
           V_ACC_OTRAS_PASSW_004 = V_ACC_OTRAS_PASSW_003,
           V_ACC_OTRAS_PASSW_003 = V_ACC_OTRAS_PASSW_002,
           V_ACC_OTRAS_PASSW_002 = V_ACC_OTRAS_PASSW_001,
           V_ACC_OTRAS_PASSW_001 = V_ACC_PASSWORD,
           V_ACC_PASSWORD        = _PROFILE_WORD
    WHERE  V_ACC_CODE_NUM = _PROFILE_CODE;
    IF (ROW_COUNT() = 0) THEN
        SET _MESSAGE_TEXT = CONCAT('Perfil no está definido: ', _PROFILE_CODE);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;
END$$
DELIMITER ;
