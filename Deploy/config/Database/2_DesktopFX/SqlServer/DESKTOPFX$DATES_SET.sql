IF OBJECT_ID(N'dbo.DESKTOPFX$DATES_SET', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.DESKTOPFX$DATES_SET
GO

CREATE PROCEDURE dbo.DESKTOPFX$DATES_SET
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @USER_CODE      NVARCHAR(200),
    @FIRST_DATE     NVARCHAR(200),
    @LAST_DATE      NVARCHAR(200)
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Update user login date info
    UPDATE dbo.EcuACCUSU 
    SET    FEC_PRI_LOG = @FIRST_DATE, 
           FEC_ULT_LOG = @LAST_DATE 
    WHERE  USU_CODIGO = @USER_CODE;
END;
GO
