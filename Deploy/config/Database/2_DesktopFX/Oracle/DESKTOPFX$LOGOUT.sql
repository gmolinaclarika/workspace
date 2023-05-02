CREATE OR REPLACE PROCEDURE DESKTOPFX$LOGOUT
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
(
    WSS_USER_CODE$          IN  NVARCHAR2,
    WSS_PROFILE_CODE$       IN  INTEGER,
    WSS_STATION_CODE$       IN  NVARCHAR2,
    --------------------------------------
    LAST_DESKTOP$           IN  INTEGER,
    LOGIN_STATE$            IN  BLOB
)
AS
    LAST_POLL$              DESKTOPFX_USER.LAST_POLL%TYPE;
    USER_ID$                DESKTOPFX_USER.ID%TYPE;
BEGIN
    -- Compute last poll datetime
    IF (LAST_DESKTOP$ = 0) THEN
        LAST_POLL$ := SYSTIMESTAMP;
    ELSE    
        LAST_POLL$ := SYSTIMESTAMP - INTERVAL '5' MINUTE;
    END IF;

    -- Update last user poll date
    UPDATE DESKTOPFX_USER
    SET    LAST_POLL = LAST_POLL$
    WHERE  USER_CODE = WSS_USER_CODE$
    RETURNING ID INTO USER_ID$;

    -- Update login state if not null
    IF (USER_ID$ IS NOT NULL) THEN
        IF (LOGIN_STATE$ IS NOT NULL) THEN
            UPDATE DESKTOPFX_LOGIN
            SET    LOGIN_STATE = LOGIN_STATE$
            WHERE  USER_ID = USER_ID$
            AND    PROFILE_CODE = WSS_PROFILE_CODE$;
        END IF;
    END IF;
END DESKTOPFX$LOGOUT;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
