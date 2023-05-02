CREATE OR REPLACE PROCEDURE DESKTOPFX$MULTICAST_GET
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
    VALID_FROM$             OUT TIMESTAMP,
    VALID_TO$               OUT TIMESTAMP,
    NAME$                   OUT NVARCHAR2,
    MESSAGE$                OUT NVARCHAR2,
    ATTACHMENT_TYPE$        OUT NVARCHAR2,
    ATTACHMENT$             OUT BLOB
)
AS
BEGIN
    -- Return Multicast properties
    SELECT VALID_FROM,  VALID_TO,  NAME,  MESSAGE,  ATTACHMENT_TYPE,  ATTACHMENT 
    INTO   VALID_FROM$, VALID_TO$, NAME$, MESSAGE$, ATTACHMENT_TYPE$, ATTACHMENT$
    FROM  DESKTOPFX_MULTICAST
    WHERE ID = MULTICAST_ID$;
END DESKTOPFX$MULTICAST_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
