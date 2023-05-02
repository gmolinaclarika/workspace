CREATE OR REPLACE FUNCTION desktopfx$login (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _user_word          IN  VARCHAR,
    _serial_number      IN  VARCHAR,
    -- User properties
    _first_name         OUT VARCHAR,
    _father_name        OUT VARCHAR,
    _mother_name        OUT VARCHAR,
    _user_rut           OUT VARCHAR,
    _job_title          OUT VARCHAR,
    _valid_from         OUT INTEGER,
    _valid_to           OUT INTEGER,
    -- Contact properties
    _street             OUT VARCHAR,
    _commune            OUT VARCHAR,
    _city               OUT VARCHAR,
    _region             OUT VARCHAR,
    _country            OUT VARCHAR,
    _email              OUT VARCHAR,
    _phone1             OUT VARCHAR,
    _phone2             OUT VARCHAR,
    _fax                OUT VARCHAR,
    -- Billing properties
    _user_realm         OUT VARCHAR,
    _company_rut        OUT VARCHAR,
    _billing_type       OUT VARCHAR,
    _billing_code       OUT VARCHAR,
    _contract_code      OUT VARCHAR,
    _contract_annex     OUT VARCHAR,
    -- Profile properties
    _profile_name       OUT VARCHAR,
    _profile_type       OUT INTEGER,
    _privileges         OUT VARCHAR,
    _profile_realm      OUT VARCHAR,
    _menu_name          OUT VARCHAR,
    _menu_xml           OUT BYTEA,
    _office_type        OUT INTEGER,
    -- Login properties
    _login_state        OUT BYTEA,
    _login_service      OUT BYTEA,
    _login_props        OUT BYTEA,
    _global_props       OUT BYTEA,
    -- Capacity properties
    _capacities         OUT REFCURSOR
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
    _is_anonymous       BOOLEAN;
    _user_id            desktopfx_user.id%type;
    _login_id           desktopfx_login.id%type;
    _temp_id            desktopfx_login.id%type;
    _real_word          ecuaccusu.password%type;
    _user_state         ecuaccusu.usu_estado%type;
    _usu_codigo         ecuaccusu.usu_codigo%type;
    _fec_pri_log        ecuaccusu.fec_pri_log%type;
    _fec_ult_log        ecuaccusu.fec_ult_log%type;
    _last_poll          desktopfx_user.last_poll%type;
    _service_name       desktopfx_user.service_name%type;
    _curr_station       desktopfx_user.station_code%type;
BEGIN
    -- Init dummy outputs
    _office_type := 0;

    -- Check for login of ANONYMOUS user
    IF (LEFT(_wss_user_code, 1) = '$') THEN
        _is_anonymous := TRUE;
        _usu_codigo := '_ANONYMOUS';
    ELSE
        _is_anonymous := FALSE;
        _usu_codigo := _wss_user_code;
    END IF;

    -- Obtain user word, state and first login date
    SELECT password, RTRIM(usu_estado), RTRIM(fec_pri_log)
    INTO   _real_word, _user_state, _fec_pri_log
    FROM   ecuaccusu
    WHERE  usu_codigo = _usu_codigo;
    IF (NOT FOUND) THEN
        RAISE EXCEPTION 'Usuario especificado no existe';
    END IF;

    -- Check that real word matches supplied user word
    IF (NOT _is_anonymous) AND (_user_word != _real_word) THEN
        RAISE EXCEPTION 'El usuario y/o la contraseña son incorrectos';
    END IF; 

    -- Check that the user is currently enabled
    IF (_user_state != 'HA') THEN
        RAISE EXCEPTION 'El usuario no está habilitado';
    END IF;

    -- Obtain user properties (if any)
    SELECT id, service_name, station_code, last_poll
    INTO   _user_id, _service_name, _curr_station, _last_poll
    FROM   desktopfx_user
    WHERE  user_code = _wss_user_code;
    IF (NOT FOUND) THEN
        _user_id := NULL;
    END IF;

    -- Update/create user properties and validate station
    IF (_user_id IS NULL) THEN
        _service_name := 'SERVICE';
        WITH inserted AS (
            INSERT INTO desktopfx_user
                (user_code, service_name, station_code, last_poll)
            VALUES
                (_wss_user_code, _service_name, _wss_station_code, NOW())
            RETURNING id) 
        SELECT id INTO _user_id FROM inserted;
    ELSIF (NOW() >= (_last_poll + INTERVAL '5 minutes')) THEN
        UPDATE desktopfx_user
        SET    station_code = _wss_station_code,
               last_poll = NOW()
        WHERE  id = _user_id;
    ELSIF (_curr_station = _wss_station_code) THEN
        UPDATE desktopfx_user
        SET    last_poll = NOW()
        WHERE  id = _user_id;
    ELSE
        RAISE EXCEPTION 'El usuario ya está login en la estación %s', _curr_station;
    END IF;

    -- Obtain user properties
    SELECT 
        -- User properties
        RTRIM(nombres), 
        RTRIM(apellido_pat), 
        RTRIM(apellido_mat),
        RTRIM(rut),
        RTRIM(cargo),
        fec_vig_desd,
        fec_vig_hast,
        -- Contact properties
        RTRIM(direccion),
        RTRIM(comuna),
        RTRIM(ciudad),
        RTRIM(estado),
        RTRIM(pais),
        RTRIM(email),
        RTRIM(fono1),
        RTRIM(fono2),
        RTRIM(fax),
        -- Billing properties
        RTRIM(familia),
        RTRIM(rut_inst),
        RTRIM(facturacion),
        RTRIM(cod_facturacion),
        RTRIM(cod_contrato),
        RTRIM(anexo_contrato)
    INTO   
        -- General properties
        _first_name, 
        _father_name, 
        _mother_name,
        _user_rut,
        _job_title,
        _valid_from,
        _valid_to,
        -- Contact properties
        _street,
        _commune,
        _city,
        _region,
        _country,
        _email,
        _phone1,
        _phone2,
        _fax,
        -- Billing properties
        _user_realm,
        _company_rut,
        _billing_type,
        _billing_code,
        _contract_code,
        _contract_annex
    FROM  ecuaccusu
    WHERE usu_codigo = _usu_codigo;
    IF (NOT FOUND) THEN
        RAISE EXCEPTION 'Usuario especificado no existe';
    END IF;

    -- Obtain profile properties
    SELECT RTRIM(v_acc_name), 
           ASCII(SUBSTR(v_acc_indicadores,2,1)), 
           v_acc_priv_men  ||
           v_acc_priv_varl ||
           v_acc_priv_varm ||
           v_acc_priv_regl ||
           v_acc_priv_regm,
           RTRIM(v_acc_familia),
           RTRIM(v_acc_prog_ini)
    INTO
           _profile_name,
           _profile_type,
           _privileges,
           _profile_realm,
           _menu_name
    FROM  ecuaccper
    WHERE v_acc_code_num = _wss_profile_code;
    IF (NOT FOUND) THEN
        RAISE EXCEPTION 'Perfil especificado no existe';
    END IF;

    -- Make sure user+proifle exist
    SELECT id, login_state
    INTO   _login_id, _login_state
    FROM   desktopfx_login
    WHERE  user_id = _user_id
    AND    profile_code = _wss_profile_code;
    IF (NOT FOUND) THEN
        WITH inserted AS (
            INSERT INTO desktopfx_login
                (user_id, profile_code)
            VALUES
                (_user_id, _wss_profile_code)
            RETURNING id) 
        SELECT id INTO _login_id FROM inserted;
    END IF;

    -- Make sure user+profile=-1 exists
    SELECT ID INTO _temp_id
    FROM   desktopfx_login
    WHERE  user_id = _user_id
    AND    profile_code = -1;
    IF (NOT FOUND) THEN
        INSERT INTO desktopfx_login
            (user_id, profile_code)
        VALUES
            (_user_id, -1);
    END IF;

    -- Return menu definition (DEFAULT if not defined)
    SELECT BYTES INTO _menu_xml
    FROM   desktopfx_object
    WHERE  login_id = 0
    AND    type = 4
    AND    name = _menu_name;
    IF (NOT FOUND) THEN
        _menu_name := 'DEFAULT';
        SELECT bytes INTO _menu_xml
        FROM   desktopfx_object
        WHERE  login_id = 0
        AND    type = 4
        AND    name = _menu_name;
        IF (NOT FOUND) THEN
            _menu_xml := NULL;
        END IF;
    END IF;

    -- Return service definition (NULL if not defined)
    SELECT bytes INTO _login_service
    FROM   desktopfx_object
    WHERE  login_id = 0
    AND    type = 5
    AND    name = _service_name;
    IF (NOT FOUND) THEN
        _login_service := NULL;
    END IF;

    -- Return login properties (NULL if not defined)
    SELECT bytes INTO _login_props
    FROM   desktopfx_object
    WHERE  login_id = _login_id
    AND    type = 1
    AND    name = 'LOGIN';
    IF (NOT FOUND) THEN
        _login_props := NULL;
    END IF;

    -- Return global properties (NULL if not defined)
    SELECT bytes INTO _global_props
    FROM   desktopfx_object
    WHERE  login_id = 0
    AND    type = 1
    AND    name = 'LOGIN';
    IF (NOT FOUND) THEN
        _global_props := NULL;
    END IF;

    -- #ResultSet @CAPACITY CAPACITIES
    --   #Column  CODE      VARCHAR
    --   #Column  NAME      VARCHAR
    --   #Column  TYPE      INTEGER
    --   #Column  VALUE     VARCHAR
    -- #EndResultSet
    OPEN _capacities FOR
        SELECT RTRIM(c.cap_codigo)  AS CODE, 
               RTRIM(c.cap_nombre)  AS NAME,
               c.cap_tipo           AS TYPE,
               RTRIM(u.cap_valor)   AS VALUE
        FROM  ecuacccap c, ecuaccc2u u
        WHERE u.codigo_adi = _usu_codigo
        AND   c.cap_codigo = u.cap_codigo
        UNION
        SELECT RTRIM(c.cap_codigo)  AS CODE, 
               RTRIM(c.cap_nombre)  AS NAME,
               c.cap_tipo           AS TYPE,
               RTRIM(p.cap_valor)   AS VALUE
        FROM  ecuacccap c, ecuaccc2p p
        WHERE p.codigo_ecu = _wss_profile_code
        AND   c.cap_codigo = p.cap_codigo
        AND   c.cap_codigo NOT IN (
                SELECT cap_codigo FROM ecuaccc2u 
                WHERE codigo_adi = _usu_codigo)
        ORDER BY CODE;

    -- Update last-login-time and (maybe) first-login-time
    _fec_ult_log := TO_CHAR(CURRENT_TIMESTAMP,'YYYY-MM-DD:HH24:MI:SS.US');
    IF (LENGTH(_fec_pri_log) > 0) THEN
        UPDATE ecuaccusu
        SET    fec_ult_log = _fec_ult_log
        WHERE  usu_codigo = _usu_codigo;
    ELSE
        UPDATE ecuaccusu
        SET    fec_ult_log = _fec_ult_log,
               fec_pri_log = _fec_ult_log
        WHERE  usu_codigo = _usu_codigo;
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
