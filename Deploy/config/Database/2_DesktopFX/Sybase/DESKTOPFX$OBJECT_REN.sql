IF EXISTS(SELECT * FROM sysobjects WHERE name = 'desktopfx$object_ren' AND type = 'P')
    DROP PROCEDURE desktopfx$object_ren
GO

CREATE PROCEDURE desktopfx$object_ren
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
    @NEW_NAME           NVARCHAR(200)
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

    -- Cannot rename GLOBAL objects
    IF (@LOGIN_ID = 0) BEGIN
        RAISERROR 99999, 'No se puede renombrar un objeto global'
        RETURN
    END

    -- Check new name does not exist
    IF EXISTS(SELECT *
        FROM  dbo.DESKTOPFX_OBJECT
        WHERE LOGIN_ID = @LOGIN_ID
        AND   TYPE = @TYPE
        AND   NAME = @NEW_NAME)
    BEGIN
        RAISERROR 99999, 'Nombre ya se encuentra en uso: %s', @NEW_NAME
        RETURN
    END

    -- Change old name to new name
    UPDATE dbo.DESKTOPFX_OBJECT
    SET    NAME = @NEW_NAME
    WHERE  LOGIN_ID = @LOGIN_ID
    AND    TYPE = @TYPE
    AND    NAME = @NAME
END
GO

sp_procxmode desktopfx$object_ren, "anymode"
GO
