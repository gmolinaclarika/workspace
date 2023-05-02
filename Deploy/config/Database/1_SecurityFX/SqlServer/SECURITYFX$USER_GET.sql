IF OBJECT_ID(N'dbo.SECURITYFX$USER_GET', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.SECURITYFX$USER_GET
GO

CREATE PROCEDURE dbo.SECURITYFX$USER_GET
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @WSS_USER_CODE      NVARCHAR(100),
    @WSS_PROFILE_CODE   INTEGER,
    @WSS_STATION_CODE   NVARCHAR(100),
    ----------------------------------
    @USER_CODE          NVARCHAR(100),
    -- General Properties
    @CODE               NVARCHAR(100) OUT,
    @GIVEN_NAMES        NVARCHAR(100) OUT,
    @FATHER_NAME        NVARCHAR(100) OUT,
    @MOTHER_NAME        NVARCHAR(100) OUT,
    @POSITION           NVARCHAR(100) OUT,
    @USER_RUT           NVARCHAR(100) OUT,
    @DOMAIN             NVARCHAR(100) OUT,
    @USER_STATE         NVARCHAR(100) OUT,
    @VALID_FROM         INTEGER       OUT,
    @VALID_TO           INTEGER       OUT,
    -- Contact Properties
    @ADDRESS            NVARCHAR(100) OUT,
    @COUNTY             NVARCHAR(100) OUT,
    @CITY               NVARCHAR(100) OUT,
    @STATE              NVARCHAR(100) OUT,
    @COUNTRY            NVARCHAR(100) OUT,
    @PHONE1             NVARCHAR(100) OUT,
    @PHONE2             NVARCHAR(100) OUT,
    @FAX                NVARCHAR(100) OUT,
    @EMAIL              NVARCHAR(100) OUT,
    -- Authentication Properties
    @CERT_ID            NVARCHAR(100) OUT,
    @CERT_STATE         NVARCHAR(100) OUT,
    @CERT_REQST         NVARCHAR(100) OUT,
    @PWD_TYPE           NVARCHAR(100) OUT,
    @PWD_DAYS           INTEGER       OUT,
    @PWD_STATE          NVARCHAR(100) OUT,
    -- Billing Properties
    @BILLING_TYPE       NVARCHAR(100) OUT,
    @BILLING_CODE       NVARCHAR(100) OUT,
    @CONTRACT_CODE      NVARCHAR(100) OUT,
    @CONTRACT_ANNEX     NVARCHAR(100) OUT,
    @COMPANY_RUT        NVARCHAR(100) OUT
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Normalize specified user name
    SET @USER_CODE = UPPER(RTRIM(@USER_CODE));

    -- Return the properties of specified user
    SELECT 
        -- General Properties
        @CODE            = RTRIM(USU_CODIGO),
        @GIVEN_NAMES     = RTRIM(NOMBRES),
        @FATHER_NAME     = RTRIM(APELLIDO_PAT),
        @MOTHER_NAME     = RTRIM(APELLIDO_MAT),
        @POSITION        = RTRIM(CARGO),
        @USER_RUT        = RTRIM(RUT),
        @DOMAIN          = RTRIM(FAMILIA),
        @USER_STATE      = RTRIM(USU_ESTADO),
        @VALID_FROM      = FEC_VIG_DESD,
        @VALID_TO        = FEC_VIG_HAST,
        -- Contact Properties
        @ADDRESS         = RTRIM(DIRECCION),
        @COUNTY          = RTRIM(COMUNA),
        @CITY            = RTRIM(CIUDAD),
        @STATE           = RTRIM(ESTADO),
        @COUNTRY         = RTRIM(PAIS),
        @PHONE1          = RTRIM(FONO1),
        @PHONE2          = RTRIM(FONO2),
        @FAX             = RTRIM(FAX),
        @EMAIL           = RTRIM(EMAIL),
        -- Authentication Properties
        @CERT_ID         = RTRIM(CERTIF_ID),
        @CERT_STATE      = 'NT',
        @CERT_REQST      = '',
        @PWD_TYPE        = RTRIM(PSW_TIPO),
        @PWD_DAYS        = PSW_DIAS_CADUC,
        @PWD_STATE       = RTRIM(PSW_ESTADO),
        -- Billing Properties
        @BILLING_TYPE    = RTRIM(FACTURACION),
        @BILLING_CODE    = RTRIM(COD_FACTURACION),
        @CONTRACT_CODE   = RTRIM(COD_CONTRATO),
        @CONTRACT_ANNEX  = RTRIM(ANEXO_CONTRATO),
        @COMPANY_RUT     = RTRIM(RUT_INST)
    FROM   dbo.EcuACCUSU
    WHERE  USU_CODIGO = @USER_CODE;
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR('Usuario no está definido: %s', 16, 1, @USER_CODE);
        RETURN;
    END;

    -- #ResultSet PROFILE PROFILES
    --   #Column  CODE      INTEGER
    --   #Column  NAME      NVARCHAR
    -- #EndResultSet
    SELECT P.V_ACC_CODE_NUM     AS CODE, 
           RTRIM(P.V_ACC_NAME)  AS NAME
    FROM  dbo.EcuACCPER P, dbo.EcuACCU2P X
    WHERE P.V_ACC_CODE_NUM = X.CODIGO_ECU
    AND   X.CODIGO_ADI = @USER_CODE
    ORDER BY P.V_ACC_CODE_NUM;

    -- #ResultSet CAPACITY CAPACITIES
    --   #Column  CODE      NVARCHAR
    --   #Column  VALUE     NVARCHAR
    -- #EndResultSet
    SELECT RTRIM(CAP_CODIGO)    AS CODE, 
           RTRIM(CAP_VALOR)     AS VALUE
    FROM  dbo.EcuACCC2U
    WHERE CODIGO_ADI = @USER_CODE
    ORDER BY CAP_CODIGO;
END
GO
