IF OBJECT_ID(N'dbo.MCASTADMIN$MULTICAST_ADD', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.MCASTADMIN$MULTICAST_ADD
GO

CREATE PROCEDURE dbo.MCASTADMIN$MULTICAST_ADD
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
    @NAME               NVARCHAR(200),
    @MESSAGE            NVARCHAR(2000),
    @VALID_FROM         DATETIME,
    @VALID_TO           DATETIME,
    @USER_FILTER        NVARCHAR(200),
    @PROFILE_FILTER     INTEGER,
    @STATION_FILTER     NVARCHAR(200),
    @ATTACHMENT_TYPE    NVARCHAR(200),
    @ATTACHMENT         VARBINARY(MAX),
    @NEW_MULTICAST_ID   DECIMAL(19)         OUTPUT
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Create new Multicast instance
    INSERT INTO dbo.DESKTOPFX_MULTICAST (
        NAME, MESSAGE, VALID_FROM, VALID_TO, USER_FILTER,
        PROFILE_FILTER, STATION_FILTER, ATTACHMENT_TYPE, ATTACHMENT
    ) VALUES (
        @NAME, @MESSAGE, @VALID_FROM, @VALID_TO, @USER_FILTER,
        @PROFILE_FILTER, @STATION_FILTER, @ATTACHMENT_TYPE, @ATTACHMENT
    );

    -- Return the ID of the new Multicast
    SET @NEW_MULTICAST_ID = SCOPE_IDENTITY();
END
GO
