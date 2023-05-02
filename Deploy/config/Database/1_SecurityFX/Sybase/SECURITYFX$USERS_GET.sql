IF EXISTS(SELECT * FROM sysobjects WHERE name = 'securityfx$users_get' AND type = 'P')
    DROP PROCEDURE securityfx$users_get
GO

CREATE PROCEDURE securityfx$users_get
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
    @USER_CODE          NVARCHAR(100),
    @USERS_MAX          INTEGER
AS
BEGIN
    -- Set No Count
    SET NOCOUNT ON

    -- #ResultSet USER USERS
    --    #Column CODE          NVARCHAR
    --    #Column GIVEN_NAMES   NVARCHAR
    --    #Column FATHER_NAME   NVARCHAR
    --    #Column MOTHER_NAME   NVARCHAR
    --    #Column DOMAIN        NVARCHAR
    --    #Column STATE         NVARCHAR
    -- #EndResultSet
    SELECT --TOP(@USERS_MAX)
           RTRIM(USU_CODIGO)    AS CODE,
           RTRIM(NOMBRES)       AS GIVEN_NAMES,
           RTRIM(APELLIDO_PAT)  AS FATHER_NAME,
           RTRIM(APELLIDO_MAT)  AS MOTHER_NAME,
           RTRIM(FAMILIA)       AS DOMAIN,
           RTRIM(USU_ESTADO)    AS STATE
    FROM  dbo.EcuACCUSU
    WHERE USU_CODIGO LIKE @USER_CODE + '%'
    ORDER BY USU_CODIGO ASC
END
GO

sp_procxmode securityfx$users_get, "anymode"
GO
