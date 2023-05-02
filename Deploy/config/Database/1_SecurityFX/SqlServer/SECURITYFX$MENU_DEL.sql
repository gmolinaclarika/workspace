IF OBJECT_ID(N'dbo.SECURITYFX$MENU_DEL', N'P') IS NOT NULL
    DROP PROCEDURE dbo.SECURITYFX$MENU_DEL
GO

CREATE PROCEDURE dbo.SECURITYFX$MENU_DEL
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
    @MENU_ID            BIGINT
AS
BEGIN
    DECLARE @AUDIT_EVENT    INTEGER;
    DECLARE @AUDIT_MESSAGE  NVARCHAR(100);
    DECLARE @MENU_NAME      NVARCHAR(200);

    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Obtain name of specified menu ID
    SELECT @MENU_NAME = NAME
    FROM   dbo.DESKTOPFX_OBJECT
    WHERE  LOGIN_ID = 0 AND TYPE = 4 AND ID = @MENU_ID;
    IF (@@ROWCOUNT = 0) RETURN;

    -- Delete the specified menu
    DELETE FROM dbo.DESKTOPFX_OBJECT
    WHERE LOGIN_ID = 0 AND TYPE = 4 AND ID = @MENU_ID;

    -- Generate an audit record
    SET @AUDIT_EVENT = 57;
    SET @AUDIT_MESSAGE = 'Menú fue eliminado: ' + @MENU_NAME;
    EXEC dbo.SECURITYFX$AUDIT_PUT
        @WSS_USER_CODE, @WSS_PROFILE_CODE,  @WSS_STATION_CODE,
        @AUDIT_EVENT, @AUDIT_MESSAGE;
END
GO
