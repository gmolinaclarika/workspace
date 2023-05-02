IF OBJECT_ID(N'dbo.DESKTOPFX$LOGOUT', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.DESKTOPFX$LOGOUT
GO

CREATE PROCEDURE dbo.DESKTOPFX$LOGOUT
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
    @LAST_DESKTOP       INTEGER,
    @LOGIN_STATE        VARBINARY(MAX)
AS
BEGIN
    DECLARE @LAST_POLL  DATETIME;
    DECLARE @USER_ID    BIGINT;

    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Compute last poll datetime
    IF (@LAST_DESKTOP = 0) BEGIN
        SET @LAST_POLL = GETDATE();
    END
    ELSE BEGIN    
        SET @LAST_POLL = DATEADD(minute, -5, GETDATE());
    END;

    -- Update last user poll date
    UPDATE dbo.DESKTOPFX_USER
    SET    LAST_POLL = @LAST_POLL,
           @USER_ID  = ID
    WHERE  USER_CODE = @WSS_USER_CODE;

    -- Update login state if not null
    IF (@USER_ID IS NOT NULL) BEGIN
        IF (@LOGIN_STATE IS NOT NULL) BEGIN
            UPDATE dbo.DESKTOPFX_LOGIN
            SET    LOGIN_STATE = @LOGIN_STATE
            WHERE  USER_ID = @USER_ID
            AND    PROFILE_CODE = @WSS_PROFILE_CODE;
        END;
    END;
END;
GO
