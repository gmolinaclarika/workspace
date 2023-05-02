IF EXISTS(SELECT * FROM sysobjects WHERE name = 'securityfx$capacities_get' AND type = 'P')
    DROP PROCEDURE securityfx$capacities_get
GO

CREATE PROCEDURE securityfx$capacities_get
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
    @CAPACITIES_MAX     INTEGER
AS
BEGIN
    -- #ResultSet CAPACITY CAPACITIES
    --    #Column CODE  NVARCHAR
    --    #Column NAME  NVARCHAR
    --    #Column TYPE  INTEGER
    -- #EndResultSet
    SELECT --TOP(@CAPACITIES_MAX)
           RTRIM(CAP_CODIGO)    AS CODE,
           RTRIM(CAP_NOMBRE)    AS NAME,
           CAP_TIPO             AS TYPE
    FROM  dbo.EcuACCCAP
    ORDER BY CAP_CODIGO
END
GO

sp_procxmode securityfx$capacities_get, "anymode"
GO
