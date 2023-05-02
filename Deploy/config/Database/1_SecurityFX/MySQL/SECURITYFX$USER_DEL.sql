DROP PROCEDURE IF EXISTS SECURITYFX$USER_DEL;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$USER_DEL (
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
    IN  _USER_CODE          VARCHAR(100)
)
BEGIN
    DECLARE _MESSAGE_TEXT VARCHAR(200);

    -- Cannot delete ADMIN user
    SET _USER_CODE = UPPER(RTRIM(_USER_CODE));
    IF (_USER_CODE = 'ADMIN') THEN
        SET _MESSAGE_TEXT = CONCAT('No puede borrar el usuario: ', _USER_CODE);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Delete all profiles of the user
    DELETE FROM EcuACCU2P
    WHERE CODIGO_ADI = _USER_CODE;

    -- Delete all capacities of the user
    DELETE FROM EcuACCC2U
    WHERE CODIGO_ADI = _USER_CODE;

    -- Delete the properties of the user
    DELETE FROM EcuACCUSU
    WHERE  USU_CODIGO = _USER_CODE;

    -- Generate an audit record
    CALL SECURITYFX$AUDIT_PUT(
        _WSS_USER_CODE, _WSS_PROFILE_CODE,  _WSS_STATION_CODE,
        57, CONCAT('Usuario fue eliminado: ', _USER_CODE));
END$$
DELIMITER ;
