DROP PROCEDURE IF EXISTS DESKTOPFX$STARTUP;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$STARTUP (
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
    IN  _SERIAL             VARCHAR(200),
    IN  _NONCE              LONGBLOB,
    OUT _VERSION            INTEGER,
    OUT _BYTES              LONGBLOB,
    OUT _DIGEST             LONGBLOB
)
BEGIN
    DECLARE _MESSAGE_TEXT   VARCHAR(200);

    -- Initialize outputs
    SET _VERSION = NULL;
    SET _BYTES = NULL;
    SET _DIGEST = NULL;

    -- Verify station name
    IF (LENGTH(_WSS_STATION_CODE) = 0) THEN
        SET _MESSAGE_TEXT = 'No se suministro nombre de la estación de trabajo';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Verify serial number
    IF (LENGTH(_SERIAL) = 0) THEN
        SET _MESSAGE_TEXT = 'No se suministro serie de la estación de trabajo';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
    END IF;

    -- Return startup properties (NULL if not defined)
    SELECT BYTES INTO _BYTES
    FROM   DESKTOPFX_OBJECT
    WHERE  LOGIN_ID = 0
    AND    TYPE = 1
    AND    NAME = 'STARTUP';
END$$
DELIMITER ;
