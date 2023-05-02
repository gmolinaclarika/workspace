IF EXISTS(SELECT * FROM sysobjects WHERE name = 'securityfx$profile_put' AND type = 'P')
    DROP PROCEDURE securityfx$profile_put
GO

CREATE PROCEDURE securityfx$profile_put
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
    @PROFILE_CODE       INTEGER,
    @NAME               NVARCHAR(100),
    @FLAGS              NVARCHAR(100),
    @MENU               NVARCHAR(100),
    @DOMAIN             NVARCHAR(100),
    -- Privilege Properties
    @PRIV_MENU          NVARCHAR(100),
    @PRIV_VARL          NVARCHAR(100),
    @PRIV_VARM          NVARCHAR(100),
    @PRIV_REGL          NVARCHAR(100),
    @PRIV_REGM          NVARCHAR(100),
    -- Restriction Properties
    @EXPIRES            INTEGER,
    @HOUR_FROM          DECIMAL(4,2),
    @HOUR_TO            DECIMAL(4,2),
    @PWD_DAYS           INTEGER,
    -- Terminal Properties
    @TERM_COUNT         INTEGER,
    @TERMINAL01         NVARCHAR(100),
    @TERMINAL02         NVARCHAR(100),
    @TERMINAL03         NVARCHAR(100),
    @TERMINAL04         NVARCHAR(100),
    @TERMINAL05         NVARCHAR(100),
    @TERMINAL06         NVARCHAR(100),
    @TERMINAL07         NVARCHAR(100),
    @TERMINAL08         NVARCHAR(100),
    @TERMINAL09         NVARCHAR(100),
    @TERMINAL10         NVARCHAR(100),
    @TERMINAL11         NVARCHAR(100),
    @TERMINAL12         NVARCHAR(100),
    @TERMINAL13         NVARCHAR(100),
    @TERMINAL14         NVARCHAR(100),
    @TERMINAL15         NVARCHAR(100),
    @TERMINAL16         NVARCHAR(100),
    -- Output Parameters
    @CREATED            INTEGER OUT
