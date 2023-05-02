IF OBJECT_ID(N'dbo.DESKTOPFX$MRESPONSE_ADD', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.DESKTOPFX$MRESPONSE_ADD
GO

CREATE PROCEDURE dbo.DESKTOPFX$MRESPONSE_ADD
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
    @REQUEST_TIME       DATETIME,
    @MESSAGE            NVARCHAR(2000),
    @ATTACHMENT_TYPE    NVARCHAR(200),
    @ATTACHMENT         VARBINARY(MAX),
    @TRESPONSE_ID       DECIMAL(19)         OUTPUT
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Add new Multicast Response data 
    INSERT INTO dbo.DESKTOPFX_MRESPONSE (
         MULTICAST_ID
        ,STATION_CODE
        ,REQUEST_TIME
        ,RESPONSE_TIME
        ,MESSAGE
        ,ATTACHMENT_TYPE
        ,ATTACHMENT
    ) VALUES (
         @MULTICAST_ID
        ,@WSS_STATION_CODE
        ,@REQUEST_TIME
        ,GETDATE()
        ,@MESSAGE
        ,@ATTACHMENT_TYPE
        ,@ATTACHMENT
    );

    -- Return Multicast Response ID
    SET @TRESPONSE_ID = SCOPE_IDENTITY();
END;
GO
