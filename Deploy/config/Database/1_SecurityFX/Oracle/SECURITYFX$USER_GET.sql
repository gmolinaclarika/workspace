CREATE OR REPLACE PROCEDURE SECURITYFX$USER_GET
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
    USER_CODE$              IN  NVARCHAR2,
    -- General Properties
    CODE$                   OUT NVARCHAR2,
    GIVEN_NAMES$            OUT NVARCHAR2,
    FATHER_NAME$            OUT NVARCHAR2,
    MOTHER_NAME$            OUT NVARCHAR2,
    POSITION$               OUT NVARCHAR2,
    USER_RUT$               OUT NVARCHAR2,
    DOMAIN$                 OUT NVARCHAR2,
    USER_STATE$             OUT NVARCHAR2,
    VALID_FROM$             OUT INTEGER,
    VALID_TO$               OUT INTEGER,
    -- Contact Properties
    ADDRESS$                OUT NVARCHAR2,
    COUNTY$                 OUT NVARCHAR2,
    CITY$                   OUT NVARCHAR2,
    STATE$                  OUT NVARCHAR2,
    COUNTRY$                OUT NVARCHAR2,
    PHONE1$                 OUT NVARCHAR2,
    PHONE2$                 OUT NVARCHAR2,
    FAX$                    OUT NVARCHAR2,
    EMAIL$                  OUT NVARCHAR2,
    -- Authentication Properties
    CERT_ID$                OUT NVARCHAR2,
    CERT_STATE$             OUT NVARCHAR2,
    CERT_REQST$             OUT NVARCHAR2,
    PWD_TYPE$               OUT NVARCHAR2,
    PWD_DAYS$               OUT INTEGER,
    PWD_STATE$              OUT NVARCHAR2,
    -- Billing Properties
    BILLING_TYPE$           OUT NVARCHAR2,
    BILLING_CODE$           OUT NVARCHAR2,
    CONTRACT_CODE$          OUT NVARCHAR2,
    CONTRACT_ANNEX$         OUT NVARCHAR2,
    COMPANY_RUT$            OUT NVARCHAR2,
    -- User Profiles And Capacities
    PROFILES$               OUT SYS_REFCURSOR,
    CAPACITIES$             OUT SYS_REFCURSOR
)
AS
    USU_CODIGO$             EcuACCUSU.USU_CODIGO%TYPE;
BEGIN
    -- Normalize specified user name
    USU_CODIGO$ := UPPER(RTRIM(USER_CODE$));

    -- Return the properties of user
    BEGIN
        SELECT
            -- General Properties
            RTRIM(USU_CODIGO),
            RTRIM(NOMBRES),
            RTRIM(APELLIDO_PAT),
            RTRIM(APELLIDO_MAT),
            RTRIM(CARGO),
            RTRIM(RUT),
            RTRIM(FAMILIA),
            RTRIM(USU_ESTADO),
            FEC_VIG_DESD,
            FEC_VIG_HAST,
            -- Contact Properties
            RTRIM(DIRECCION),
            RTRIM(COMUNA),
            RTRIM(CIUDAD),
            RTRIM(ESTADO),
            RTRIM(PAIS),
            RTRIM(FONO1),
            RTRIM(FONO2),
            RTRIM(FAX),
            RTRIM(EMAIL),
            -- Authentication Properties
            RTRIM(CERTIF_ID),
            'NT',
            ' ',
            RTRIM(PSW_TIPO),
            PSW_DIAS_CADUC,
            RTRIM(PSW_ESTADO),
            -- Billing Properties
            RTRIM(FACTURACION),
            RTRIM(COD_FACTURACION),
            RTRIM(COD_CONTRATO),
            RTRIM(ANEXO_CONTRATO),
            RTRIM(RUT_INST)
        INTO
            -- General Properties
            CODE$,
            GIVEN_NAMES$,
            FATHER_NAME$,
            MOTHER_NAME$,
            POSITION$,
            USER_RUT$,
            DOMAIN$,
            USER_STATE$,
            VALID_FROM$,
            VALID_TO$,
            -- Contact Properties
            ADDRESS$,
            COUNTY$,
            CITY$,
            STATE$,
            COUNTRY$,
            PHONE1$,
            PHONE2$,
            FAX$,
            EMAIL$,
            -- Authentication Properties
            CERT_ID$,
            CERT_STATE$,
            CERT_REQST$,
            PWD_TYPE$,
            PWD_DAYS$,
            PWD_STATE$,
            -- Billing Properties
            BILLING_TYPE$,
            BILLING_CODE$,
            CONTRACT_CODE$,
            CONTRACT_ANNEX$,
            COMPANY_RUT$
        FROM   EcuACCUSU
        WHERE  USU_CODIGO = USU_CODIGO$;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Usuario no está definido: ' || USER_CODE$);
    END;

    -- #ResultSet PROFILE PROFILES
    --   #Column  CODE      INTEGER
    --   #Column  NAME      NVARCHAR
    -- #EndResultSet
    OPEN PROFILES$ FOR
        SELECT P.V_ACC_CODE_NUM     AS CODE,
               RTRIM(P.V_ACC_NAME)  AS NAME
        FROM   EcuACCPER P, EcuACCU2P X
        WHERE  P.V_ACC_CODE_NUM = X.CODIGO_ECU
        AND    X.CODIGO_ADI = USU_CODIGO$
        ORDER  BY P.V_ACC_CODE_NUM;

    -- #ResultSet CAPACITY CAPACITIES
    --   #Column  CODE      NVARCHAR
    --   #Column  VALUE     NVARCHAR
    -- #EndResultSet
    OPEN CAPACITIES$ FOR
        SELECT RTRIM(CAP_CODIGO)    AS CODE,
               RTRIM(CAP_VALOR)     AS VALUE
        FROM  EcuACCC2U
        WHERE CODIGO_ADI = USU_CODIGO$
        ORDER BY CAP_CODIGO;
END SECURITYFX$USER_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
