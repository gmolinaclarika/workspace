IF EXISTS(SELECT * FROM sysobjects WHERE name = 'desktopfx$multicast_get' AND type = 'P')
    DROP PROCEDURE desktopfx$multicast_get
GO

CREATE PROCEDURE desktopfx$multicast_get
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
    @MULTICAST_ID       DECIMAL(19),
    @VALID_FROM         DATETIME            OUTPUT,
    @VALID_TO           DATETIME            OUTPUT,
    @NAME               NVARCHAR(200)       OUTPUT,
    @MESSAGE            NVARCHAR(2000)      OUTPUT,
    @ATTACHMENT_TYPE    NVARCHAR(200)       OUTPUT,
    @ATTACHMENT         IMAGE               OUTPUT
AS
BEGIN
    -- Set No Count
    SET NOCOUNT ON

    -- Return Multicast properties
    SELECT @VALID_FROM      = VALID_FROM,
           @VALID_TO        = VALID_TO,
           @NAME            = NAME,
           @MESSAGE         = MESSAGE,
           @ATTACHMENT_TYPE = ATTACHMENT_TYPE,
           @ATTACHMENT      = ATTACHMENT
    FROM  dbo.DESKTOPFX_MULTICAST
    WHERE ID = @MULTICAST_ID
END
GO

sp_procxmode desktopfx$multicast_get, "anymode"
GO
