CREATE OR REPLACE PROCEDURE SECURITYFX$WORD_GET
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
    PROFILE_CODE$   IN  INTEGER,
    STATION_CODE$   IN  NVARCHAR2,
    USER_WORD$      OUT NVARCHAR2
)
AS
    USU_CODIGO$     ECUACCUSU.USU_CODIGO%TYPE := USER_CODE$;
BEGIN
    SELECT PASSWORD 
    INTO   USER_WORD$
    FROM   ECUACCUSU
    WHERE  USU_CODIGO = USU_CODIGO$; 
EXCEPTION WHEN NO_DATA_FOUND THEN
    USER_WORD$ := NULL;
END SECURITYFX$WORD_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
