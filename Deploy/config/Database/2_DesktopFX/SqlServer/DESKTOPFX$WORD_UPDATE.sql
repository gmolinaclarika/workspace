IF OBJECT_ID(N'dbo.DESKTOPFX$WORD_UPDATE', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.DESKTOPFX$WORD_UPDATE
GO

CREATE PROCEDURE dbo.DESKTOPFX$WORD_UPDATE
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
    @USER_WORD      NVARCHAR(200),
    @USER_STATE     NVARCHAR(200),
    @VALID_FROM     NVARCHAR(200)
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Update user passwords info
    UPDATE dbo.EcuACCUSU 
    SET    PSW_ULTIMAS_006 = PSW_ULTIMAS_005,
           PSW_ULTIMAS_005 = PSW_ULTIMAS_004,
           PSW_ULTIMAS_004 = PSW_ULTIMAS_003,
           PSW_ULTIMAS_003 = PSW_ULTIMAS_002,
           PSW_ULTIMAS_002 = PSW_ULTIMAS_001,
           PSW_ULTIMAS_001 = PASSWORD,
           PASSWORD        = @USER_WORD,
           PSW_ESTADO      = @USER_STATE,
           PSW_VIG_DESD    = @VALID_FROM
    WHERE  USU_CODIGO = @USER_CODE;
END;
GO
