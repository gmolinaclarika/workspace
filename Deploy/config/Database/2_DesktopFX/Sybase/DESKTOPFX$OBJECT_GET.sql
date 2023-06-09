IF EXISTS(SELECT * FROM sysobjects WHERE name = 'desktopfx$object_get' AND type = 'P')
    DROP PROCEDURE desktopfx$object_get
GO

CREATE PROCEDURE desktopfx$object_get
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
    @BYTES              IMAGE               OUTPUT,
    @GBYTES             IMAGE               OUTPUT
AS
BEGIN
    DECLARE @LOGIN_ID       BIGINT
    DECLARE @PROFILE_CODE   INTEGER

    -- Set No Count
    SET NOCOUNT ON

    -- Obtain LoginID for User/Profile/Level
    SELECT @LOGIN_ID = 0
    IF (@LEVEL >= -1) BEGIN
        IF (@LEVEL = -1) BEGIN
            SELECT @PROFILE_CODE = -1
        END ELSE BEGIN
            SELECT @PROFILE_CODE = @WSS_PROFILE_CODE
        END
        SELECT @LOGIN_ID = g.ID
        FROM   dbo.DESKTOPFX_USER u, dbo.DESKTOPFX_LOGIN g
        WHERE  u.USER_CODE = @WSS_USER_CODE
        AND    g.PROFILE_CODE = @PROFILE_CODE
        AND    u.ID = g.USER_ID
        IF (@@ROWCOUNT = 0) BEGIN
            RAISERROR 99999, 'No existe login del usuario y perfil'
            RETURN
        END
    END

    -- Return object bytes
    SELECT @BYTES = BYTES
    FROM   dbo.DESKTOPFX_OBJECT
    WHERE  LOGIN_ID = @LOGIN_ID
    AND    TYPE = @TYPE
    AND    NAME = @NAME

    -- Return GLOBAL (id=0) SETTINGS (type=3)
    SELECT @GBYTES = NULL
    IF (@TYPE = 3) BEGIN
        SELECT @GBYTES = BYTES
        FROM   dbo.DESKTOPFX_OBJECT
        WHERE  LOGIN_ID = 0
        AND    TYPE = @TYPE
        AND    NAME = @NAME
    END
END
GO

sp_procxmode desktopfx$object_get, "anymode"
GO
