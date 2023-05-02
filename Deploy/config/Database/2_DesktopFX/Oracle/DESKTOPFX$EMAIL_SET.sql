CREATE OR REPLACE PROCEDURE DESKTOPFX$EMAIL_SET
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
    EMAIL_ADDR$     IN  NVARCHAR2,
    UPDATED$        OUT INTEGER
)
AS
    USU_CODIGO$     ECUACCUSU.USU_CODIGO%TYPE;
BEGIN
    -- Normalize specified user name
    USU_CODIGO$ := UPPER(RTRIM(USER_CODE$));

    -- Update user email info
    UPDATE ECUACCUSU 
    SET    EMAIL = EMAIL_ADDR$
    WHERE  USU_CODIGO = USU_CODIGO$
    AND    USU_ESTADO = 'HA'
    AND    PSW_TIPO IN ('CAD', 'NCA');

    -- Return TRUE if update successful
    IF (SQL%ROWCOUNT = 1) THEN
        UPDATED$ := 1;
    ELSE
        UPDATED$ := 0;
    END IF;
END DESKTOPFX$EMAIL_SET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
