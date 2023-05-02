CREATE OR REPLACE PROCEDURE DESKTOPFX$ERROR_SET
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
    ERROR_COUNT$    IN INTEGER,
    ERROR_DATE$     IN NVARCHAR2
)
AS
    USU_CODIGO$     ECUACCUSU.USU_CODIGO%TYPE;
BEGIN
    -- Normalize specified user name
    USU_CODIGO$ := UPPER(RTRIM(USER_CODE$));

    -- Update user error info
    UPDATE ECUACCUSU 
    SET    ERROR_LOGIN = ERROR_COUNT$,
           FEC_ERR_LOG = ERROR_DATE$
    WHERE  USU_CODIGO = USU_CODIGO$;
END DESKTOPFX$ERROR_SET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
