IF EXISTS(SELECT * FROM sysobjects WHERE name = 'securityfx$domain_get' AND type = 'P')
    DROP PROCEDURE securityfx$domain_get
GO

CREATE PROCEDURE securityfx$domain_get
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
    @DOMAIN_NAME        NVARCHAR(100),
    -- General Properties
    @NAME               NVARCHAR(100) OUT,
    @FUNCTION           NVARCHAR(100) OUT,
    @LOCATION           NVARCHAR(100) OUT,
    @TEXT1              NVARCHAR(100) OUT,
    @TEXT2              NVARCHAR(100) OUT,
    @TEXT3              NVARCHAR(100) OUT,
    @TEXT4              NVARCHAR(100) OUT
AS
BEGIN
    -- Set No Count
    SET NOCOUNT ON

    -- Normalize specified domain name
    SET @DOMAIN_NAME = UPPER(RTRIM(@DOMAIN_NAME))

    -- Return the properties of specified domain
    SELECT
        -- General Properties
        @NAME     = RTRIM(V_FAM_FAMILIA),
        @FUNCTION = RTRIM(V_FAM_NOMBRE_USUARIO),
        @LOCATION = RTRIM(V_FAM_UBICACION),
        @TEXT1    = RTRIM(V_FAM_TEXTO1),
        @TEXT2    = RTRIM(V_FAM_TEXTO2),
        @TEXT3    = RTRIM(V_FAM_TEXTO3),
        @TEXT4    = RTRIM(V_FAM_TEXTO4)
    FROM   dbo.EcuACCFAM
    WHERE  V_FAM_FAMILIA = @DOMAIN_NAME
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR 99999, 'Dominio no está definido: %s', @DOMAIN_NAME
        RETURN
    END
END
GO

sp_procxmode securityfx$domain_get, "anymode"
GO
