IF EXISTS(SELECT * FROM sysobjects WHERE name = 'desktopfx$plugin_max' AND type = 'P')
    DROP PROCEDURE desktopfx$plugin_max
GO

CREATE PROCEDURE desktopfx$plugin_max
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @PLUGIN_PREFIX      NVARCHAR(200),
    @MAX_MODIFIED       DATETIME            OUTPUT
AS
BEGIN
    -- Set No Count
    SET NOCOUNT ON

    -- Return plugin max modified date
    IF (LEN(@PLUGIN_PREFIX) = 0) BEGIN
        SELECT @MAX_MODIFIED = MAX(MODIFIED)
        FROM  dbo.DESKTOPFX_PLUGIN
        WHERE ENABLED = 1
    END
    ELSE BEGIN
        SELECT @MAX_MODIFIED = MAX(MODIFIED)
        FROM  dbo.DESKTOPFX_PLUGIN
        WHERE NAME LIKE @PLUGIN_PREFIX + '%'
          AND ENABLED = 1
    END

    -- Make sure we don't return NULL
    IF (@MAX_MODIFIED IS NULL) BEGIN
	    SELECT @MAX_MODIFIED = CONVERT(DATETIME, '1/1/1900', 101)
    END
END
GO

sp_procxmode desktopfx$plugin_max, "anymode"
GO
