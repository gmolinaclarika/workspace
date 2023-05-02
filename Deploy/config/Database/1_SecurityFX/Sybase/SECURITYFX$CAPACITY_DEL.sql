IF EXISTS(SELECT * FROM sysobjects WHERE name = 'securityfx$capacity_del' AND type = 'P')
    DROP PROCEDURE securityfx$capacity_del
GO

CREATE PROCEDURE securityfx$capacity_del
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
    @CAPACITY_CODE      NVARCHAR(100)
AS
BEGIN
    DECLARE @AUDIT_EVENT    INTEGER
    DECLARE @AUDIT_MESSAGE  NVARCHAR(100)

    -- Set No Count
    SET NOCOUNT ON

    -- Normalize specified capacity name
    SET @CAPACITY_CODE = UPPER(RTRIM(@CAPACITY_CODE))

    -- Check the capacity is not assigned to a user
    IF EXISTS(SELECT * FROM dbo.EcuACCC2U WHERE CAP_CODIGO = @CAPACITY_CODE) BEGIN
        RAISERROR 99999, 'Capacidad %s está asignada a uno o más usuarios', @CAPACITY_CODE
        RETURN
    END

    -- Check the capacity is not assigned to a profile
    IF EXISTS(SELECT * FROM dbo.EcuACCC2P WHERE CAP_CODIGO = @CAPACITY_CODE) BEGIN
        RAISERROR 99999, 'Capacidad %s está asignada a uno o más perfiles', @CAPACITY_CODE
        RETURN
    END

    -- Delete the properties of specified capacity
    DELETE FROM dbo.EcuACCCAP
    WHERE  CAP_CODIGO = @CAPACITY_CODE

    -- Generate an audit record
    SET @AUDIT_EVENT = 12
    SET @AUDIT_MESSAGE = 'Capacidad fue eliminada: ' + @CAPACITY_CODE
    EXEC dbo.securityfx$audit_put
        @WSS_USER_CODE, @WSS_PROFILE_CODE, @WSS_STATION_CODE,
        @AUDIT_EVENT, @AUDIT_MESSAGE
END
GO

sp_procxmode securityfx$capacity_del, "anymode"
GO
