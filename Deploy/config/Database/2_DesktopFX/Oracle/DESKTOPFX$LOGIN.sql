CREATE OR REPLACE PROCEDURE DESKTOPFX$LOGIN
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
    SERIAL_NUMBER$          IN  NVARCHAR2,
    -- User properties
    FIRST_NAME$             OUT NVARCHAR2,
    FATHER_NAME$            OUT NVARCHAR2,
    MOTHER_NAME$            OUT NVARCHAR2,
    USER_RUT$               OUT NVARCHAR2,
    JOB_TITLE$              OUT NVARCHAR2,
    VALID_FROM$             OUT INTEGER,
    VALID_TO$               OUT INTEGER,
    -- Contact properties
    STREET$                 OUT NVARCHAR2,
    COMMUNE$                OUT NVARCHAR2,
    CITY$                   OUT NVARCHAR2,
    REGION$                 OUT NVARCHAR2,
    COUNTRY$                OUT NVARCHAR2,
    EMAIL$                  OUT NVARCHAR2,
    PHONE1$                 OUT NVARCHAR2,
    PHONE2$                 OUT NVARCHAR2,
    FAX$                    OUT NVARCHAR2,
    -- Billing properties
    USER_REALM$             OUT NVARCHAR2,
    COMPANY_RUT$            OUT NVARCHAR2,
    BILLING_TYPE$           OUT NVARCHAR2,
    BILLING_CODE$           OUT NVARCHAR2,
    CONTRACT_CODE$          OUT NVARCHAR2,
    CONTRACT_ANNEX$         OUT NVARCHAR2,
    -- Profile properties
    PROFILE_NAME$           OUT NVARCHAR2,
    PROFILE_TYPE$           OUT INTEGER,
    PRIVILEGES$             OUT NVARCHAR2,
    PROFILE_REALM$          OUT NVARCHAR2,
    MENU_NAME$              OUT NVARCHAR2,
    MENU_XML$               OUT BLOB,
    OFFICE_TYPE$            OUT INTEGER,
    -- Login properties
    LOGIN_STATE$            OUT BLOB,
    LOGIN_SERVICE$          OUT BLOB,
    LOGIN_PROPS$            OUT BLOB,
    GLOBAL_PROPS$           OUT BLOB,
    -- Capacity properties
    CAPACITIES$             OUT SYS_REFCURSOR
)
AS
    USER_ID$                DESKTOPFX_USER.ID%TYPE;
    LOGIN_ID$               DESKTOPFX_LOGIN.ID%TYPE;
    TEMP_ID$                DESKTOPFX_LOGIN.ID%TYPE;
    REAL_WORD$              EcuACCUSU.PASSWORD%TYPE;
    USER_STATE$             EcuACCUSU.USU_ESTADO%TYPE;
    USU_CODIGO$             EcuACCUSU.USU_CODIGO%TYPE;
    FEC_PRI_LOG$            EcuACCUSU.FEC_PRI_LOG%TYPE;
    FEC_ULT_LOG$            EcuACCUSU.FEC_ULT_LOG%TYPE;
    LAST_POLL$              DESKTOPFX_USER.LAST_POLL%TYPE;
    SERVICE_NAME$           DESKTOPFX_USER.SERVICE_NAME%TYPE;
    CURR_STATION$           DESKTOPFX_USER.STATION_CODE%TYPE;
