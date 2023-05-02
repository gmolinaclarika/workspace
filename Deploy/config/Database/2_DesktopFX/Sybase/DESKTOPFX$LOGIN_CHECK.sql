IF EXISTS(SELECT * FROM sysobjects WHERE name = 'desktopfx$login_check' AND type = 'P')
    DROP PROCEDURE desktopfx$login_check
GO

CREATE PROCEDURE desktopfx$login_check
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
    @MENU_XML           IMAGE           OUTPUT,
    @OFFICE_TYPE        INTEGER         OUTPUT,
    -- Login properties
    @LOGIN_STATE        IMAGE           OUTPUT,
    @LOGIN_SERVICE      IMAGE           OUTPUT,
    @LOGIN_PROPS        IMAGE           OUTPUT,
    @GLOBAL_PROPS       IMAGE           OUTPUT
AS
BEGIN
    DECLARE @REAL_WORD  NVARCHAR(200)
    DECLARE @USER_STATE NVARCHAR(2)

    -- Set No Count
    SET NOCOUNT ON

    -- Init outputs
    SELECT @OFFICE_TYPE = 0
    SELECT @MENU_XML := NULL;
    SELECT @LOGIN_PROPS := NULL;
    SELECT @GLOBAL_PROPS := NULL;
    SELECT @LOGIN_SERVICE := NULL;

    -- Obtain real user word
    SELECT @REAL_WORD  = RTRIM(PASSWORD),
           @USER_STATE = RTRIM(USU_ESTADO)
    FROM   dbo.EcuACCUSU
    WHERE  USU_CODIGO = @WSS_USER_CODE
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR 99999, 'Usuario especificado no existe'
        RETURN
    END

    -- Check that real word matches supplied user word
    IF (@USER_WORD != @REAL_WORD) BEGIN
        RAISERROR 99999, 'El usuario y/o la contraseña son incorrectos'
        RETURN
    END

    -- Check that the user is currently enabled
    IF (@USER_STATE != 'HA') BEGIN
        RAISERROR 99999, 'El usuario no está habilitado'
        RETURN
    END

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
    WHERE USU_CODIGO = @WSS_USER_CODE
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR 99999, 'Usuario especificado no existe'
        RETURN
    END

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
    WHERE V_ACC_CODE_NUM = @WSS_PROFILE_CODE
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR 99999, 'Perfil especificado no existe'
        RETURN
    END

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
    ORDER BY CODE
END
GO

sp_procxmode desktopfx$login_check, "anymode"
GO
