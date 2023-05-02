IF OBJECT_ID(N'dbo.DESKTOPFX$STATION_GET', N'P') IS NOT NULL 
    DROP PROCEDURE dbo.DESKTOPFX$STATION_GET
GO

CREATE PROCEDURE dbo.DESKTOPFX$STATION_GET
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
    @STATION_CODE   NVARCHAR(200)
AS
BEGIN
    -- No Count + Trx Rollback
    SET NOCOUNT, XACT_ABORT ON;

    -- #ResultSet STATION STATIONS
    --   #Column  NOMBRE                NVARCHAR
    --   #Column  FAMILIA               NVARCHAR
    --   #Column  SERIETERM             NVARCHAR
    --   #Column  DIRECCION_IP          NVARCHAR
    --   #Column  NOMBRE_USUARIO        NVARCHAR
    --   #Column  UBICACION             NVARCHAR
    --   #Column  TIPO                  NVARCHAR
    --   #Column  HABILITADO            NVARCHAR
    -- #EndResultSet
    SELECT RTRIM(V_NET_NOMBRE)          AS NOMBRE,
           RTRIM(V_NET_FAMILIA)         AS FAMILIA,
           RTRIM(V_NET_SERIETERM)       AS SERIETERM,
           RTRIM(V_NET_DIRECCION_IP)    AS DIRECCION_IP,
           RTRIM(V_NET_NOMBRE_USUARIO)  AS NOMBRE_USUARIO,
           RTRIM(V_NET_UBICACION)       AS UBICACION,
           RTRIM(V_NET_TIPO)            AS TIPO,
           RTRIM(V_NET_HABILITADO)      AS HABILITADO
    FROM   dbo.EcuACCNET 
    WHERE  V_NET_NOMBRE = @STATION_CODE;
END;
GO
