CREATE OR REPLACE PROCEDURE DESKTOPFX$STARTUP
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
    SERIAL$                 IN  NVARCHAR2,
    NONCE$                  IN  BLOB,
    VERSION$                OUT INTEGER,
    BYTES$                  OUT BLOB,
    DIGEST$                 OUT BLOB
)
AS
BEGIN
    -- Initialize outputs
    VERSION$ := NULL;
    BYTES$ := NULL;
    DIGEST$ := NULL;

    -- Verify station name
    IF (WSS_STATION_CODE$ IS NULL) THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se suministro nombre de la estación de trabajo');
    END IF;

    -- Verify serial number
    IF (SERIAL$ IS NULL) THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se suministro serie de la estación de trabajo');
    END IF;

    -- Return startup properties (NULL if not defined)
    BEGIN
        SELECT BYTES INTO BYTES$
        FROM   DESKTOPFX_OBJECT
        WHERE  LOGIN_ID = 0
        AND    TYPE = 1
        AND    NAME = 'STARTUP';
    EXCEPTION WHEN NO_DATA_FOUND THEN
        BYTES$ := NULL;
    END;
END DESKTOPFX$STARTUP;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
