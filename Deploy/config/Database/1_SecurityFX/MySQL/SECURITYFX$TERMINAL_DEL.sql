DROP PROCEDURE IF EXISTS SECURITYFX$TERMINAL_DEL;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$TERMINAL_DEL (
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
    IN  _TERMINAL_NAME      VARCHAR(100)
)
BEGIN
    -- Normalize specified terminal name
    SET _TERMINAL_NAME = UPPER(RTRIM(_TERMINAL_NAME));

    -- Delete the properties of specified terminal
    DELETE FROM EcuACCNET
    WHERE  V_NET_NOMBRE = _TERMINAL_NAME;

    -- Generate an audit record
    CALL SECURITYFX$AUDIT_PUT(
        _WSS_USER_CODE, _WSS_PROFILE_CODE,  _WSS_STATION_CODE,
        12, CONCAT('Terminal fue eliminado: ', _TERMINAL_NAME));
END$$
DELIMITER ;
