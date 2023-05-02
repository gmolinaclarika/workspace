IF OBJECT_ID(N'dbo.MCASTNEWS$ITEM_GET', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.MCASTNEWS$ITEM_GET
GO

CREATE PROCEDURE dbo.MCASTNEWS$ITEM_GET
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
    @NEWS_ID            DECIMAL(19),
    @VALID_FROM         DATETIME        OUT,
    @MESSAGE            NVARCHAR(2000)  OUT,
    @ATTACHMENT_TYPE    NVARCHAR(200)   OUT,
    @ATTACHMENT         VARBINARY(MAX)  OUT
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON

    -- Return News properties (if any) 
    SELECT @VALID_FROM      = VALID_FROM, 
           @MESSAGE         = MESSAGE,
           @ATTACHMENT_TYPE = ATTACHMENT_TYPE,
           @ATTACHMENT      = ATTACHMENT
    FROM  dbo.DESKTOPFX_MULTICAST
    WHERE ID = @NEWS_ID
END
GO
