IF OBJECT_ID(N'dbo.DESKTOPFX$EMAIL_SET', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.DESKTOPFX$EMAIL_SET
GO

CREATE PROCEDURE dbo.DESKTOPFX$EMAIL_SET
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @USER_CODE          NVARCHAR(200),
    @EMAIL_ADDR         NVARCHAR(200),
    @UPDATED            INTEGER         OUTPUT
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Update user email info
    UPDATE dbo.EcuACCUSU 
    SET    EMAIL = @EMAIL_ADDR
    WHERE  USU_CODIGO = @USER_CODE
    AND    USU_ESTADO = 'HA'
    AND    PSW_TIPO IN ('CAD', 'NCA');

    -- Return TRUE if update successful
    IF (@@ROWCOUNT = 1) BEGIN
        SET @UPDATED = 1;
    END
    ELSE BEGIN
        SET @UPDATED = 0;
    END;
END;
GO
