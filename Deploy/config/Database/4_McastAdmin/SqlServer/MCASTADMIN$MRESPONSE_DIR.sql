IF OBJECT_ID(N'dbo.MCASTADMIN$MRESPONSE_DIR', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.MCASTADMIN$MRESPONSE_DIR
GO

CREATE PROCEDURE dbo.MCASTADMIN$MRESPONSE_DIR
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
    @MRESPONSES_MAX     INTEGER
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- #ResultSet ENTRY ENTRIES
    --    #Column ID                DECIMAL
    --    #Column MESSAGE           NVARCHAR
    --    #Column STATION_CODE      NVARCHAR
    --    #Column REQUEST_TIME      DATETIME
    --    #Column RESPONSE_TIME     DATETIME
    --    #Column ATTACHMENT_TYPE   NVARCHAR
    --    #Column ATTACHMENT_SIZE   INTEGER
    -- #EndResultSet
    SELECT TOP(@MRESPONSES_MAX)
           ID                       AS ID,
           MESSAGE                  AS MESSAGE,
           STATION_CODE             AS STATION_CODE,
           REQUEST_TIME             AS REQUEST_TIME,
           RESPONSE_TIME            AS RESPONSE_TIME,
           ATTACHMENT_TYPE          AS ATTACHMENT_TYPE,
           CAST(DATALENGTH(ATTACHMENT) AS INTEGER) AS ATTACHMENT_SIZE
    FROM  dbo.DESKTOPFX_MRESPONSE
    WHERE MULTICAST_ID = @MULTICAST_ID
    ORDER BY RESPONSE_TIME;
END
GO
