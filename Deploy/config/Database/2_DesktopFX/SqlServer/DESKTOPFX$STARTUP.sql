IF OBJECT_ID(N'dbo.DESKTOPFX$STARTUP', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.DESKTOPFX$STARTUP
GO

CREATE PROCEDURE dbo.DESKTOPFX$STARTUP
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
    @NONCE              VARBINARY(MAX),
    @VERSION            INTEGER         OUTPUT,
    @BYTES              VARBINARY(MAX)  OUTPUT,
    @DIGEST             VARBINARY(MAX)  OUTPUT
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Initialize outputs
    SET @VERSION = NULL;
    SET @BYTES = NULL;
    SET @DIGEST = NULL;

    -- Verify station name
    IF (LEN(@WSS_STATION_CODE) = 0) BEGIN
        RAISERROR('No se suministro nombre de la estación de trabajo', 16, 1);
        RETURN;
    END;

    -- Verify serial number
    IF (LEN(@SERIAL) = 0) BEGIN
        RAISERROR('No se suministro serie de la estación de trabajo', 16, 1);
        RETURN;
    END;

    -- Return startup properties (NULL if not defined)
    SELECT @BYTES = BYTES
    FROM   dbo.DESKTOPFX_OBJECT
    WHERE  LOGIN_ID = 0
    AND    TYPE = 1
    AND    NAME = 'STARTUP';
END;
GO
