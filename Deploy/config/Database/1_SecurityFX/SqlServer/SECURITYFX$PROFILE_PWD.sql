IF OBJECT_ID(N'dbo.SECURITYFX$PROFILE_PWD', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.SECURITYFX$PROFILE_PWD
GO

CREATE PROCEDURE dbo.SECURITYFX$PROFILE_PWD
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
    @PROFILE_CODE       INTEGER,
    @PROFILE_WORD       DECIMAL(18)
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- Update the password of the Profile
    UPDATE dbo.EcuACCPER
    SET    V_ACC_OTRAS_PASSW_006 = V_ACC_OTRAS_PASSW_005,
           V_ACC_OTRAS_PASSW_005 = V_ACC_OTRAS_PASSW_004,
           V_ACC_OTRAS_PASSW_004 = V_ACC_OTRAS_PASSW_003,
           V_ACC_OTRAS_PASSW_003 = V_ACC_OTRAS_PASSW_002,
           V_ACC_OTRAS_PASSW_002 = V_ACC_OTRAS_PASSW_001,
           V_ACC_OTRAS_PASSW_001 = V_ACC_PASSWORD,
           V_ACC_PASSWORD        = @PROFILE_WORD
    WHERE  V_ACC_CODE_NUM = @PROFILE_CODE;
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR('Perfil no está definido: %d', 16, 1, @PROFILE_CODE);
        RETURN;
    END;
END
GO