AS
BEGIN
    DECLARE @AUDIT_EVENT    INTEGER
    DECLARE @AUDIT_MESSAGE  NVARCHAR(100)

    -- Set No Count
    SET NOCOUNT ON

    -- Asume the profile exists
    SELECT @CREATED = 0

    -- Update the properties of specified profile
    UPDATE dbo.EcuACCPER
    SET    V_ACC_NAME           = ISNULL(@NAME,''),
           V_ACC_INDICADORES    = ISNULL(@FLAGS,''),
           V_ACC_PROG_INI       = ISNULL(@MENU,''),
           V_ACC_FAMILIA        = ISNULL(@DOMAIN,''),
           -- Privilege Properties
           V_ACC_PRIV_MEN       = ISNULL(@PRIV_MENU,''),
           V_ACC_PRIV_VARL      = ISNULL(@PRIV_VARL,''),
           V_ACC_PRIV_VARM      = ISNULL(@PRIV_VARM,''),
           V_ACC_PRIV_REGL      = ISNULL(@PRIV_REGL,''),
           V_ACC_PRIV_REGM      = ISNULL(@PRIV_REGM,''),
           -- Restriction Properties
           V_ACC_EXP            = @EXPIRES,
           V_ACC_HORA_INIC      = @HOUR_FROM,
           V_ACC_HORA_FIN       = @HOUR_TO,
           V_ACC_DIAS_VIG_PASSW = @PWD_DAYS,
           -- Terminal Properties
           V_ACC_CANT_TERM      = @TERM_COUNT,
           V_ACC_TERM_001       = ISNULL(@TERMINAL01,''),
           V_ACC_TERM_002       = ISNULL(@TERMINAL02,''),
           V_ACC_TERM_003       = ISNULL(@TERMINAL03,''),
           V_ACC_TERM_004       = ISNULL(@TERMINAL04,''),
           V_ACC_TERM_005       = ISNULL(@TERMINAL05,''),
           V_ACC_TERM_006       = ISNULL(@TERMINAL06,''),
           V_ACC_TERM_007       = ISNULL(@TERMINAL07,''),
           V_ACC_TERM_008       = ISNULL(@TERMINAL08,''),
           V_ACC_TERM_009       = ISNULL(@TERMINAL09,''),
           V_ACC_TERM_010       = ISNULL(@TERMINAL10,''),
           V_ACC_TERM_011       = ISNULL(@TERMINAL11,''),
           V_ACC_TERM_012       = ISNULL(@TERMINAL12,''),
           V_ACC_TERM_013       = ISNULL(@TERMINAL13,''),
           V_ACC_TERM_014       = ISNULL(@TERMINAL14,''),
           V_ACC_TERM_015       = ISNULL(@TERMINAL15,''),
           V_ACC_TERM_016       = ISNULL(@TERMINAL16,'')
    WHERE  V_ACC_CODE_NUM = @PROFILE_CODE

    -- Create profile if it didn't exist
    IF (@@ROWCOUNT = 0) BEGIN
        INSERT INTO dbo.EcuACCPER (
             V_ACC_CODE_NUM
            ,V_ACC_NAME
            ,V_ACC_INDICADORES
            ,V_ACC_PROG_INI
            ,V_ACC_FAMILIA
            -- Privilege Properties
            ,V_ACC_PRIV_MEN
            ,V_ACC_PRIV_VARL
            ,V_ACC_PRIV_VARM
            ,V_ACC_PRIV_REGL
            ,V_ACC_PRIV_REGM
            -- Restriction Properties
            ,V_ACC_EXP
            ,V_ACC_HORA_INIC
            ,V_ACC_HORA_FIN
            ,V_ACC_DIAS_VIG_PASSW
            -- Terminal Properties
            ,V_ACC_CANT_TERM
            ,V_ACC_TERM_001
            ,V_ACC_TERM_002
            ,V_ACC_TERM_003
            ,V_ACC_TERM_004
            ,V_ACC_TERM_005
            ,V_ACC_TERM_006
            ,V_ACC_TERM_007
            ,V_ACC_TERM_008
            ,V_ACC_TERM_009
            ,V_ACC_TERM_010
            ,V_ACC_TERM_011
            ,V_ACC_TERM_012
            ,V_ACC_TERM_013
            ,V_ACC_TERM_014
            ,V_ACC_TERM_015
            ,V_ACC_TERM_016
        ) VALUES (
             @PROFILE_CODE
            ,ISNULL(@NAME,'')
            ,ISNULL(@FLAGS,'')
            ,ISNULL(@MENU,'')
            ,ISNULL(@DOMAIN,'')
            -- Privilege Properties
            ,ISNULL(@PRIV_MENU,'')
            ,ISNULL(@PRIV_VARL,'')
            ,ISNULL(@PRIV_VARM,'')
            ,ISNULL(@PRIV_REGL,'')
            ,ISNULL(@PRIV_REGM,'')
            -- Restriction Properties
            ,@EXPIRES
            ,@HOUR_FROM
            ,@HOUR_TO
            ,@PWD_DAYS
            -- Terminal Properties
            ,@TERM_COUNT
            ,ISNULL(@TERMINAL01,'')
            ,ISNULL(@TERMINAL02,'')
            ,ISNULL(@TERMINAL03,'')
            ,ISNULL(@TERMINAL04,'')
            ,ISNULL(@TERMINAL05,'')
            ,ISNULL(@TERMINAL06,'')
            ,ISNULL(@TERMINAL07,'')
            ,ISNULL(@TERMINAL08,'')
            ,ISNULL(@TERMINAL09,'')
            ,ISNULL(@TERMINAL10,'')
            ,ISNULL(@TERMINAL11,'')
            ,ISNULL(@TERMINAL12,'')
            ,ISNULL(@TERMINAL13,'')
            ,ISNULL(@TERMINAL14,'')
            ,ISNULL(@TERMINAL15,'')
            ,ISNULL(@TERMINAL16,'')
        )
        SELECT @CREATED = 1
    END

    -- Generate an audit record
    IF (@CREATED = 0) BEGIN
        SELECT @AUDIT_EVENT = 56
        SELECT @AUDIT_MESSAGE = CAST(@PROFILE_CODE AS NVARCHAR)
        SELECT @AUDIT_MESSAGE = 'Perfil fue modificado: ' + @AUDIT_MESSAGE
    END
    ELSE BEGIN
        SELECT @AUDIT_EVENT = 55
        SELECT @AUDIT_MESSAGE = CAST(@PROFILE_CODE AS NVARCHAR)
        SELECT @AUDIT_MESSAGE = 'Perfil fue creado: ' + @AUDIT_MESSAGE
    END
    EXEC dbo.securityfx$audit_put
        @WSS_USER_CODE, @WSS_PROFILE_CODE, @WSS_STATION_CODE,
        @AUDIT_EVENT, @AUDIT_MESSAGE
END
GO

sp_procxmode securityfx$profile_put, "anymode"
GO
