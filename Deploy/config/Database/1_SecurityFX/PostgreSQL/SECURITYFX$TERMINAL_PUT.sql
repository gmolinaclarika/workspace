CREATE OR REPLACE FUNCTION securityfx$terminal_put (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    -- General Properties ------------
    _terminal_name      IN  VARCHAR,
    _domain             IN  VARCHAR,
    _type               IN  VARCHAR,
    _group              IN  VARCHAR,
    _location           IN  VARCHAR,
    _function           IN  VARCHAR,
    _printer            IN  VARCHAR,
    _enabled            IN  VARCHAR,
    _text1              IN  VARCHAR,
    _text2              IN  VARCHAR,
    _text3              IN  VARCHAR,
    _text4              IN  VARCHAR,
    -- Advanced Properties -----------
    _masterkey1         IN  VARCHAR,
    _masterkey2         IN  VARCHAR,
    _key1_timestamp     IN  VARCHAR,
    _key2_timestamp     IN  VARCHAR,
    _serial             IN  VARCHAR,
    _ip_addr            IN  VARCHAR,
    _pri_poll           IN  VARCHAR,
    _bkp_poll           IN  VARCHAR,
    _circuit            IN  INTEGER,
    -- Output Properties -------------
    _created            OUT INTEGER
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
    -- Asume the terminal exists
    _created := 0;

    -- Normalize specified terminal name
    _v_net_nombre := UPPER(RTRIM(_terminal_name));

    -- Update the properties of specified terminal
    UPDATE ecuaccnet
    SET    v_net_familia        = COALESCE(_domain,''),
           v_net_tipo           = COALESCE(_type,''),
           v_net_grupo_dyn      = COALESCE(_group,''),
           v_net_ubicacion      = COALESCE(_location,''),
           v_net_nombre_usuario = COALESCE(_function,''),
           v_net_printer        = COALESCE(_printer,''),
           v_net_habilitado     = COALESCE(_enabled,''),
           v_net_texto1         = COALESCE(_text1,''),
           v_net_texto2         = COALESCE(_text2,''),
           v_net_texto3         = COALESCE(_text3,''),
           v_net_texto4         = COALESCE(_text4,''),
           -- Advanced Properties -----------
           v_net_masterkey1     = COALESCE(_masterkey1,''),
           v_net_masterkey2     = COALESCE(_masterkey2,''),
           v_net_hora_key1      = COALESCE(_key1_timestamp,''),
           v_net_hora_key2      = COALESCE(_key2_timestamp,''),
           v_net_serieterm      = COALESCE(_serial,''),
           v_net_direccion_ip   = COALESCE(_ip_addr,''),
           v_net_poll_primario  = COALESCE(_pri_poll,''),
           v_net_poll_backup    = COALESCE(_bkp_poll,''),
           v_net_circuito       = _circuit
    WHERE  v_net_nombre = _v_net_nombre;

    -- Create terminal if it didn't exist
    IF (NOT FOUND) THEN
        INSERT INTO ecuaccnet (
            -- General Properties ------------
             v_net_nombre
            ,v_net_familia
            ,v_net_tipo
            ,v_net_grupo_dyn
            ,v_net_ubicacion
            ,v_net_nombre_usuario
            ,v_net_printer
            ,v_net_habilitado
            ,v_net_texto1
            ,v_net_texto2
            ,v_net_texto3
            ,v_net_texto4
            -- Advanced Properties -----------
            ,v_net_masterkey1
            ,v_net_masterkey2
            ,v_net_hora_key1
            ,v_net_hora_key2
            ,v_net_serieterm
            ,v_net_direccion_ip
            ,v_net_poll_primario
            ,v_net_poll_backup
            ,v_net_circuito
        ) VALUES (
            -- General Properties ------------
             _v_net_nombre
            ,COALESCE(_domain,'')
            ,COALESCE(_type,'')
            ,COALESCE(_group,'')
            ,COALESCE(_location,'')
            ,COALESCE(_function,'')
            ,COALESCE(_printer,'')
            ,COALESCE(_enabled,'')
            ,COALESCE(_text1,'')
            ,COALESCE(_text2,'')
            ,COALESCE(_text3,'')
            ,COALESCE(_text4,'')
            -- Advanced Properties -----------
            ,COALESCE(_masterkey1,'')
            ,COALESCE(_masterkey2,'')
            ,COALESCE(_key1_timesTAMP,'')
            ,COALESCE(_key2_timesTAMP,'')
            ,COALESCE(_serial,'')
            ,COALESCE(_ip_addr,'')
            ,COALESCE(_pri_poll,'')
            ,COALESCE(_bkp_poll,'')
            ,_circuit
        );
        _created := 1;
    END IF;

    -- Generate an audit record
    IF (_created = 0) THEN
        PERFORM securityfx$audit_put(
            _wss_user_code, _wss_profile_code, _wss_station_code, 
            15, 'Terminal fue modificado: ' || _terminal_name);
    ELSE
        PERFORM securityfx$audit_put(
            _wss_user_code, _wss_profile_code, _wss_station_code, 
            13, 'Terminal fue creado: ' || _terminal_name);
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
