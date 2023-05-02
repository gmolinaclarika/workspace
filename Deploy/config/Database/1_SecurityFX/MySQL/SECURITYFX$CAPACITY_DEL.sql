DROP PROCEDURE IF EXISTS SECURITYFX$CAPACITY_DEL;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$CAPACITY_DEL (
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
    IN  _CAPACITY_CODE      VARCHAR(100)
)
BEGIN
    -- Normalize specified capacity name
    SET _CAPACITY_CODE = UPPER(RTRIM(_CAPACITY_CODE));

    -- Delete the properties of specified capacity
    DELETE FROM EcuACCCAP
    WHERE  CAP_CODIGO = _CAPACITY_CODE;

    -- Generate an audit record
    CALL SECURITYFX$AUDIT_PUT(
        _WSS_USER_CODE, _WSS_PROFILE_CODE, _WSS_STATION_CODE,
        12, CONCAT('Capacidad fue eliminada: ', _CAPACITY_CODE));
END$$
DELIMITER ;
