CREATE OR REPLACE PROCEDURE DESKTOPFX$LOGIN_CHECK
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
    REAL_WORD$              ECUACCUSU.PASSWORD%TYPE;
    USER_STATE$             ECUACCUSU.USU_ESTADO%TYPE;
    USU_CODIGO$             ECUACCUSU.USU_CODIGO%TYPE;
BEGIN
    -- Init outputs
    OFFICE_TYPE$ := 0;
    MENU_XML$ := NULL;
    LOGIN_PROPS$ := NULL;
    GLOBAL_PROPS$ := NULL;
    LOGIN_SERVICE$ := NULL;

    -- Normalize specified user name
    USU_CODIGO$ := UPPER(RTRIM(WSS_USER_CODE$));

    -- Obtain real user word
    BEGIN
        SELECT PASSWORD, RTRIM(USU_ESTADO)
        INTO   REAL_WORD$, USER_STATE$
        FROM   ECUACCUSU
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
        FROM  ECUACCUSU
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

    -- #ResultSet @CAPACITY CAPACITIES
    --   #Column  CODE      NVARCHAR
    --   #Column  NAME      NVARCHAR
    --   #Column  TYPE      INTEGER
    --   #Column  VALUE     NVARCHAR
    -- #EndResultSet
    OPEN CAPACITIES$ FOR
        SELECT C.CAP_CODIGO AS CODE, 
               C.CAP_NOMBRE AS NAME,
               C.CAP_TIPO   AS TYPE,
               U.CAP_VALOR  AS VALUE
        FROM  EcuACCCAP C, EcuACCC2U U
        WHERE U.CODIGO_ADI = USU_CODIGO$
        AND   C.CAP_CODIGO = U.CAP_CODIGO
        UNION
        SELECT C.CAP_CODIGO AS CODE, 
               C.CAP_NOMBRE AS NAME,
               C.CAP_TIPO   AS TYPE,
               P.CAP_VALOR  AS VALUE
        FROM  EcuACCCAP C, EcuACCC2P P
        WHERE P.CODIGO_ECU = WSS_PROFILE_CODE$
        AND   C.CAP_CODIGO = P.CAP_CODIGO
        AND   C.CAP_CODIGO NOT IN (
                SELECT CAP_CODIGO FROM EcuACCC2U 
                WHERE CODIGO_ADI = WSS_USER_CODE$)
        ORDER BY CODE;
END DESKTOPFX$LOGIN_CHECK;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
