IF EXISTS(SELECT * FROM sysobjects WHERE name = 'securityfx$profile_del' AND type = 'P')
    DROP PROCEDURE securityfx$profile_del
GO

CREATE PROCEDURE securityfx$profile_del
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
    @PROFILE_CODE       INTEGER
AS
BEGIN
    DECLARE @AUDIT_EVENT    INTEGER
    DECLARE @AUDIT_MESSAGE  NVARCHAR(100)

    -- Set No Count
    SET NOCOUNT ON

    -- Cannot delete ADMIN (0) profile
    IF (@PROFILE_CODE = 0) BEGIN
        SET @AUDIT_MESSAGE = CAST(@PROFILE_CODE AS VARCHAR)
        RAISERROR 99999, 'No puede borrar el perfil: %s', @AUDIT_MESSAGE
        RETURN
    END

    -- Delete all users of the profile
    DELETE FROM dbo.EcuACCU2P
    WHERE CODIGO_ECU = @PROFILE_CODE

    -- Delete all capacities of the profile
    DELETE FROM dbo.EcuACCC2P
    WHERE CODIGO_ECU = @PROFILE_CODE

    -- Delete the properties of the profile
    DELETE FROM dbo.EcuACCPER
    WHERE  V_ACC_CODE_NUM = @PROFILE_CODE

    -- Generate an audit record
    SELECT @AUDIT_EVENT = 57
    SELECT @AUDIT_MESSAGE = CAST(@PROFILE_CODE AS NVARCHAR)
    SELECT @AUDIT_MESSAGE = 'Perfil fue eliminado: ' + @AUDIT_MESSAGE
    EXEC dbo.securityfx$audit_put
        @WSS_USER_CODE, @WSS_PROFILE_CODE,  @WSS_STATION_CODE,
        @AUDIT_EVENT, @AUDIT_MESSAGE
END
GO

sp_procxmode securityfx$profile_del, "anymode"
GO
