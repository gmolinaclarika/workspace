IF EXISTS(SELECT * FROM sysobjects WHERE name = 'securityfx$domains_get' AND type = 'P')
    DROP PROCEDURE securityfx$domains_get
GO

CREATE PROCEDURE securityfx$domains_get
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
    @DOMAIN_NAME        NVARCHAR(100),
    @DOMAINS_MAX        INTEGER
AS
BEGIN
    -- Set No Count
    SET NOCOUNT ON

    -- #ResultSet DOMAIN DOMAINS
    --    #Column NAME      NVARCHAR
    --    #Column FUNCTION  NVARCHAR
    --    #Column LOCATION  NVARCHAR
    -- #EndResultSet
    SELECT --TOP(@DOMAINS_MAX)
           RTRIM(V_FAM_FAMILIA)         AS NAME,
           RTRIM(V_FAM_NOMBRE_USUARIO)  AS [FUNCTION],
           RTRIM(V_FAM_UBICACION)       AS LOCATION
    FROM  dbo.EcuACCFAM
    WHERE V_FAM_FAMILIA LIKE @DOMAIN_NAME + '%'
    ORDER BY V_FAM_FAMILIA ASC
END
GO

sp_procxmode securityfx$domains_get, "anymode"
GO
