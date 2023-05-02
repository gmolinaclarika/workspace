CREATE OR REPLACE PROCEDURE MCASTADMIN$MRESPONSE_GET
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
    MRESPONSE_ID$           IN  DECIMAL,
    MULTICAST_ID$           OUT DECIMAL,
    MESSAGE$                OUT NVARCHAR2,
    STATION_CODE$           OUT NVARCHAR2,
    REQUEST_TIME$           OUT TIMESTAMP,
    RESPONSE_TIME$          OUT TIMESTAMP,
    ATTACHMENT_TYPE$        OUT NVARCHAR2,
    ATTACHMENT$             OUT BLOB
)
AS
BEGIN
    SELECT
        MULTICAST_ID,
        MESSAGE,
        STATION_CODE,
        REQUEST_TIME,
        RESPONSE_TIME,
        ATTACHMENT_TYPE,
        ATTACHMENT
    INTO
        MULTICAST_ID$,
        MESSAGE$,
        STATION_CODE$,
        REQUEST_TIME$,
        RESPONSE_TIME$,
        ATTACHMENT_TYPE$,
        ATTACHMENT$
    FROM  DESKTOPFX_MRESPONSE
    WHERE ID = MRESPONSE_ID$;
END MCASTADMIN$MRESPONSE_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
