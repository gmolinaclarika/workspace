IF EXISTS(SELECT * FROM sysobjects WHERE name = 'desktopfx$startup' AND type = 'P')
    DROP PROCEDURE desktopfx$startup
GO

CREATE PROCEDURE desktopfx$startup
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
    @SERIAL             NVARCHAR(200),
    @NONCE              IMAGE,
    @VERSION            INTEGER         OUTPUT,
    @BYTES              IMAGE           OUTPUT,
    @DIGEST             IMAGE           OUTPUT
AS
BEGIN
    -- Set No Count
    SET NOCOUNT ON

    -- Initialize outputs
    SELECT @VERSION = NULL
    SELECT @BYTES = NULL
    SELECT @DIGEST = NULL

    -- Verify station name
    IF (LEN(@WSS_STATION_CODE) = 0) BEGIN
        RAISERROR 99999, 'No se suministro nombre de la estación de trabajo'
        RETURN
    END

    -- Verify serial number
    IF (LEN(@SERIAL_NUMBER) = 0) BEGIN
        RAISERROR 99999, 'No se suministro serie de la estación de trabajo'
        RETURN
    END

    -- Return startup properties (NULL if not defined)
    SELECT @BYTES = BYTES
    FROM   dbo.DESKTOPFX_OBJECT
    WHERE  LOGIN_ID = 0
    AND    TYPE = 1
    AND    NAME = 'STARTUP'
END
GO

sp_procxmode desktopfx$startup, "anymode"
GO
