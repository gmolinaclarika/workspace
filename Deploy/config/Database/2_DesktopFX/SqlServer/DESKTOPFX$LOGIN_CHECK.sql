IF OBJECT_ID(N'dbo.DESKTOPFX$LOGIN_CHECK', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.DESKTOPFX$LOGIN_CHECK
GO

CREATE PROCEDURE dbo.DESKTOPFX$LOGIN_CHECK
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
    @USER_WORD          NVARCHAR(200),
    @SERIAL_NUMBER      NVARCHAR(200),
    -- User properties
    @FIRST_NAME         NVARCHAR(200)   OUTPUT,
    @FATHER_NAME        NVARCHAR(200)   OUTPUT,
    @MOTHER_NAME        NVARCHAR(200)   OUTPUT,
    @USER_RUT           NVARCHAR(200)   OUTPUT,
    @JOB_TITLE          NVARCHAR(200)   OUTPUT,
    @VALID_FROM         INTEGER         OUTPUT,
    @VALID_TO           INTEGER         OUTPUT,
    -- Contact properties
    @STREET             NVARCHAR(200)   OUTPUT,
    @COMMUNE            NVARCHAR(200)   OUTPUT,
    @CITY               NVARCHAR(200)   OUTPUT,
    @REGION             NVARCHAR(200)   OUTPUT,
    @COUNTRY            NVARCHAR(200)   OUTPUT,
    @EMAIL              NVARCHAR(200)   OUTPUT,
    @PHONE1             NVARCHAR(200)   OUTPUT,
    @PHONE2             NVARCHAR(200)   OUTPUT,
    @FAX                NVARCHAR(200)   OUTPUT,
    -- Billing properties
    @USER_REALM         NVARCHAR(200)   OUTPUT,
    @COMPANY_RUT        NVARCHAR(200)   OUTPUT,
    @BILLING_TYPE       NVARCHAR(200)   OUTPUT,
    @BILLING_CODE       NVARCHAR(200)   OUTPUT,
    @CONTRACT_CODE      NVARCHAR(200)   OUTPUT,
    @CONTRACT_ANNEX     NVARCHAR(200)   OUTPUT,
    -- Profile properties
    @PROFILE_NAME       NVARCHAR(200)   OUTPUT,
    @PROFILE_TYPE       INTEGER         OUTPUT,
    @PRIVILEGES         NVARCHAR(200)   OUTPUT,
    @PROFILE_REALM      NVARCHAR(200)   OUTPUT,
    @MENU_NAME          NVARCHAR(200)   OUTPUT,
    @MENU_XML           VARBINARY(MAX)  OUTPUT,
    @OFFICE_TYPE        INTEGER         OUTPUT,
    -- Login properties
    @LOGIN_STATE        VARBINARY(MAX)  OUTPUT,
    @LOGIN_SERVICE      VARBINARY(MAX)  OUTPUT,
    @LOGIN_PROPS        VARBINARY(MAX)  OUTPUT,
    @GLOBAL_PROPS       VARBINARY(MAX)  OUTPUT
AS
BEGIN
    DECLARE @REAL_WORD    NVARCHAR(200);
    DECLARE @USER_STATE   NVARCHAR(2);

    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Init outputs
    SET @OFFICE_TYPE = 0;
    SET @MENU_XML = NULL;
    SET @LOGIN_PROPS = NULL;
    SET @GLOBAL_PROPS = NULL;
    SET @LOGIN_SERVICE = NULL;

    -- Obtain real user word
    SELECT @REAL_WORD  = RTRIM(PASSWORD),
           @USER_STATE = RTRIM(USU_ESTADO)
    FROM   dbo.EcuACCUSU
    WHERE  USU_CODIGO = @WSS_USER_CODE;
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR('Usuario especificado no existe', 16, 1);
        RETURN;
    END;

    -- Check that real word matches supplied user word
    IF (@USER_WORD != @REAL_WORD) BEGIN
        RAISERROR('El usuario y/o la contraseña son incorrectos', 16, 1);
        RETURN;
    END;

    -- Check that the user is currently enabled
    IF (@USER_STATE != 'HA') BEGIN
        RAISERROR('El usuario no está habilitado', 16, 1);
        RETURN;
    END;

    -- Obtain user properties
    SELECT 
        -- User properties
        @FIRST_NAME     = RTRIM(NOMBRES),
        @FATHER_NAME    = RTRIM(APELLIDO_PAT),
        @MOTHER_NAME    = RTRIM(APELLIDO_MAT),
        @USER_RUT       = RTRIM(RUT),
        @JOB_TITLE      = RTRIM(CARGO),
        @VALID_FROM     = FEC_VIG_DESD,
        @VALID_TO       = FEC_VIG_HAST,
        -- Contact properties
        @STREET         = RTRIM(DIRECCION),
        @COMMUNE        = RTRIM(COMUNA),
        @CITY           = RTRIM(CIUDAD),
        @REGION         = RTRIM(ESTADO),
        @COUNTRY        = RTRIM(PAIS),
        @EMAIL          = RTRIM(EMAIL),
        @PHONE1         = RTRIM(FONO1),
        @PHONE2         = RTRIM(FONO2),
        @FAX            = RTRIM(FAX),
        -- Billing properties
        @USER_REALM     = RTRIM(FAMILIA),
        @COMPANY_RUT    = RTRIM(RUT_INST),
        @BILLING_TYPE   = RTRIM(FACTURACION),
        @BILLING_CODE   = RTRIM(COD_FACTURACION),
        @CONTRACT_CODE  = RTRIM(COD_CONTRATO),
        @CONTRACT_ANNEX = RTRIM(ANEXO_CONTRATO)
    FROM  dbo.EcuACCUSU
    WHERE USU_CODIGO = @WSS_USER_CODE;
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR('Usuario especificado no existe', 16, 1);
        RETURN;
    END;

    -- Obtain profile properties
    SELECT 
        @PROFILE_NAME   = RTRIM(V_ACC_NAME),
        @PROFILE_TYPE   = ASCII(SUBSTRING(V_ACC_INDICADORES,2,1)),
        @PRIVILEGES     = V_ACC_PRIV_MEN
                        + V_ACC_PRIV_VARL
                        + V_ACC_PRIV_VARM
                        + V_ACC_PRIV_REGL
                        + V_ACC_PRIV_REGM,
        @PROFILE_REALM  = RTRIM(V_ACC_FAMILIA),
        @MENU_NAME      = RTRIM(V_ACC_PROG_INI)
    FROM  dbo.EcuACCPER
    WHERE V_ACC_CODE_NUM = @WSS_PROFILE_CODE;
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR('Perfil especificado no existe', 16, 1);
        RETURN;
    END;

    -- #ResultSet @CAPACITY CAPACITIES
    --   #Column  CODE      NVARCHAR
    --   #Column  NAME      NVARCHAR
    --   #Column  TYPE      INTEGER
    --   #Column  VALUE     NVARCHAR
    -- #EndResultSet
    SELECT C.CAP_CODIGO     AS CODE, 
           C.CAP_NOMBRE     AS NAME,
           C.CAP_TIPO       AS TYPE,
           U.CAP_VALOR      AS VALUE
    FROM  dbo.EcuACCCAP C, dbo.EcuACCC2U U
    WHERE U.CODIGO_ADI = @WSS_USER_CODE
    AND   C.CAP_CODIGO = U.CAP_CODIGO
    UNION
    SELECT C.CAP_CODIGO     AS CODE, 
           C.CAP_NOMBRE     AS NAME,
           C.CAP_TIPO       AS TYPE,
           P.CAP_VALOR      AS VALUE
    FROM  dbo.EcuACCCAP C, dbo.EcuACCC2P P
    WHERE P.CODIGO_ECU = @WSS_PROFILE_CODE
    AND   C.CAP_CODIGO = P.CAP_CODIGO
    AND   C.CAP_CODIGO NOT IN (
            SELECT CAP_CODIGO FROM dbo.EcuACCC2U 
            WHERE CODIGO_ADI = @WSS_USER_CODE)
    ORDER BY CODE;
END;
GO
