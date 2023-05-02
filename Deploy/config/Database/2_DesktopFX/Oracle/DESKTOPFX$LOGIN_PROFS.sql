CREATE OR REPLACE PROCEDURE DESKTOPFX$LOGIN_PROFS
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
    USER_WORD$              IN  NVARCHAR2,
    PROFILES_MAX$           IN  INTEGER,
    PROFILES$               OUT SYS_REFCURSOR
)
AS
    REAL_WORD$              ECUACCUSU.PASSWORD%TYPE;
    USU_CODIGO$             ECUACCUSU.USU_CODIGO%TYPE;
BEGIN
    -- Normalize specified user name
    USU_CODIGO$ := UPPER(RTRIM(WSS_USER_CODE$));

    -- Obtain real user word
    BEGIN
        SELECT PASSWORD
        INTO   REAL_WORD$
        FROM   ECUACCUSU
        WHERE  USU_CODIGO = USU_CODIGO$;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Usuario especificado no existe');
    END;

    -- Check that real word matches supplied user word
    IF (USER_WORD$ != REAL_WORD$) THEN
        RAISE_APPLICATION_ERROR(-20001, 'El usuario y/o la contraseña son incorrectos');
    END IF; 

    -- #ResultSet PROFILE PROFILES
    --   #Column  PROFILE_CODE INTEGER
    --   #Column  PROFILE_NAME NVARCHAR
    -- #EndResultSet
    OPEN PROFILES$ FOR
        SELECT * FROM (
            SELECT P.V_ACC_CODE_NUM         AS PROFILE_CODE, 
                   RTRIM(P.V_ACC_NAME)      AS PROFILE_NAME
            FROM   ECUACCPER P, ECUACCU2P X
            WHERE  P.V_ACC_CODE_NUM = X.CODIGO_ECU
            AND    X.CODIGO_ADI = USU_CODIGO$
            ORDER  BY P.V_ACC_CODE_NUM ASC)
        WHERE ROWNUM <= PROFILES_MAX$;
END DESKTOPFX$LOGIN_PROFS;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
