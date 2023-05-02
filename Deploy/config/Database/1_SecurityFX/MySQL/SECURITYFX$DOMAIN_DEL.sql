DROP PROCEDURE IF EXISTS SECURITYFX$DOMAIN_DEL;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$DOMAIN_DEL (
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
    IN  _DOMAIN_NAME        VARCHAR(100)
)
BEGIN
    DECLARE _MESSAGE_TEXT VARCHAR(200);

    -- Normalize specified domain name
    SET _DOMAIN_NAME = UPPER(RTRIM(_DOMAIN_NAME));
    IF (_DOMAIN_NAME = 'GENERAL') THEN
        SET _MESSAGE_TEXT = CONCAT('Cannot delete domain: ', _DOMAIN_NAME);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Delete the properties of specified domain
    DELETE FROM EcuACCFAM
    WHERE  V_FAM_FAMILIA = _DOMAIN_NAME;

    -- Generate an audit record
    CALL SECURITYFX$AUDIT_PUT(
        _WSS_USER_CODE, _WSS_PROFILE_CODE, _WSS_STATION_CODE,
        12, CONCAT('Familia fue eliminada: ', _DOMAIN_NAME));
END$$
DELIMITER ;
