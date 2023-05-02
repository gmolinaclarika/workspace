CREATE OR REPLACE PROCEDURE MCASTADMIN$MULTICAST_DEL
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
    MULTICAST_ID$           IN  DECIMAL
)
AS
BEGIN
    -- Delete the Multicast Responses
    DELETE FROM DESKTOPFX_MRESPONSE
    WHERE  MULTICAST_ID = MULTICAST_ID$;

    -- Delete the Multicast itself
    DELETE FROM DESKTOPFX_MULTICAST
    WHERE  ID = MULTICAST_ID$;
END MCASTADMIN$MULTICAST_DEL;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
