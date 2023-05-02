IF OBJECT_ID(N'dbo.MCASTADMIN$MULTICAST_DIR', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.MCASTADMIN$MULTICAST_DIR
GO

CREATE PROCEDURE dbo.MCASTADMIN$MULTICAST_DIR
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
    @MULTICASTS_MAX     INTEGER
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- #ResultSet ENTRY ENTRIES
    --    #Column ID                DECIMAL
    --    #Column NAME              NVARCHAR
    --    #Column MESSAGE           NVARCHAR
    --    #Column VALID_FROM        DATETIME
    --    #Column VALID_TO          DATETIME
    --    #Column ATTACHMENT_TYPE   NVARCHAR
    --    #Column ATTACHMENT_SIZE   INTEGER
    --    #Column USER_FILTER       NVARCHAR
    --    #Column PROFILE_FILTER    INTEGER
    --    #Column STATION_FILTER    NVARCHAR
    -- #EndResultSet
    SELECT TOP(@MULTICASTS_MAX)
           ID                       AS ID,
           NAME                     AS NAME,
           MESSAGE                  AS MESSAGE,
           VALID_FROM               AS VALID_FROM,
           VALID_TO                 AS VALID_TO,
           ATTACHMENT_TYPE          AS ATTACHMENT_TYPE,
           CAST(DATALENGTH(ATTACHMENT) AS INTEGER) AS ATTACHMENT_SIZE,
           USER_FILTER              AS USER_FILTER,
           PROFILE_FILTER           AS PROFILE_FILTER,
           STATION_FILTER           AS STATION_FILTER
    FROM  dbo.DESKTOPFX_MULTICAST
    ORDER BY VALID_FROM;
END
GO
