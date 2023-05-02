IF OBJECT_ID(N'dbo.SECURITYFX$PROFILES_GET', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.SECURITYFX$PROFILES_GET
GO

CREATE PROCEDURE dbo.SECURITYFX$PROFILES_GET
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
    @PROFILES_MAX       INTEGER
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- #ResultSet PROFILE PROFILES
    --    #Column CODE      INTEGER
    --    #Column NAME      NVARCHAR
    --    #Column FLAGS     NVARCHAR
    --    #Column MENU      NVARCHAR
    --    #Column DOMAIN    NVARCHAR
    -- #EndResultSet
    SELECT TOP(@PROFILES_MAX)
           V_ACC_CODE_NUM               AS CODE,
           RTRIM(V_ACC_NAME)            AS NAME,
           RTRIM(V_ACC_INDICADORES)     AS FLAGS,
           RTRIM(V_ACC_PROG_INI)        AS MENU,
           RTRIM(V_ACC_FAMILIA)         AS DOMAIN
    FROM  dbo.EcuACCPER
    WHERE V_ACC_CODE_NUM >= @PROFILE_CODE
    ORDER BY V_ACC_CODE_NUM ASC;
END
GO
