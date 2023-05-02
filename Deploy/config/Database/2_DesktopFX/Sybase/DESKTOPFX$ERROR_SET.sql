IF EXISTS(SELECT * FROM sysobjects WHERE name = 'desktopfx$error_set' AND type = 'P')
    DROP PROCEDURE desktopfx$error_set
GO

CREATE PROCEDURE desktopfx$error_set
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
    @ERROR_COUNT    INTEGER,
    @ERROR_DATE     NVARCHAR(200)
AS
BEGIN
    -- Set No Count
    SET NOCOUNT ON

    -- Update user error info
    UPDATE dbo.EcuACCUSU
    SET    ERROR_LOGIN = @ERROR_COUNT,
           FEC_ERR_LOG = @ERROR_DATE
    WHERE  USU_CODIGO = @USER_CODE
END
GO

sp_procxmode desktopfx$error_set, "anymode"
GO
