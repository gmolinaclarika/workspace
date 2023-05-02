IF OBJECT_ID(N'dbo.SECURITYFX$DOMAIN_DEL', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.SECURITYFX$DOMAIN_DEL
GO

CREATE PROCEDURE dbo.SECURITYFX$DOMAIN_DEL
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
    DECLARE @AUDIT_EVENT    INTEGER;
    DECLARE @AUDIT_MESSAGE  NVARCHAR(100);

    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Normalize specified domain name
    SET @DOMAIN_NAME = UPPER(RTRIM(@DOMAIN_NAME));
    IF (@DOMAIN_NAME = 'GENERAL') BEGIN
        RAISERROR('No se puede borrar el dominio %s', 16, 1, @DOMAIN_NAME);
        RETURN;
    END;

    -- Check the domain is not assigned to a user
    IF EXISTS(SELECT * FROM dbo.EcuACCUSU WHERE FAMILIA = @DOMAIN_NAME) BEGIN
        RAISERROR('Dominio %s está asignado a uno o más usuarios', 16, 2, @DOMAIN_NAME);
        RETURN;
    END;

    -- Check the domain is not assigned to a profile
    IF EXISTS(SELECT * FROM dbo.EcuACCPER WHERE V_ACC_FAMILIA = @DOMAIN_NAME) BEGIN
        RAISERROR('Dominio %s está asignado a uno o más perfiles', 16, 3, @DOMAIN_NAME);
        RETURN;
    END;

    -- Check the domain is not assigned to a terminal
    IF EXISTS(SELECT * FROM dbo.EcuACCNET WHERE V_NET_FAMILIA = @DOMAIN_NAME) BEGIN
        RAISERROR('Dominio %s está asignado a uno o más terminales', 16, 4, @DOMAIN_NAME);
        RETURN;
    END;

    -- Delete the properties of specified domain
    DELETE FROM dbo.EcuACCFAM
    WHERE  V_FAM_FAMILIA = @DOMAIN_NAME;

    -- Generate an audit record
    SET @AUDIT_EVENT = 12;
    SET @AUDIT_MESSAGE = 'Dominio fue eliminado: ' + @DOMAIN_NAME;
    EXEC dbo.SECURITYFX$AUDIT_PUT
        @WSS_USER_CODE, @WSS_PROFILE_CODE, @WSS_STATION_CODE, 
        @AUDIT_EVENT, @AUDIT_MESSAGE;
END
GO
