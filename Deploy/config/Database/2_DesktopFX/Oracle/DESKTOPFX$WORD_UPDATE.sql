CREATE OR REPLACE PROCEDURE DESKTOPFX$WORD_UPDATE
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
    USER_WORD$      IN NVARCHAR2,
    USER_STATE$     IN NVARCHAR2,
    VALID_FROM$     IN NVARCHAR2
)
AS
    USU_CODIGO$     ECUACCUSU.USU_CODIGO%TYPE;
BEGIN
    -- Normalize specified user name
    USU_CODIGO$ := UPPER(RTRIM(USER_CODE$));

    -- Update user passwords info
    UPDATE ECUACCUSU 
    SET    PSW_ULTIMAS_006 = PSW_ULTIMAS_005,
           PSW_ULTIMAS_005 = PSW_ULTIMAS_004,
           PSW_ULTIMAS_004 = PSW_ULTIMAS_003,
           PSW_ULTIMAS_003 = PSW_ULTIMAS_002,
           PSW_ULTIMAS_002 = PSW_ULTIMAS_001,
           PSW_ULTIMAS_001 = PASSWORD,
           PASSWORD        = USER_WORD$,
           PSW_ESTADO      = USER_STATE$,
           PSW_VIG_DESD    = VALID_FROM$
    WHERE  USU_CODIGO = USU_CODIGO$;
END DESKTOPFX$WORD_UPDATE;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
