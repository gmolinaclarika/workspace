CREATE OR REPLACE PROCEDURE MCASTADMIN$MULTICAST_ADD
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
    NAME$                   IN  NVARCHAR2,
    MESSAGE$                IN  NVARCHAR2,
    VALID_FROM$             IN  TIMESTAMP,
    VALID_TO$               IN  TIMESTAMP,
    USER_FILTER$            IN  NVARCHAR2,
    PROFILE_FILTER$         IN  INTEGER,
    STATION_FILTER$         IN  NVARCHAR2,
    ATTACHMENT_TYPE$        IN  NVARCHAR2,
    ATTACHMENT$             IN  BLOB,
    NEW_MULTICAST_ID$       OUT DECIMAL
)
AS
BEGIN
    -- Create new Multicast instance
    INSERT INTO DESKTOPFX_MULTICAST (
        ID, NAME, MESSAGE, VALID_FROM, VALID_TO, USER_FILTER,
        PROFILE_FILTER, STATION_FILTER, ATTACHMENT_TYPE, ATTACHMENT
    ) VALUES (
        DESKTOPFX_MULTICAST_SQ.NEXTVAL, NVL(NAME$,' '), NVL(MESSAGE$,' '),
        VALID_FROM$, VALID_TO$, TRIM(USER_FILTER$), PROFILE_FILTER$,
        TRIM(STATION_FILTER$), TRIM(ATTACHMENT_TYPE$), ATTACHMENT$
    ) RETURNING
        ID INTO NEW_MULTICAST_ID$;
END MCASTADMIN$MULTICAST_ADD;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
