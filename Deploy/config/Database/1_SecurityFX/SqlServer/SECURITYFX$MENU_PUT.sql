IF OBJECT_ID(N'dbo.SECURITYFX$MENU_PUT', N'P') IS NOT NULL
    DROP PROCEDURE dbo.SECURITYFX$MENU_PUT
GO

CREATE PROCEDURE dbo.SECURITYFX$MENU_PUT
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
    @MENU_NAME          NVARCHAR(200),
    @MENU_BYTES         VARBINARY(MAX),
    ----------------------------------
    @MENU_ID            BIGINT  OUT,
    @CREATED            INTEGER OUT
AS
BEGIN
    DECLARE @AUDIT_EVENT    INTEGER;
    DECLARE @AUDIT_MESSAGE  NVARCHAR(100);

    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Asume the menu exists
    SET @CREATED = 0;

    -- Normalize specified menu name
    SET @MENU_NAME = UPPER(RTRIM(@MENU_NAME));

    -- Update the properties of specified menu
    UPDATE dbo.DESKTOPFX_OBJECT
    SET    BYTES = @MENU_BYTES, @MENU_ID = ID
    WHERE  LOGIN_ID = 0 AND TYPE = 4 AND NAME = @MENU_NAME;

    -- Create menu if it didn't exist
    IF (@@ROWCOUNT = 0) BEGIN
        INSERT INTO dbo.DESKTOPFX_OBJECT (
             LOGIN_ID, TYPE, NAME, BYTES
        ) VALUES (
             0, 4, @MENU_NAME, @MENU_BYTES
        );
        SET @MENU_ID = SCOPE_IDENTITY();
        SET @CREATED = 1;
    END;

    -- Generate an audit record
    IF (@CREATED = 0) BEGIN
        SET @AUDIT_EVENT = 15;
        SET @AUDIT_MESSAGE = 'Menú fue modificado: ' + @MENU_NAME;
    END
    ELSE BEGIN
        SET @AUDIT_EVENT = 13;
        SET @AUDIT_MESSAGE = 'Menú fue creado: ' + @MENU_NAME;
    END;
    EXEC dbo.SECURITYFX$AUDIT_PUT
        @WSS_USER_CODE, @WSS_PROFILE_CODE, @WSS_STATION_CODE,
        @AUDIT_EVENT, @AUDIT_MESSAGE;
END
GO
