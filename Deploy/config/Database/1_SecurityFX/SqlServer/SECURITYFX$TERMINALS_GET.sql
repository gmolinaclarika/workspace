IF OBJECT_ID(N'dbo.SECURITYFX$TERMINALS_GET', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.SECURITYFX$TERMINALS_GET
GO

CREATE PROCEDURE dbo.SECURITYFX$TERMINALS_GET
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
    @TERMINAL_NAME      NVARCHAR(100),
    @TERMINALS_MAX      INTEGER
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- #ResultSet TERMINAL TERMINALS
    --    #Column NAME      NVARCHAR
    --    #Column DOMAIN    NVARCHAR
    --    #Column TYPE      NVARCHAR
    --    #Column FUNCTION  NVARCHAR
    --    #Column LOCATION  NVARCHAR
    --    #Column STATE     NVARCHAR
    -- #EndResultSet
    SELECT TOP(@TERMINALS_MAX)
           RTRIM(V_NET_NOMBRE)          AS NAME,
           RTRIM(V_NET_FAMILIA)         AS DOMAIN,
           RTRIM(V_NET_TIPO)            AS TYPE,
           RTRIM(V_NET_NOMBRE_USUARIO)  AS [FUNCTION],
           RTRIM(V_NET_UBICACION)       AS LOCATION,
           RTRIM(V_NET_HABILITADO)      AS STATE
    FROM  dbo.EcuACCNET
    WHERE V_NET_NOMBRE LIKE @TERMINAL_NAME + '%'
    ORDER BY V_NET_NOMBRE ASC;
END
GO
