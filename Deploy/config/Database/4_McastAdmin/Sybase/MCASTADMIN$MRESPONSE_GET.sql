IF EXISTS(SELECT * FROM sysobjects WHERE name = 'mcastadmin$mresponse_get' AND type = 'P')
    DROP PROCEDURE mcastadmin$mresponse_get
GO

CREATE PROCEDURE mcastadmin$mresponse_get
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
    @MRESPONSE_ID       DECIMAL(19),
    @MULTICAST_ID       DECIMAL(19)         OUTPUT,
    @MESSAGE            NVARCHAR(1000)      OUTPUT,
    @STATION_CODE       NVARCHAR(200)       OUTPUT,
    @REQUEST_TIME       DATETIME            OUTPUT,
    @RESPONSE_TIME      DATETIME            OUTPUT,
    @ATTACHMENT_TYPE    NVARCHAR(200)       OUTPUT,
    @ATTACHMENT         IMAGE               OUTPUT
AS
BEGIN
    -- Set No Count
    SET NOCOUNT ON

    -- Return properties of Multicast Response
    SELECT @MULTICAST_ID    = MULTICAST_ID,
           @MESSAGE         = MESSAGE,
           @STATION_CODE    = STATION_CODE,
           @REQUEST_TIME    = REQUEST_TIME,
           @RESPONSE_TIME   = RESPONSE_TIME,
           @ATTACHMENT_TYPE = ATTACHMENT_TYPE,
           @ATTACHMENT      = ATTACHMENT
    FROM  dbo.DESKTOPFX_MRESPONSE
    WHERE ID = @MRESPONSE_ID
END
GO

sp_procxmode mcastadmin$mresponse_get, "anymode"
GO
