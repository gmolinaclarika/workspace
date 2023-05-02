DROP PROCEDURE IF EXISTS DESKTOPFX$LOGOUT;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$LOGOUT (
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
    IN  _LAST_DESKTOP       INTEGER,
    IN  _LOGIN_STATE        LONGBLOB
)
BEGIN
    DECLARE _USER_ID    BIGINT;
    DECLARE _LAST_POLL  DATETIME(3);

    -- Compute last poll datetime
    IF (_LAST_DESKTOP = 0) THEN
        SET _LAST_POLL = NOW(3);
    ELSE    
        SET _LAST_POLL = NOW(3) - INTERVAL 5 MINUTE;
    END IF;

    -- Obtain ID of specified user
    SELECT ID INTO _USER_ID
    FROM   DESKTOPFX_USER
    WHERE  USER_CODE = _WSS_USER_CODE;

    -- Update user (if user found)
    IF (_USER_ID IS NOT NULL) THEN
        -- Update last user poll date
        UPDATE DESKTOPFX_USER
        SET    LAST_POLL = _LAST_POLL
        WHERE  ID = _USER_ID;

        -- Update login state (if supplied)
        IF (_LOGIN_STATE IS NOT NULL) THEN
            UPDATE DESKTOPFX_LOGIN
            SET    LOGIN_STATE = _LOGIN_STATE
            WHERE  USER_ID = _USER_ID
            AND    PROFILE_CODE = _WSS_PROFILE_CODE;
        END IF;
    END IF;
END$$
DELIMITER ;
