IF OBJECT_ID(N'dbo.SECURITYFX$USER_PUT', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.SECURITYFX$USER_PUT
GO

CREATE PROCEDURE dbo.SECURITYFX$USER_PUT
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
    @GIVEN_NAMES        NVARCHAR(100),
    @FATHER_NAME        NVARCHAR(100),
    @MOTHER_NAME        NVARCHAR(100),
    @POSITION           NVARCHAR(100),
    @USER_RUT           NVARCHAR(100),
    @DOMAIN             NVARCHAR(100),
    @USER_STATE         NVARCHAR(100),
    @VALID_FROM         INTEGER,
    @VALID_TO           INTEGER,
    -- Contact Properties
    @ADDRESS            NVARCHAR(100),
    @COUNTY             NVARCHAR(100),
    @CITY               NVARCHAR(100),
    @STATE              NVARCHAR(100),
    @COUNTRY            NVARCHAR(100),
    @PHONE1             NVARCHAR(100),
    @PHONE2             NVARCHAR(100),
    @FAX                NVARCHAR(100),
    @EMAIL              NVARCHAR(100),
    -- Authentication Properties
    @CERT_ID            NVARCHAR(100),
    @CERT_STATE         NVARCHAR(100),
    @CERT_REQST         NVARCHAR(100),
    @PWD_TYPE           NVARCHAR(100),
    @PWD_DAYS           INTEGER,
    @PWD_STATE          NVARCHAR(100),
    @PWD_TEXT           NVARCHAR(100),
    -- Billing Properties
    @BILLING_TYPE       NVARCHAR(100),
    @BILLING_CODE       NVARCHAR(100),
    @CONTRACT_CODE      NVARCHAR(100),
    @CONTRACT_ANNEX     NVARCHAR(100),
    @COMPANY_RUT        NVARCHAR(100),
    -- User Profiles
    @PROFILES           NVARCHAR(4000),
    -- Output Parameters
    @CREATED            INTEGER OUT
AS
BEGIN
    DECLARE @INDEX          INTEGER;
    DECLARE @PROFILE_CODE   INTEGER;
    DECLARE @AUDIT_EVENT    INTEGER;
    DECLARE @AUDIT_MESSAGE  NVARCHAR(100);

    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Asume the user exists
    SET @CREATED = 0;

    -- Normalize specified user name
    SET @USER_CODE = UPPER(RTRIM(@USER_CODE));

    -- Update the properties of specified user
    UPDATE dbo.EcuACCUSU
    SET    NOMBRES          = ISNULL(@GIVEN_NAMES,''),
           APELLIDO_PAT     = ISNULL(@FATHER_NAME,''),
           APELLIDO_MAT     = ISNULL(@MOTHER_NAME,''),
           CARGO            = ISNULL(@POSITION,''),
           RUT              = ISNULL(@USER_RUT,''),
           FAMILIA          = ISNULL(@DOMAIN,''),
           USU_ESTADO       = ISNULL(@USER_STATE,''),
           FEC_VIG_DESD     = @VALID_FROM,
           FEC_VIG_HAST     = @VALID_TO,
           -- Contact Properties
           DIRECCION        = ISNULL(@ADDRESS,''),
           COMUNA           = ISNULL(@COUNTY,''),
           CIUDAD           = ISNULL(@CITY,''),
           ESTADO           = ISNULL(@STATE,''),
           PAIS             = ISNULL(@COUNTRY,''),
           FONO1            = ISNULL(@PHONE1,''),
           FONO2            = ISNULL(@PHONE2,''),
           FAX              = ISNULL(@FAX,''),
           EMAIL            = ISNULL(@EMAIL,''),
           -- Authentication Properties
           CERTIF_ID        = ISNULL(@CERT_ID,''),
           PSW_TIPO         = ISNULL(@PWD_TYPE,''),
           PSW_DIAS_CADUC   = @PWD_DAYS,
           PSW_ESTADO       = ISNULL(@PWD_STATE,''),
           -- Billing Properties
           FACTURACION      = ISNULL(@BILLING_TYPE,''),
           COD_FACTURACION  = ISNULL(@BILLING_CODE,''),
           COD_CONTRATO     = ISNULL(@CONTRACT_CODE,''),
           ANEXO_CONTRATO   = ISNULL(@CONTRACT_ANNEX,''),
           RUT_INST         = ISNULL(@COMPANY_RUT,'')
    WHERE  USU_CODIGO = @USER_CODE;

    -- Create user if it didn't exist
    IF (@@ROWCOUNT = 0) BEGIN
        INSERT INTO dbo.EcuACCUSU (
             USU_CODIGO
            -- General Properties
            ,NOMBRES
            ,APELLIDO_PAT
            ,APELLIDO_MAT
            ,CARGO
            ,RUT
            ,FAMILIA
            ,USU_ESTADO
            ,FEC_VIG_DESD
            ,FEC_VIG_HAST
            ,FEC_CRE_USU
            -- Contact Properties
            ,DIRECCION
            ,COMUNA
            ,CIUDAD
            ,ESTADO
            ,PAIS
            ,FONO1
            ,FONO2
            ,FAX
            ,EMAIL
            -- Authentication Properties
            ,CERTIF_ID
            ,PSW_TIPO
            ,PSW_DIAS_CADUC
            ,PSW_ESTADO
            -- Billing Properties
            ,FACTURACION
            ,COD_FACTURACION
            ,COD_CONTRATO
            ,ANEXO_CONTRATO
            ,RUT_INST
        ) VALUES (
             @USER_CODE
            -- General Properties
            ,ISNULL(@GIVEN_NAMES,'')
            ,ISNULL(@FATHER_NAME,'')
            ,ISNULL(@MOTHER_NAME,'')
            ,ISNULL(@POSITION,'')
            ,ISNULL(@USER_RUT,'')
            ,ISNULL(@DOMAIN,'')
            ,ISNULL(@USER_STATE,'')
            ,@VALID_FROM
            ,@VALID_TO
            ,REPLACE(CONVERT(VARCHAR,GETDATE(),25),' ',':')+'000'
            -- Contact Properties
            ,ISNULL(@ADDRESS,'')
            ,ISNULL(@COUNTY,'')
            ,ISNULL(@CITY,'')
            ,ISNULL(@STATE,'')
            ,ISNULL(@COUNTRY,'')
            ,ISNULL(@PHONE1,'')
            ,ISNULL(@PHONE2,'')
            ,ISNULL(@FAX,'')
            ,ISNULL(@EMAIL,'')
            -- Authentication Properties
            ,ISNULL(@CERT_ID,'')
            ,ISNULL(@PWD_TYPE,'')
            ,@PWD_DAYS
            ,ISNULL(@PWD_STATE,'')
            -- Billing Properties
            ,ISNULL(@BILLING_TYPE,'')
            ,ISNULL(@BILLING_CODE,'')
            ,ISNULL(@CONTRACT_CODE,'')
            ,ISNULL(@CONTRACT_ANNEX,'')
            ,ISNULL(@COMPANY_RUT,'')
        );
        SET @CREATED = 1;
    END;

    -- Update the user password (if supplied)
    SET @PWD_TEXT = RTRIM(@PWD_TEXT);
    IF (LEN(@PWD_TEXT) > 0) BEGIN
        UPDATE dbo.EcuACCUSU
        SET    PSW_ULTIMAS_006 = PSW_ULTIMAS_005,
               PSW_ULTIMAS_005 = PSW_ULTIMAS_004,
               PSW_ULTIMAS_004 = PSW_ULTIMAS_003,
               PSW_ULTIMAS_003 = PSW_ULTIMAS_002,
               PSW_ULTIMAS_002 = PSW_ULTIMAS_001,
               PSW_ULTIMAS_001 = PASSWORD,
               PASSWORD        = @PWD_TEXT,
               PSW_ESTADO      = 'EXP',
               PSW_VIG_DESD    = 0
        WHERE  USU_CODIGO = @USER_CODE;
    END;

    -- Delete all profiles of the user
    DELETE FROM dbo.EcuACCU2P
    WHERE CODIGO_ADI = @USER_CODE;

    -- Insert the supplied user profiles
    SET @PROFILES = RTRIM(@PROFILES);
    WHILE (LEN(@PROFILES) > 0) BEGIN
        -- Locate "<LF>" of next "ProfileID<LF>"
        SET @INDEX = CHARINDEX(CHAR(10), @PROFILES);
        IF (@INDEX = 0) BREAK;

        -- Extract "ProfileCode" from list of profiles
        SET @PROFILE_CODE = CONVERT(INTEGER, LEFT(@PROFILES, @INDEX - 1));
        SET @PROFILES = SUBSTRING(@PROFILES, @INDEX + 1, LEN(@PROFILES));

        -- Verify that the profile code exists
        IF NOT EXISTS(SELECT * FROM dbo.EcuACCPER 
            WHERE V_ACC_CODE_NUM = @PROFILE_CODE)
        BEGIN
            RAISERROR('Perfil no está definido: %d', 16, 1, @PROFILE_CODE);
            RETURN;
        END;

        -- Assign a new profile to the user
        INSERT INTO dbo.EcuACCU2P
            (CODIGO_ADI, CODIGO_ECU)
        VALUES 
            (@USER_CODE, @PROFILE_CODE);
    END;

    -- Generate an audit record
    IF (@CREATED = 0) BEGIN
        SET @AUDIT_EVENT = 15;
        SET @AUDIT_MESSAGE = 'Usuario fue modificado: ' + @USER_CODE;
    END
    ELSE BEGIN
        SET @AUDIT_EVENT = 13;
        SET @AUDIT_MESSAGE = 'Usuario fue creado: ' + @USER_CODE;
    END;
    EXEC dbo.SECURITYFX$AUDIT_PUT
        @WSS_USER_CODE, @WSS_PROFILE_CODE, @WSS_STATION_CODE, 
        @AUDIT_EVENT, @AUDIT_MESSAGE;
END
GO
