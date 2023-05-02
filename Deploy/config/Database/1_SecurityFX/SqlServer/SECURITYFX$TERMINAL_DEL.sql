IF OBJECT_ID(N'dbo.SECURITYFX$TERMINAL_DEL', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.SECURITYFX$TERMINAL_DEL
GO

CREATE PROCEDURE dbo.SECURITYFX$TERMINAL_DEL
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
    DECLARE @AUDIT_EVENT    INTEGER;
    DECLARE @AUDIT_MESSAGE  NVARCHAR(100);

    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Normalize specified terminal name
    SET @TERMINAL_NAME = UPPER(RTRIM(@TERMINAL_NAME));

    -- Delete the properties of specified terminal
    DELETE FROM dbo.EcuACCNET
    WHERE  V_NET_NOMBRE = @TERMINAL_NAME;

    -- Generate an audit record
    SET @AUDIT_EVENT = 12;
    SET @AUDIT_MESSAGE = 'Terminal fue eliminado: ' + @TERMINAL_NAME;
    EXEC dbo.SECURITYFX$AUDIT_PUT
        @WSS_USER_CODE, @WSS_PROFILE_CODE,  @WSS_STATION_CODE, 
        @AUDIT_EVENT, @AUDIT_MESSAGE;
END
GO
