IF EXISTS(SELECT * FROM sysobjects WHERE name = 'securityfx$capacity_get' AND type = 'P')
    DROP PROCEDURE securityfx$capacity_get
GO

CREATE PROCEDURE securityfx$capacity_get
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
    @CAPACITY_CODE      NVARCHAR(100),
    -- General Properties
    @CODE               NVARCHAR(100) OUT,
    @NAME               NVARCHAR(200) OUT,
    @TYPE               INTEGER       OUT
AS
BEGIN
    -- Set No Count
    SET NOCOUNT ON

    -- Normalize specified capacity name
    SET @CAPACITY_CODE = UPPER(RTRIM(@CAPACITY_CODE))

    -- Return the properties of specified capacity
    SELECT
        -- General Properties
        @CODE = RTRIM(CAP_CODIGO),
        @NAME = RTRIM(CAP_NOMBRE),
        @TYPE = CAP_TIPO
    FROM   dbo.EcuACCCAP
    WHERE  CAP_CODIGO = @CAPACITY_CODE
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR 99999, 'Capacidad no está definida: %s', @CAPACITY_CODE
        RETURN
    END
END
GO

sp_procxmode securityfx$capacity_get, "anymode"
GO
