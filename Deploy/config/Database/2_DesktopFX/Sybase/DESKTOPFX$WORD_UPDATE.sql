IF EXISTS(SELECT * FROM sysobjects WHERE name = 'desktopfx$word_update' AND type = 'P')
    DROP PROCEDURE desktopfx$word_update
GO

CREATE PROCEDURE desktopfx$word_update
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
    -- Set No Count
    SET NOCOUNT ON

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
           PSW_VIG_DESD    = CONVERT(DECIMAL(8), @VALID_FROM)
    WHERE  USU_CODIGO = @USER_CODE
END
GO

sp_procxmode desktopfx$word_update, "anymode"
GO
