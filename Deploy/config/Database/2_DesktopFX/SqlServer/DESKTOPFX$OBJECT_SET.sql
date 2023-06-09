IF OBJECT_ID(N'dbo.DESKTOPFX$OBJECT_SET', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.DESKTOPFX$OBJECT_SET
GO

CREATE PROCEDURE dbo.DESKTOPFX$OBJECT_SET
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
    @LEVEL              INTEGER,
    @TYPE               INTEGER,
    @NAME               NVARCHAR(200),
    @BYTES              VARBINARY(MAX)
AS
BEGIN
    DECLARE @LOGIN_ID       BIGINT;
    DECLARE @PROFILE_CODE   INTEGER;

    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Obtain LoginID for User/Profile/Level
    SET @LOGIN_ID = 0;
    IF (@LEVEL >= -1) BEGIN
        IF (@LEVEL = -1) BEGIN
            SET @PROFILE_CODE = -1;
        END ELSE BEGIN
            SET @PROFILE_CODE = @WSS_PROFILE_CODE;
        END;
        SELECT @LOGIN_ID = g.ID
        FROM   dbo.DESKTOPFX_USER u, dbo.DESKTOPFX_LOGIN g
        WHERE  u.USER_CODE = @WSS_USER_CODE
        AND    g.PROFILE_CODE = @PROFILE_CODE
        AND    u.ID = g.USER_ID;
        IF (@@ROWCOUNT = 0) BEGIN
            RAISERROR('No existe login del usuario y perfil', 16, 1);
            RETURN;
        END;
    END;

    -- Cannot add GLOBAL objects
    IF (@LOGIN_ID = 0) BEGIN
        RAISERROR('No se puede modificar un objeto global', 16, 1);
        RETURN;
    END;

    -- Update object bytes
    UPDATE dbo.DESKTOPFX_OBJECT
    SET    BYTES = @BYTES,
           MODIFIED = GETDATE()
    WHERE  LOGIN_ID = @LOGIN_ID
    AND    TYPE = @TYPE
    AND    NAME = @NAME;

    -- Insert if it did not exist
    IF (@@ROWCOUNT = 0) BEGIN
        INSERT INTO dbo.DESKTOPFX_OBJECT 
            (LOGIN_ID, TYPE, NAME, BYTES)
        VALUES 
            (@LOGIN_ID, @TYPE, @NAME, @BYTES);
    END;
END;
GO
