CREATE OR REPLACE PROCEDURE DESKTOPFX$WORD_STATE
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
    USER_CODE$      IN NVARCHAR2,
    PWD_STATE$      IN NVARCHAR2
)
AS
    USU_CODIGO$     ECUACCUSU.USU_CODIGO%TYPE;
BEGIN
    -- Normalize specified user name
    USU_CODIGO$ := UPPER(RTRIM(USER_CODE$));

    -- Update user expiration info
    UPDATE ECUACCUSU 
    SET    PSW_ESTADO = PWD_STATE$
    WHERE  USU_CODIGO = USU_CODIGO$;
END DESKTOPFX$WORD_STATE;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
