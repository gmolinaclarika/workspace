IF EXISTS(SELECT * FROM sysobjects WHERE name = 'securityfx$terminal_del' AND type = 'P')
    DROP PROCEDURE securityfx$terminal_del
GO

CREATE PROCEDURE securityfx$terminal_del
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
    @TERMINAL_NAME      NVARCHAR(100)
AS
BEGIN
    DECLARE @AUDIT_EVENT    INTEGER
    DECLARE @AUDIT_MESSAGE  NVARCHAR(100)

    -- Set No Count
    SET NOCOUNT ON

    -- Normalize specified terminal name
    SELECT @TERMINAL_NAME = UPPER(RTRIM(@TERMINAL_NAME))

    -- Delete the properties of specified terminal
    DELETE FROM dbo.EcuACCNET
    WHERE  V_NET_NOMBRE = @TERMINAL_NAME

    -- Generate an audit record
    SELECT @AUDIT_EVENT = 12
    SELECT @AUDIT_MESSAGE = 'Terminal fue eliminado: ' + @TERMINAL_NAME
    EXEC dbo.securityfx$audit_put
        @WSS_USER_CODE, @WSS_PROFILE_CODE,  @WSS_STATION_CODE,
        @AUDIT_EVENT, @AUDIT_MESSAGE
END
GO

sp_procxmode securityfx$terminal_del, "anymode"
GO
