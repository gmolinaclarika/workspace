IF EXISTS(SELECT * FROM sysobjects WHERE name = 'securityfx$user_del' AND type = 'P')
    DROP PROCEDURE securityfx$user_del
GO

CREATE PROCEDURE securityfx$user_del
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
    @USER_CODE          NVARCHAR(100)
AS
BEGIN
    DECLARE @AUDIT_EVENT    INTEGER
    DECLARE @AUDIT_MESSAGE  NVARCHAR(100)

    -- Set No Count
    SET NOCOUNT ON

    -- Cannot delete ADMIN user
    SELECT @USER_CODE = UPPER(RTRIM(@USER_CODE))
    IF (@USER_CODE = 'ADMIN') BEGIN
        RAISERROR 99999, 'No puede borrar el usuario: %s', @USER_CODE
        RETURN
    END

    -- Delete all profiles of the user
    DELETE FROM dbo.EcuACCU2P
    WHERE CODIGO_ADI = @USER_CODE

    -- Delete all capacities of the user
    DELETE FROM dbo.EcuACCC2U
    WHERE CODIGO_ADI = @USER_CODE

    -- Delete the properties of the user
    DELETE FROM dbo.EcuACCUSU
    WHERE  USU_CODIGO = @USER_CODE

    -- Generate an audit record
    SELECT @AUDIT_EVENT = 57
    SELECT @AUDIT_MESSAGE = 'Usuario fue eliminado: ' + @USER_CODE
    EXEC dbo.securityfx$audit_put
        @WSS_USER_CODE, @WSS_PROFILE_CODE,  @WSS_STATION_CODE,
        @AUDIT_EVENT, @AUDIT_MESSAGE
END
GO

sp_procxmode securityfx$user_del, "anymode"
GO
