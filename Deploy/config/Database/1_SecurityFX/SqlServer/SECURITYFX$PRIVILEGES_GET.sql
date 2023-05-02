IF OBJECT_ID(N'dbo.SECURITYFX$PRIVILEGES_GET', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.SECURITYFX$PRIVILEGES_GET
GO

CREATE PROCEDURE dbo.SECURITYFX$PRIVILEGES_GET
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
    @PRIVILEGES_MAX     INTEGER
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- #ResultSet PRIVILEGE PRIVILEGES
    --    #Column TYPE      NVARCHAR
    --    #Column INDEX     INTEGER
    --    #Column LABEL     NVARCHAR
    --    #Column CNAME     NVARCHAR
    --    #Column SNAME     NVARCHAR
    -- #EndResultSet
    SELECT TOP(@PRIVILEGES_MAX)
           RTRIM(V_PRV_TIPO)        AS TYPE,
           V_PRV_NUMERO             AS [INDEX],
           RTRIM(V_PRV_NOMBRE)      AS LABEL,
           RTRIM(V_PRV_CONST)       AS CNAME,
           RTRIM(V_PRV_SYSLOG)      AS SNAME
    FROM  dbo.EcuACCPRV
    ORDER BY V_PRV_TIPO, V_PRV_NUMERO ASC;
END
GO
