CREATE OR REPLACE FUNCTION securityfx$terminal_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _terminal_name      IN  VARCHAR,
    -- General Properties ------------
    _name               OUT VARCHAR,
    _domain             OUT VARCHAR,
    _type               OUT VARCHAR,
    _group              OUT VARCHAR,
    _location           OUT VARCHAR,
    _function           OUT VARCHAR,
    _printer            OUT VARCHAR,
    _enabled            OUT VARCHAR,
    _text1              OUT VARCHAR,
    _text2              OUT VARCHAR,
    _text3              OUT VARCHAR,
    _text4              OUT VARCHAR,
    -- Advanced Properties -----------
    _masterkey1         OUT VARCHAR,
    _masterkey2         OUT VARCHAR,
    _key1_timestamp     OUT VARCHAR,
    _key2_timestamp     OUT VARCHAR,
    _serial             OUT VARCHAR,
    _ip_addr            OUT VARCHAR,
    _pri_poll           OUT VARCHAR,
    _bkp_poll           OUT VARCHAR,
    _circuit            OUT INTEGER
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
DECLARE
    _v_net_nombre       ecuaccnet.v_net_nombre%type;
BEGIN
    -- Normalize specified terminal name
    _v_net_nombre := UPPER(RTRIM(_terminal_name));

    -- Returns the properties of the terminal
    SELECT 
        -- General Properties ------------
        RTRIM(v_net_nombre),
        RTRIM(v_net_familia),
        RTRIM(v_net_tipo),
        RTRIM(v_net_grupo_dyn),
        RTRIM(v_net_ubicacion),
        RTRIM(v_net_nombre_usuario),
        RTRIM(v_net_printer),
        RTRIM(v_net_habilitado),
        RTRIM(v_net_texto1),
        RTRIM(v_net_texto2),
        RTRIM(v_net_texto3),
        RTRIM(v_net_texto4),
        -- Advanced Properties -----------
        RTRIM(v_net_masterkey1),
        RTRIM(v_net_masterkey2),
        RTRIM(v_net_hora_key1),
        RTRIM(v_net_hora_key2),
        RTRIM(v_net_serieterm),
        RTRIM(v_net_direccion_ip),
        RTRIM(v_net_poll_primario),
        RTRIM(v_net_poll_backup),
        v_net_circuito
    INTO   
        -- General Properties ------------
        _name,
        _domain,
        _type,
        _group,
        _location,
        _function,
        _printer,
        _enabled,
        _text1,
        _text2,
        _text3,
        _text4,
        -- Advanced Properties -----------
        _masterkey1,
        _masterkey2,
        _key1_timestamp,
        _key2_timestamp,
        _serial,
        _ip_addr,
        _pri_poll,
        _bkp_poll,
        _circuit
    FROM   ecuaccnet
    WHERE  v_net_nombre = _v_net_nombre;
    IF (NOT FOUND) THEN
        RAISE EXCEPTION 'Terminal no está definido: %s', _terminal_name;
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
