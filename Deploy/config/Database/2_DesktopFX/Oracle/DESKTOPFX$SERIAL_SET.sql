CREATE OR REPLACE PROCEDURE DESKTOPFX$SERIAL_SET
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
    STATION_CODE$   IN NVARCHAR2,
    SERIAL$         IN NVARCHAR2
)
AS
BEGIN
    -- Update station serial info
    UPDATE ECUACCNET 
    SET    V_NET_SERIETERM = SERIAL$
    WHERE  V_NET_NOMBRE = STATION_CODE$;
END DESKTOPFX$SERIAL_SET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
