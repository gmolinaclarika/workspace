IF OBJECT_ID(N'dbo.SECURITYFX$WORD_GET', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.SECURITYFX$WORD_GET
GO

CREATE PROCEDURE dbo.SECURITYFX$WORD_GET
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @USER_CODE      NVARCHAR(100),
    @PROFILE_CODE   INTEGER,
    @STATION_CODE   NVARCHAR(100),
    @USER_WORD      NVARCHAR(100) OUT
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Obtain the user password
    SELECT @USER_WORD = PASSWORD
    FROM  dbo.EcuACCUSU
    WHERE USU_CODIGO = @USER_CODE;
END;
GO
