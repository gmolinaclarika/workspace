IF EXISTS(SELECT * FROM sysobjects WHERE name = 'desktopfx$login_profs' AND type = 'P')
    DROP PROCEDURE desktopfx$login_profs
GO

CREATE PROCEDURE desktopfx$login_profs
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
    @USER_WORD          NVARCHAR(200),
    @PROFILES_MAX       INTEGER
AS
BEGIN
    DECLARE @REAL_WORD  NVARCHAR(200)

    -- Set No Count
    SET NOCOUNT ON

    -- Obtain real user word
    SELECT @REAL_WORD  = RTRIM(PASSWORD)
    FROM   dbo.EcuACCUSU
    WHERE  USU_CODIGO = @WSS_USER_CODE
    IF (@@ROWCOUNT = 0) BEGIN
        RAISERROR 99999, 'Usuario especificado no existe'
        RETURN
    END

    -- Check that real word matches supplied user word
    IF (@USER_WORD != @REAL_WORD) BEGIN
        RAISERROR 99999, 'El usuario y/o la contraseña son incorrectos'
        RETURN
    END

    -- #ResultSet PROFILE PROFILES
    --   #Column  PROFILE_CODE INTEGER
    --   #Column  PROFILE_NAME NVARCHAR
    -- #EndResultSet
    SELECT --TOP(@PROFILES_MAX)
           P.V_ACC_CODE_NUM     AS PROFILE_CODE,
           RTRIM(P.V_ACC_NAME)  AS PROFILE_NAME
    FROM  dbo.EcuACCPER P, dbo.EcuACCU2P X
    WHERE P.V_ACC_CODE_NUM = X.CODIGO_ECU
    AND   X.CODIGO_ADI = @WSS_USER_CODE
    ORDER BY P.V_ACC_CODE_NUM ASC
END
GO

sp_procxmode desktopfx$login_profs, "anymode"
GO
