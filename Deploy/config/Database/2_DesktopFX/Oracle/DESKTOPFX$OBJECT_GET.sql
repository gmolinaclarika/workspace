CREATE OR REPLACE PROCEDURE DESKTOPFX$OBJECT_GET
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
    LEVEL$                  IN  INTEGER,
    TYPE$                   IN  INTEGER,
    NAME$                   IN  NVARCHAR2,
    BYTES$                  OUT BLOB,
    GBYTES$                 OUT BLOB
)
AS
    LOGIN_ID$               DESKTOPFX_LOGIN.ID%TYPE;
    PROFILE_CODE$           DESKTOPFX_LOGIN.PROFILE_CODE%TYPE;
BEGIN
    -- Obtain LoginID for User/Profile/Level
    LOGIN_ID$ := 0;
    IF (LEVEL$ >= -1) THEN
        IF (LEVEL$ = -1) THEN
            PROFILE_CODE$ := -1;
        ELSE
            PROFILE_CODE$ := WSS_PROFILE_CODE$;
        END IF;
        BEGIN
            SELECT g.ID INTO LOGIN_ID$
            FROM   DESKTOPFX_USER u, DESKTOPFX_LOGIN g
            WHERE  u.USER_CODE = WSS_USER_CODE$
            AND    g.PROFILE_CODE = PROFILE_CODE$
            AND    u.ID = g.USER_ID;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'No existe login del usuario y perfil');
        END;
    END IF;

    -- Return object bytes
    BEGIN
        SELECT BYTES INTO BYTES$
        FROM   DESKTOPFX_OBJECT
        WHERE  LOGIN_ID = LOGIN_ID$
        AND    TYPE = TYPE$
        AND    NAME = NAME$;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        BYTES$ := NULL;
    END;

    -- Return GLOBAL (id=0) SETTINGS (type=3)
    GBYTES$ := NULL;
    IF (TYPE$ = 3) THEN
        BEGIN
            SELECT BYTES INTO GBYTES$
            FROM   DESKTOPFX_OBJECT
            WHERE  LOGIN_ID = 0
            AND    TYPE = TYPE$
            AND    NAME = NAME$;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            GBYTES$ := NULL;
        END;
    END IF;
END DESKTOPFX$OBJECT_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
