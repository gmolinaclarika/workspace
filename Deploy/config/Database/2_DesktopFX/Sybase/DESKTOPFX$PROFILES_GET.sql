IF EXISTS(SELECT * FROM sysobjects WHERE name = 'desktopfx$profiles_get' AND type = 'P')
    DROP PROCEDURE desktopfx$profiles_get
GO

CREATE PROCEDURE desktopfx$profiles_get
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @USER_CODE      NVARCHAR(200)
AS
BEGIN
    -- Set No Count
    SET NOCOUNT ON

    -- #ResultSet PROFILE PROFILES
    --   #Column  PROFILE_CODE  INTEGER
    -- #EndResultSet
    SELECT CODIGO_ECU AS PROFILE_CODE
    FROM   dbo.EcuACCU2P
    WHERE  CODIGO_ADI = @USER_CODE
END
GO

sp_procxmode desktopfx$profiles_get, "anymode"
GO
