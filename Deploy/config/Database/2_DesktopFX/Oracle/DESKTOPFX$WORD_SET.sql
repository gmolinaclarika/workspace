CREATE OR REPLACE PROCEDURE DESKTOPFX$WORD_SET
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
    USER_CODE$          IN  NVARCHAR2,
    USER_WORD$          IN  NVARCHAR2,
    UPDATED$            OUT INTEGER
)
AS
    PASSWORD$           ECUACCUSU.PASSWORD%TYPE;
    PSW_ULTIMAS_001$    ECUACCUSU.PSW_ULTIMAS_001%TYPE;
    PSW_ULTIMAS_002$    ECUACCUSU.PSW_ULTIMAS_002%TYPE;
    PSW_ULTIMAS_003$    ECUACCUSU.PSW_ULTIMAS_003%TYPE;
    PSW_ULTIMAS_004$    ECUACCUSU.PSW_ULTIMAS_004%TYPE;
    PSW_ULTIMAS_005$    ECUACCUSU.PSW_ULTIMAS_005%TYPE;
    PSW_ULTIMAS_006$    ECUACCUSU.PSW_ULTIMAS_006%TYPE;
    FEC_VIG_DESD$       ECUACCUSU.FEC_VIG_DESD%TYPE;
    FEC_VIG_HAST$       ECUACCUSU.FEC_VIG_HAST%TYPE;
    USU_ESTADO$         ECUACCUSU.USU_ESTADO%TYPE;
    PSW_TIPO$           ECUACCUSU.PSW_TIPO%TYPE;
    USU_CODIGO$         ECUACCUSU.USU_CODIGO%TYPE;
    YYYYMMDD$           ECUACCUSU.FEC_VIG_DESD%TYPE;
BEGIN
    -- Normalize specified user name
    USU_CODIGO$ := UPPER(RTRIM(USER_CODE$));

    -- Obtain properties of specified user
    BEGIN
        SELECT PASSWORD,
               PSW_ULTIMAS_001,
               PSW_ULTIMAS_002,
               PSW_ULTIMAS_003,
               PSW_ULTIMAS_004,
               PSW_ULTIMAS_005,
               PSW_ULTIMAS_006,
               FEC_VIG_DESD,
               FEC_VIG_HAST,
               USU_ESTADO,
               PSW_TIPO
        INTO   PASSWORD$,
               PSW_ULTIMAS_001$,
               PSW_ULTIMAS_002$,
               PSW_ULTIMAS_003$,
               PSW_ULTIMAS_004$,
               PSW_ULTIMAS_005$,
               PSW_ULTIMAS_006$,
               FEC_VIG_DESD$,
               FEC_VIG_HAST$,
               USU_ESTADO$,
               PSW_TIPO$
        FROM  ECUACCUSU
        WHERE USU_CODIGO = USU_CODIGO$;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Usuario no está definido: ' || USER_CODE$);
    END;

    -- Obtain current date in "YYYYMMDD" decimal format
    YYYYMMDD$ := TO_NUMBER(TO_CHAR(SYSDATE, 'YYYYMMDD'));

    -- Check the user is working in valid date range
    IF (YYYYMMDD$ < FEC_VIG_DESD$) OR (YYYYMMDD$ > FEC_VIG_HAST$) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Usuario no autorizado en esta fecha: ' || USER_CODE$);
    END IF;

    -- Check the password can be changed (is not 'FIJ')
    IF (PSW_TIPO$ != 'CAD') AND (PSW_TIPO$ != 'NCA') THEN
        RAISE_APPLICATION_ERROR(-20001, 'La contraseña no se puede cambiar porque está bloqueada');
    END IF;

    -- Check the user is not disabled ('HA' = habilitado)
    IF (USU_ESTADO$ != 'HA') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Usuario está deshabilitado: ' || USER_CODE$);
    END IF;

    -- Check new password has not been used before
    IF (PASSWORD$        = USER_WORD$)
    OR (PSW_ULTIMAS_001$ = USER_WORD$)
    OR (PSW_ULTIMAS_002$ = USER_WORD$)
    OR (PSW_ULTIMAS_003$ = USER_WORD$)
    OR (PSW_ULTIMAS_004$ = USER_WORD$)
    OR (PSW_ULTIMAS_005$ = USER_WORD$)
    OR (PSW_ULTIMAS_006$ = USER_WORD$) 
    THEN
        RAISE_APPLICATION_ERROR(-20001, 'Contraseña ya se utilizó anteriormente');
    END IF;

    -- Update user password info
    UPDATE ECUACCUSU 
    SET    PSW_ULTIMAS_006 = PSW_ULTIMAS_005,
           PSW_ULTIMAS_005 = PSW_ULTIMAS_004,
           PSW_ULTIMAS_004 = PSW_ULTIMAS_003,
           PSW_ULTIMAS_003 = PSW_ULTIMAS_002,
           PSW_ULTIMAS_002 = PSW_ULTIMAS_001,
           PSW_ULTIMAS_001 = PASSWORD,
           PASSWORD        = USER_WORD$,
           PSW_VIG_DESD    = YYYYMMDD$,
           PSW_ESTADO      = 'VIG'
    WHERE  USU_CODIGO = USU_CODIGO$
    AND    USU_ESTADO = 'HA'
    AND    PSW_TIPO  IN ('CAD', 'NCA')
    AND    YYYYMMDD$ BETWEEN FEC_VIG_DESD AND FEC_VIG_HAST;
    IF (SQL%ROWCOUNT != 1) THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo cambiar la contraseña de ' || USER_CODE$);
    END IF;

    -- User updated
    UPDATED$ := 1;
END DESKTOPFX$WORD_SET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
