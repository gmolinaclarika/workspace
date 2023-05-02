CREATE OR REPLACE PROCEDURE DESKTOPFX$OBJECT_REN
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
    NEW_NAME$               IN  NVARCHAR2
)
AS
    LOGIN_ID$               DESKTOPFX_LOGIN.ID%TYPE;
    PROFILE_CODE$           DESKTOPFX_LOGIN.PROFILE_CODE%TYPE;
    OBJECT_ID$              DESKTOPFX_OBJECT.ID%TYPE;
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

    -- Cannot rename GLOBAL objects
    IF (LOGIN_ID$ = 0) THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se puede renombrar un objeto global');
    END IF;

    -- Check new name does not exist
    BEGIN
        SELECT ID INTO OBJECT_ID$
        FROM   DESKTOPFX_OBJECT
        WHERE  LOGIN_ID = LOGIN_ID$
        AND    TYPE = TYPE$
        AND    NAME = NEW_NAME$;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        OBJECT_ID$ := NULL;
    END;

    -- Check new name does not exist
    IF (OBJECT_ID$ IS NOT NULL) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nombre ya se encuentra en uso: ' || NEW_NAME$);
    END IF;

    -- Change old name to new name
    UPDATE DESKTOPFX_OBJECT
    SET    NAME = NEW_NAME$
    WHERE  LOGIN_ID = LOGIN_ID$
    AND    TYPE = TYPE$
    AND    NAME = NAME$;
END DESKTOPFX$OBJECT_REN;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
