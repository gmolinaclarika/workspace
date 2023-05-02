CREATE OR REPLACE PROCEDURE DESKTOPFX$PROFILES_GET
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
    USER_CODE$      IN  NVARCHAR2,
    PROFILES$       OUT SYS_REFCURSOR
)
AS
    CODIGO_ADI$     ECUACCU2P.CODIGO_ADI%TYPE;
BEGIN
    -- Normalize specified user name
    CODIGO_ADI$ := UPPER(RTRIM(USER_CODE$));

    -- #ResultSet PROFILE PROFILES
    --   #Column  PROFILE_CODE  INTEGER
    -- #EndResultSet
    OPEN PROFILES$ FOR
        SELECT CODIGO_ECU AS PROFILE_CODE
        FROM   ECUACCU2P
        WHERE  CODIGO_ADI = CODIGO_ADI$;
END DESKTOPFX$PROFILES_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
