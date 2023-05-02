IF EXISTS(SELECT * FROM sysobjects WHERE name = 'mcastadmin$multicast_del' AND type = 'P')
    DROP PROCEDURE mcastadmin$multicast_del
GO

CREATE PROCEDURE mcastadmin$multicast_del
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
    @MULTICAST_ID       DECIMAL(19)
AS
BEGIN
    -- Set No Count
    SET NOCOUNT ON

    -- Delete the Multicast Responses
    DELETE FROM dbo.DESKTOPFX_MRESPONSE
    WHERE  MULTICAST_ID = @MULTICAST_ID

    -- Delete the Multicast itself
    DELETE FROM dbo.DESKTOPFX_MULTICAST
    WHERE  ID = @MULTICAST_ID
END
GO

sp_procxmode mcastadmin$multicast_del, "anymode"
GO
