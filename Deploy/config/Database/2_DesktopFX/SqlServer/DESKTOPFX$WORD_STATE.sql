IF OBJECT_ID(N'dbo.DESKTOPFX$WORD_STATE', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.DESKTOPFX$WORD_STATE
GO

CREATE PROCEDURE dbo.DESKTOPFX$WORD_STATE
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
    @PWD_STATE      NVARCHAR(200)
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Update user expiration info
    UPDATE dbo.EcuACCUSU
    SET    PSW_ESTADO = @PWD_STATE
    WHERE  USU_CODIGO = @USER_CODE;
END;
GO