BEGIN
    -- Init dummy outputs
    OFFICE_TYPE$ := 0;

    -- Normalize specified user name
    USU_CODIGO$ := UPPER(RTRIM(WSS_USER_CODE$));

    -- Obtain user word, state and first login date
    BEGIN
        SELECT PASSWORD, RTRIM(USU_ESTADO), RTRIM(FEC_PRI_LOG)
        INTO   REAL_WORD$, USER_STATE$, FEC_PRI_LOG$
        FROM   EcuACCUSU
        WHERE  USU_CODIGO = USU_CODIGO$;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Usuario especificado no existe');
    END;

    -- Check that real word matches supplied user word
    IF (USER_WORD$ != REAL_WORD$) THEN
        RAISE_APPLICATION_ERROR(-20001, 'El usuario y/o la contraseña son incorrectos');
    END IF;

    -- Check that the user is currently enabled
    IF (USER_STATE$ != 'HA') THEN
        RAISE_APPLICATION_ERROR(-20001, 'El usuario no está habilitado');
    END IF;

    -- Obtain user properties (if any)
    BEGIN
        SELECT ID, SERVICE_NAME, STATION_CODE, LAST_POLL
        INTO   USER_ID$, SERVICE_NAME$, CURR_STATION$, LAST_POLL$
        FROM   DESKTOPFX_USER
        WHERE  USER_CODE = USU_CODIGO$;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        USER_ID$ := NULL;
    END;

    -- Update/create user properties and validate station
    IF (USER_ID$ IS NULL) THEN
        SERVICE_NAME$ := 'SERVICE';
        INSERT INTO DESKTOPFX_USER
            (ID, USER_CODE, SERVICE_NAME, STATION_CODE, LAST_POLL)
        VALUES
            (DESKTOPFX_USER_SQ.NEXTVAL, USU_CODIGO$, SERVICE_NAME$, WSS_STATION_CODE$, SYSTIMESTAMP)
        RETURNING
            ID INTO USER_ID$;
    ELSIF (SYSTIMESTAMP >= (LAST_POLL$ + INTERVAL '5' MINUTE)) THEN
        UPDATE DESKTOPFX_USER
        SET    STATION_CODE = WSS_STATION_CODE$,
               LAST_POLL = SYSTIMESTAMP
        WHERE  ID = USER_ID$;
    ELSIF (CURR_STATION$ = WSS_STATION_CODE$) THEN
        UPDATE DESKTOPFX_USER
        SET    LAST_POLL = SYSTIMESTAMP
        WHERE  ID = USER_ID$;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'El usuario ya está login en la estación ' || CURR_STATION$);
    END IF;

    -- Obtain user properties
    BEGIN
        SELECT
            -- User properties
            RTRIM(NOMBRES),
            RTRIM(APELLIDO_PAT),
            RTRIM(APELLIDO_MAT),
            RTRIM(RUT),
            RTRIM(CARGO),
            FEC_VIG_DESD,
            FEC_VIG_HAST,
            -- Contact properties
            RTRIM(DIRECCION),
            RTRIM(COMUNA),
            RTRIM(CIUDAD),
            RTRIM(ESTADO),
            RTRIM(PAIS),
            RTRIM(EMAIL),
            RTRIM(FONO1),
            RTRIM(FONO2),
            RTRIM(FAX),
            -- Billing properties
            RTRIM(FAMILIA),
            RTRIM(RUT_INST),
            RTRIM(FACTURACION),
            RTRIM(COD_FACTURACION),
            RTRIM(COD_CONTRATO),
            RTRIM(ANEXO_CONTRATO)
        INTO
            -- General properties
            FIRST_NAME$,
            FATHER_NAME$,
            MOTHER_NAME$,
            USER_RUT$,
            JOB_TITLE$,
            VALID_FROM$,
            VALID_TO$,
            -- Contact properties
            STREET$,
            COMMUNE$,
            CITY$,
            REGION$,
            COUNTRY$,
            EMAIL$,
            PHONE1$,
            PHONE2$,
            FAX$,
            -- Billing properties
            USER_REALM$,
            COMPANY_RUT$,
            BILLING_TYPE$,
            BILLING_CODE$,
            CONTRACT_CODE$,
            CONTRACT_ANNEX$
        FROM  EcuACCUSU
        WHERE USU_CODIGO = USU_CODIGO$;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Usuario especificado no existe');
    END;

    -- Obtain profile properties
    BEGIN
        SELECT RTRIM(V_ACC_NAME),
               ASCII(SUBSTR(V_ACC_INDICADORES,2,1)),
               V_ACC_PRIV_MEN  ||
               V_ACC_PRIV_VARL ||
               V_ACC_PRIV_VARM ||
               V_ACC_PRIV_REGL ||
               V_ACC_PRIV_REGM,
               RTRIM(V_ACC_FAMILIA),
               RTRIM(V_ACC_PROG_INI)
        INTO
               PROFILE_NAME$,
               PROFILE_TYPE$,
               PRIVILEGES$,
               PROFILE_REALM$,
               MENU_NAME$
        FROM  ECUACCPER
        WHERE V_ACC_CODE_NUM = WSS_PROFILE_CODE$;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Perfil especificado no existe');
    END;

    -- Make sure user+proifle exist
    BEGIN
        SELECT ID, LOGIN_STATE
        INTO   LOGIN_ID$, LOGIN_STATE$
        FROM   DESKTOPFX_LOGIN
        WHERE  USER_ID = USER_ID$
        AND    PROFILE_CODE = WSS_PROFILE_CODE$;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        INSERT INTO DESKTOPFX_LOGIN
            (ID, USER_ID, PROFILE_CODE)
        VALUES
            (DESKTOPFX_LOGIN_SQ.NEXTVAL, USER_ID$, WSS_PROFILE_CODE$)
        RETURNING
            ID INTO LOGIN_ID$;
    END;

    -- Make sure user+profile=-1 exists
    BEGIN
        SELECT ID INTO TEMP_ID$
        FROM   DESKTOPFX_LOGIN
        WHERE  USER_ID = USER_ID$
        AND    PROFILE_CODE = -1;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        INSERT INTO DESKTOPFX_LOGIN
            (ID, USER_ID, PROFILE_CODE)
        VALUES
            (DESKTOPFX_LOGIN_SQ.NEXTVAL, USER_ID$, -1);
    END;

    -- Return menu definition (DEFAULT if not defined)
    BEGIN
        SELECT BYTES INTO MENU_XML$
        FROM   DESKTOPFX_OBJECT
        WHERE  LOGIN_ID = 0
        AND    TYPE = 4
        AND    NAME = MENU_NAME$;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        MENU_NAME$ := 'DEFAULT';
        BEGIN
            SELECT BYTES INTO MENU_XML$
            FROM   DESKTOPFX_OBJECT
            WHERE  LOGIN_ID = 0
            AND    TYPE = 4
            AND    NAME = MENU_NAME$;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            MENU_XML$ := NULL;
        END;
    END;

    -- Return service definition (NULL if not defined)
    BEGIN
        SELECT BYTES INTO LOGIN_SERVICE$
        FROM   DESKTOPFX_OBJECT
        WHERE  LOGIN_ID = 0
        AND    TYPE = 5
        AND    NAME = SERVICE_NAME$;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        LOGIN_SERVICE$ := NULL;
    END;

    -- Return login properties (NULL if not defined)
    BEGIN
        SELECT BYTES INTO LOGIN_PROPS$
        FROM   DESKTOPFX_OBJECT
        WHERE  LOGIN_ID = LOGIN_ID$
        AND    TYPE = 1
        AND    NAME = 'LOGIN';
    EXCEPTION WHEN NO_DATA_FOUND THEN
        LOGIN_PROPS$ := NULL;
    END;

    -- Return global properties (NULL if not defined)
    BEGIN
        SELECT BYTES INTO GLOBAL_PROPS$
        FROM   DESKTOPFX_OBJECT
        WHERE  LOGIN_ID = 0
        AND    TYPE = 1
        AND    NAME = 'LOGIN';
    EXCEPTION WHEN NO_DATA_FOUND THEN
        GLOBAL_PROPS$ := NULL;
    END;

    -- #ResultSet @CAPACITY CAPACITIES
    --   #Column  CODE      NVARCHAR
    --   #Column  NAME      NVARCHAR
    --   #Column  TYPE      INTEGER
    --   #Column  VALUE     NVARCHAR
    -- #EndResultSet
    OPEN CAPACITIES$ FOR
        SELECT RTRIM(C.CAP_CODIGO)  AS CODE,
               RTRIM(C.CAP_NOMBRE)  AS NAME,
               C.CAP_TIPO           AS TYPE,
               RTRIM(U.CAP_VALOR)   AS VALUE
        FROM  EcuACCCAP C, EcuACCC2U U
        WHERE U.CODIGO_ADI = USU_CODIGO$
        AND   C.CAP_CODIGO = U.CAP_CODIGO
        UNION
        SELECT RTRIM(C.CAP_CODIGO)  AS CODE,
               RTRIM(C.CAP_NOMBRE)  AS NAME,
               C.CAP_TIPO           AS TYPE,
               RTRIM(P.CAP_VALOR)   AS VALUE
        FROM  EcuACCCAP C, EcuACCC2P P
        WHERE P.CODIGO_ECU = WSS_PROFILE_CODE$
        AND   C.CAP_CODIGO = P.CAP_CODIGO
        AND   C.CAP_CODIGO NOT IN (
                SELECT CAP_CODIGO FROM EcuACCC2U
                WHERE CODIGO_ADI = USU_CODIGO$)
        ORDER BY CODE;

    -- Update last-login-time and (maybe) first-login-time
    FEC_ULT_LOG$ := TO_CHAR(SYSTIMESTAMP,'YYYY-MM-DD:HH24:MI:SS.FF6');
    IF (FEC_PRI_LOG$ IS NOT NULL) THEN
        UPDATE EcuACCUSU
        SET    FEC_ULT_LOG = FEC_ULT_LOG$
        WHERE  USU_CODIGO = USU_CODIGO$;
    ELSE
        UPDATE EcuACCUSU
        SET    FEC_ULT_LOG = FEC_ULT_LOG$,
               FEC_PRI_LOG = FEC_ULT_LOG$
        WHERE  USU_CODIGO = USU_CODIGO$;
    END IF;
END DESKTOPFX$LOGIN;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
