IF EXISTS(SELECT * FROM sysobjects WHERE name = 'mcastnews$items_get' AND type = 'P')
    DROP PROCEDURE mcastnews$items_get
GO

CREATE PROCEDURE mcastnews$items_get
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
    @VALID_FROM         DATETIME,
    @ITEMS_MAX          INTEGER
AS
BEGIN
    -- Set No Count
    SET NOCOUNT ON

    -- #ResultSet ITEM ITEMS
    --    #Column ID                DECIMAL
    --    #Column VALID_FROM        DATETIME
    --    #Column MESSAGE           NVARCHAR
    --    #Column ATTACHMENT_TYPE   NVARCHAR
    -- #EndResultSet
    SELECT --TOP(@ITEMS_MAX)
           ID               AS ID,
           VALID_FROM       AS VALID_FROM,
           MESSAGE          AS MESSAGE,
           ATTACHMENT_TYPE  AS ATTACHMENT_TYPE
    FROM   dbo.DESKTOPFX_MULTICAST
    WHERE  (@VALID_FROM <= VALID_FROM) AND (GETDATE() <= VALID_TO)
    AND    (USER_FILTER    IS NULL OR USER_FILTER    = @WSS_USER_CODE)
    AND    (PROFILE_FILTER IS NULL OR PROFILE_FILTER = @WSS_PROFILE_CODE)
    AND    (STATION_FILTER IS NULL OR STATION_FILTER = @WSS_STATION_CODE)
    AND    NAME = 'news'
    ORDER BY VALID_FROM DESC
END
GO

sp_procxmode mcastnews$items_get, "anymode"
GO
