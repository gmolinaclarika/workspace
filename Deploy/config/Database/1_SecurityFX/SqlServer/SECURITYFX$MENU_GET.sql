IF OBJECT_ID(N'dbo.SECURITYFX$MENU_GET', N'P') IS NOT NULL
    DROP PROCEDURE dbo.SECURITYFX$MENU_GET
GO

CREATE PROCEDURE dbo.SECURITYFX$MENU_GET
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
    ---------------------------------------
    @MENU_ID            BIGINT,
    ---------------------------------------
    @MENU_NAME          NVARCHAR(200)  OUT,
    @MENU_BYTES         VARBINARY(MAX) OUT
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Return the properties of specified menu
    SELECT
        @MENU_NAME  = NAME,
        @MENU_BYTES = BYTES
    FROM   dbo.DESKTOPFX_OBJECT
    WHERE  LOGIN_ID = 0 AND TYPE = 4 AND ID = @MENU_ID;
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR('Menú no está definido: %d', 16, 1, @MENU_ID);
        RETURN;
    END;
END
GO
