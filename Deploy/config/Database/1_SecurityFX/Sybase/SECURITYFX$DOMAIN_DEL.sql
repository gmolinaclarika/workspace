IF EXISTS(SELECT * FROM sysobjects WHERE name = 'securityfx$domain_del' AND type = 'P')
    DROP PROCEDURE securityfx$domain_del
GO

CREATE PROCEDURE securityfx$domain_del
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
    @DOMAIN_NAME        NVARCHAR(100)
AS
BEGIN
    DECLARE @AUDIT_EVENT    INTEGER
    DECLARE @AUDIT_MESSAGE  NVARCHAR(100)

    -- Set No Count
    SET NOCOUNT ON

    -- Normalize specified domain name
    SET @DOMAIN_NAME = UPPER(RTRIM(@DOMAIN_NAME))
    IF (@DOMAIN_NAME = 'GENERAL') BEGIN
        RAISERROR 99999, 'No puede borrar el dominio %s', @DOMAIN_NAME
        RETURN
    END

    -- Check the domain is not assigned to a user
    IF EXISTS(SELECT * FROM dbo.EcuACCUSU WHERE FAMILIA = @DOMAIN_NAME) BEGIN
        RAISERROR 99999, 'Dominio %s está asignado a uno o más usuarios', @DOMAIN_NAME
        RETURN
    END

    -- Check the domain is not assigned to a profile
    IF EXISTS(SELECT * FROM dbo.EcuACCPER WHERE V_ACC_FAMILIA = @DOMAIN_NAME) BEGIN
        RAISERROR 99999, 'Dominio %s está asignado a uno o más perfiles', @DOMAIN_NAME
        RETURN
    END

    -- Check the domain is not assigned to a terminal
    IF EXISTS(SELECT * FROM dbo.EcuACCNET WHERE V_NET_FAMILIA = @DOMAIN_NAME) BEGIN
        RAISERROR 99999, 'Dominio %s está asignado a uno o más terminales', @DOMAIN_NAME
        RETURN
    END

    -- Delete the properties of specified domain
    DELETE FROM dbo.EcuACCFAM
    WHERE  V_FAM_FAMILIA = @DOMAIN_NAME

    -- Generate an audit record
    SELECT @AUDIT_EVENT = 12
    SELECT @AUDIT_MESSAGE = 'Familia fue eliminada: ' + @DOMAIN_NAME
    EXEC dbo.securityfx$audit_put
        @WSS_USER_CODE, @WSS_PROFILE_CODE, @WSS_STATION_CODE,
        @AUDIT_EVENT, @AUDIT_MESSAGE
END
GO

sp_procxmode securityfx$domain_del, "anymode"
GO
