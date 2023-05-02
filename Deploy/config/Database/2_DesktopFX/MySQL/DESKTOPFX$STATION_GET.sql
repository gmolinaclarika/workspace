DROP PROCEDURE IF EXISTS DESKTOPFX$STATION_GET;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$STATION_GET (
-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------
    _STATION_CODE   VARCHAR(200)
)
BEGIN
    -- #ResultSet STATION STATIONS
    --   #Column  NOMBRE                VARCHAR
    --   #Column  FAMILIA               VARCHAR
    --   #Column  SERIETERM             VARCHAR
    --   #Column  DIRECCION_IP          VARCHAR
    --   #Column  NOMBRE_USUARIO        VARCHAR
    --   #Column  UBICACION             VARCHAR
    --   #Column  TIPO                  VARCHAR
    --   #Column  HABILITADO            VARCHAR
    -- #EndResultSet
    SELECT RTRIM(V_NET_NOMBRE)          AS NOMBRE,
           RTRIM(V_NET_FAMILIA)         AS FAMILIA,
           RTRIM(V_NET_SERIETERM)       AS SERIETERM,
           RTRIM(V_NET_DIRECCION_IP)    AS DIRECCION_IP,
           RTRIM(V_NET_NOMBRE_USUARIO)  AS NOMBRE_USUARIO,
           RTRIM(V_NET_UBICACION)       AS UBICACION,
           RTRIM(V_NET_TIPO)            AS TIPO,
           RTRIM(V_NET_HABILITADO)      AS HABILITADO
    FROM   EcuACCNET 
    WHERE  V_NET_NOMBRE = _STATION_CODE;
END$$
DELIMITER ;
