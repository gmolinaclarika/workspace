IF OBJECT_ID(N'dbo.DESKTOPFX$LOGIN', N'P') IS NOT NULL
    DROP PROCEDURE dbo.DESKTOPFX$LOGIN
GO

CREATE PROCEDURE dbo.DESKTOPFX$LOGIN
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
    DECLARE @IS_ANONYMOUS BIT;
    DECLARE @USER_ID      BIGINT;
    DECLARE @LOGIN_ID     BIGINT;
    DECLARE @LAST_POLL    DATETIME;
    DECLARE @USER_STATE   NVARCHAR(2);
    DECLARE @FEC_PRI_LOG  NVARCHAR(26);
    DECLARE @FEC_ULT_LOG  NVARCHAR(26);
    DECLARE @USU_CODIGO   NVARCHAR(40);
    DECLARE @REAL_WORD    NVARCHAR(200);
    DECLARE @SERVICE_NAME NVARCHAR(200);
    DECLARE @CURR_STATION NVARCHAR(200);

    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Init dummy outputs
    SET @OFFICE_TYPE = 0;

    -- Check for login of ANONYMOUS user
    IF (SUBSTRING(@WSS_USER_CODE, 1, 1) = '$') BEGIN
        SET @IS_ANONYMOUS = 1;
        SET @USU_CODIGO = '_ANONYMOUS';
    END
    ELSE BEGIN
        SET @IS_ANONYMOUS = 0;
        SET @USU_CODIGO = @WSS_USER_CODE;
    END;

    -- Obtain user word, state and first login date
    SELECT @REAL_WORD   = RTRIM(PASSWORD),
           @USER_STATE  = RTRIM(USU_ESTADO),
           @FEC_PRI_LOG = RTRIM(FEC_PRI_LOG)
    FROM   dbo.EcuACCUSU
    WHERE  USU_CODIGO = @USU_CODIGO;
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR('Usuario especificado no existe', 16, 1);
        RETURN;
    END;

    -- Check that real word matches supplied user word
    IF (@IS_ANONYMOUS = 0) AND (@USER_WORD != @REAL_WORD) BEGIN
        RAISERROR('El usuario y/o la contraseña son incorrectos', 16, 2);
        RETURN;
    END;

    -- Check that the user is currently enabled
    IF (@USER_STATE != 'HA') BEGIN
        RAISERROR('El usuario no está habilitado', 16, 3);
        RETURN;
    END;

    -- Obtain/create user properties and validate station
    SELECT @USER_ID      = ID,
           @SERVICE_NAME = SERVICE_NAME,
           @CURR_STATION = STATION_CODE,
           @LAST_POLL    = LAST_POLL
    FROM   dbo.DESKTOPFX_USER
    WHERE  USER_CODE = @WSS_USER_CODE;
    IF (@@ROWCOUNT = 0) BEGIN
        SET @SERVICE_NAME = 'SERVICE';
        INSERT dbo.DESKTOPFX_USER
            (USER_CODE, SERVICE_NAME, STATION_CODE, LAST_POLL)
        VALUES
            (@WSS_USER_CODE, @SERVICE_NAME, @WSS_STATION_CODE, GETDATE());
        SET @USER_ID = SCOPE_IDENTITY();
    END
    ELSE IF (DATEDIFF(minute, @LAST_POLL, GETDATE()) >= 5) BEGIN
        UPDATE dbo.DESKTOPFX_USER
        SET    STATION_CODE = @WSS_STATION_CODE,
               LAST_POLL = GETDATE()
        WHERE  ID = @USER_ID;
    END
    ELSE IF (@CURR_STATION = @WSS_STATION_CODE) BEGIN
        UPDATE dbo.DESKTOPFX_USER
        SET    LAST_POLL = GETDATE()
        WHERE  ID = @USER_ID;
    END
    ELSE BEGIN
        RAISERROR('El usuario ya está login en la estación %s', 16, 4, @CURR_STATION);
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
    WHERE USU_CODIGO = @USU_CODIGO;
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR('Usuario especificado no existe', 16, 5);
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
        RAISERROR('Perfil especificado no existe', 16, 6);
        RETURN;
    END;

    -- Make sure user+profile exist
    SELECT @LOGIN_ID     = ID,
           @LOGIN_STATE  = LOGIN_STATE
    FROM   dbo.DESKTOPFX_LOGIN
    WHERE  USER_ID = @USER_ID
    AND    PROFILE_CODE = @WSS_PROFILE_CODE;
    IF (@@ROWCOUNT = 0) BEGIN
        INSERT dbo.DESKTOPFX_LOGIN
            (USER_ID, PROFILE_CODE)
        VALUES
            (@USER_ID, @WSS_PROFILE_CODE);
        SET @LOGIN_ID = SCOPE_IDENTITY();
    END;

    -- Make sure user+profile=-1 exists
    IF NOT EXISTS
       (SELECT *
        FROM  dbo.DESKTOPFX_LOGIN
        WHERE USER_ID = @USER_ID
        AND   PROFILE_CODE = -1)
    BEGIN
        INSERT dbo.DESKTOPFX_LOGIN
            (USER_ID, PROFILE_CODE)
        VALUES
            (@USER_ID, -1);
    END;

    -- Return menu definition (DEFAULT if not defined)
    SELECT @MENU_XML = BYTES
    FROM   dbo.DESKTOPFX_OBJECT
    WHERE  LOGIN_ID = 0
    AND    TYPE = 4
    AND    NAME = @MENU_NAME;
    IF (@@ROWCOUNT = 0) BEGIN
        SET @MENU_NAME = 'DEFAULT';
        SELECT @MENU_XML = BYTES
        FROM   dbo.DESKTOPFX_OBJECT
        WHERE  LOGIN_ID = 0
        AND    TYPE = 4
        AND    NAME = @MENU_NAME;
    END;

    -- Return service definition (NULL if not defined)
    SELECT @LOGIN_SERVICE = BYTES
    FROM   dbo.DESKTOPFX_OBJECT
    WHERE  LOGIN_ID = 0
    AND    TYPE = 5
    AND    NAME = @SERVICE_NAME;

    -- Return login properties (NULL if not defined)
    SELECT @LOGIN_PROPS = BYTES
    FROM   dbo.DESKTOPFX_OBJECT
    WHERE  LOGIN_ID = @LOGIN_ID
    AND    TYPE = 1
    AND    NAME = 'LOGIN';

    -- Return global properties (NULL if not defined)
    SELECT @GLOBAL_PROPS = BYTES
    FROM   dbo.DESKTOPFX_OBJECT
    WHERE  LOGIN_ID = 0
    AND    TYPE = 1
    AND    NAME = 'LOGIN';

    -- #ResultSet @CAPACITY CAPACITIES
    --   #Column  CODE      NVARCHAR
    --   #Column  NAME      NVARCHAR
    --   #Column  TYPE      INTEGER
    --   #Column  VALUE     NVARCHAR
    -- #EndResultSet
    SELECT RTRIM(C.CAP_CODIGO)  AS CODE,
           RTRIM(C.CAP_NOMBRE)  AS NAME,
           C.CAP_TIPO           AS TYPE,
           RTRIM(U.CAP_VALOR)   AS VALUE
    FROM  dbo.EcuACCCAP C, dbo.EcuACCC2U U
    WHERE U.CODIGO_ADI = @USU_CODIGO
    AND   C.CAP_CODIGO = U.CAP_CODIGO
    UNION
    SELECT RTRIM(C.CAP_CODIGO)  AS CODE,
           RTRIM(C.CAP_NOMBRE)  AS NAME,
           C.CAP_TIPO           AS TYPE,
           RTRIM(P.CAP_VALOR)   AS VALUE
    FROM  dbo.EcuACCCAP C, dbo.EcuACCC2P P
    WHERE P.CODIGO_ECU = @WSS_PROFILE_CODE
    AND   C.CAP_CODIGO = P.CAP_CODIGO
    AND   C.CAP_CODIGO NOT IN (
            SELECT CAP_CODIGO FROM dbo.EcuACCC2U
            WHERE CODIGO_ADI = @USU_CODIGO)
    ORDER BY CODE;

    -- Update last-login-time and (maybe) first-login-time
    SET @FEC_ULT_LOG = REPLACE(CONVERT(VARCHAR,GETDATE(),25),' ',':')+'000';
    IF (LEN(@FEC_PRI_LOG) > 0) BEGIN
        UPDATE dbo.EcuACCUSU
        SET    FEC_ULT_LOG = @FEC_ULT_LOG
        WHERE  USU_CODIGO = @USU_CODIGO;
    END
    ELSE BEGIN
        UPDATE dbo.EcuACCUSU
        SET    FEC_ULT_LOG = @FEC_ULT_LOG,
               FEC_PRI_LOG = @FEC_ULT_LOG
        WHERE  USU_CODIGO = @USU_CODIGO;
    END;
END;
GO
