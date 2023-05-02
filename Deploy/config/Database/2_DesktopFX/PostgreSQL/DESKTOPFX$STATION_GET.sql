CREATE OR REPLACE FUNCTION desktopfx$station_get (
    _station_code       IN  VARCHAR,
    _stations           OUT REFCURSOR
)
AS $BODY$
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
BEGIN
    -- #ResultSet STATION STATIONS
    --   #Column  NOMBRE            VARCHAR
    --   #Column  FAMILIA           VARCHAR
    --   #Column  SERIETERM         VARCHAR
    --   #Column  DIRECCION_IP      VARCHAR
    --   #Column  NOMBRE_USUARIO    VARCHAR
    --   #Column  UBICACION         VARCHAR
    --   #Column  TIPO              VARCHAR
    --   #Column  HABILITADO        VARCHAR
    -- #EndResultSet
    OPEN _stations FOR
        SELECT RTRIM(v_net_nombre)          AS NOMBRE,
               RTRIM(v_net_familia)         AS FAMILIA,
               RTRIM(v_net_serieterm)       AS SERIETERM,
               RTRIM(v_net_direccion_ip)    AS DIRECCION_IP,
               RTRIM(v_net_nombre_usuario)  AS NOMBRE_USUARIO,
               RTRIM(v_net_ubicacion)       AS UBICACION,
               RTRIM(v_net_tipo)            AS TIPO,
               RTRIM(v_net_habilitado)      AS HABILITADO
        FROM   ecuaccnet 
        WHERE  v_net_nombre = _station_code;
END;
$BODY$ LANGUAGE plpgsql;
