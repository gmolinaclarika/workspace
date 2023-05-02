CREATE OR REPLACE PROCEDURE DESKTOPFX$MRESPONSE_ADD
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
    MULTICAST_ID$           IN  DECIMAL,
    REQUEST_TIME$           IN  TIMESTAMP,
    MESSAGE$                IN  NVARCHAR2,
    ATTACHMENT_TYPE$        IN  NVARCHAR2,
    ATTACHMENT$             IN  BLOB,
    TRESPONSE_ID$           OUT DECIMAL
)
AS
BEGIN
    -- Add new Multicast Response record 
    INSERT INTO DESKTOPFX_MRESPONSE (
         ID
        ,MULTICAST_ID
        ,STATION_CODE
        ,REQUEST_TIME
        ,RESPONSE_TIME
        ,MESSAGE
        ,ATTACHMENT_TYPE
        ,ATTACHMENT
    ) VALUES (
         DESKTOPFX_MRESPONSE_SQ.NEXTVAL
        ,MULTICAST_ID$
        ,WSS_STATION_CODE$
        ,REQUEST_TIME$
        ,SYSTIMESTAMP
        ,MESSAGE$
        ,ATTACHMENT_TYPE$
        ,ATTACHMENT$
    ) RETURNING
        ID INTO TRESPONSE_ID$;
END DESKTOPFX$MRESPONSE_ADD;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
