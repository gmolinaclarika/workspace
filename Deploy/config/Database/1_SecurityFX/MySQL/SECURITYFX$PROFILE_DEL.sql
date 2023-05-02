DROP PROCEDURE IF EXISTS SECURITYFX$PROFILE_DEL;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$PROFILE_DEL (
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
    IN  _PROFILE_CODE       INTEGER
)
BEGIN
    DECLARE _MESSAGE_TEXT VARCHAR(200);

    -- Cannot delete ADMIN (0) profile
    IF (_PROFILE_CODE = 0) THEN
        SET _MESSAGE_TEXT = CONCAT('No puede borrar el perfil: ', _PROFILE_CODE);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Delete all users of the profile
    DELETE FROM EcuACCU2P
    WHERE CODIGO_ECU = _PROFILE_CODE;

    -- Delete all capacities of the profile
    DELETE FROM EcuACCC2P
    WHERE CODIGO_ECU = _PROFILE_CODE;

    -- Delete the properties of the profile
    DELETE FROM EcuACCPER
    WHERE  V_ACC_CODE_NUM = _PROFILE_CODE;

    -- Generate an audit record
    CALL SECURITYFX$AUDIT_PUT(
        _WSS_USER_CODE, _WSS_PROFILE_CODE,  _WSS_STATION_CODE,
        57, CONCAT('Perfil fue eliminado: ', _PROFILE_CODE));
END$$
DELIMITER ;
