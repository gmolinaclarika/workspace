DROP PROCEDURE IF EXISTS DESKTOPFX$OBJECT_GET;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$OBJECT_GET (
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
    IN  _LEVEL              INTEGER,
    IN  _TYPE               INTEGER,
    IN  _NAME               VARCHAR(200),
    OUT _BYTES              LONGBLOB,
    OUT _GBYTES             LONGBLOB
)
BEGIN
    DECLARE _LOGIN_ID       BIGINT;
    DECLARE _PROFILE_CODE   INTEGER;
    DECLARE _MESSAGE_TEXT   VARCHAR(200);

    -- Obtain LoginID for User/Profile/Level
    SET _LOGIN_ID = 0;
    IF (_LEVEL >= -1) THEN
        IF (_LEVEL = -1) THEN
            SET _PROFILE_CODE = -1;
        ELSE
            SET _PROFILE_CODE = _WSS_PROFILE_CODE;
        END IF;
        SELECT g.ID INTO _LOGIN_ID
        FROM   DESKTOPFX_USER u, DESKTOPFX_LOGIN g
        WHERE  u.USER_CODE = _WSS_USER_CODE
        AND    g.PROFILE_CODE = _PROFILE_CODE
        AND    u.ID = g.USER_ID;
        IF (FOUND_ROWS() = 0) THEN
            SET _MESSAGE_TEXT = 'No existe login del usuario y perfil';
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = _MESSAGE_TEXT;
        END IF;
    END IF;

    -- Return object bytes
    SELECT BYTES INTO _BYTES
    FROM   DESKTOPFX_OBJECT
    WHERE  LOGIN_ID = _LOGIN_ID
    AND    TYPE = _TYPE
    AND    NAME = _NAME;

    -- Return GLOBAL (id=0) SETTINGS (type=3)
    SET _GBYTES = NULL;
    IF (_TYPE = 3) THEN
        SELECT BYTES INTO _GBYTES
        FROM   DESKTOPFX_OBJECT
        WHERE  LOGIN_ID = 0
        AND    TYPE = _TYPE
        AND    NAME = _NAME;
    END IF;
END$$
DELIMITER ;
