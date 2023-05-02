CREATE OR REPLACE FUNCTION desktopfx$login_check (
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
    _real_word          ecuaccusu.password%type;
    _user_state         ecuaccusu.usu_estado%type;
BEGIN
    -- Init outputs
    _office_type := 0;
    _menu_xml := NULL;
    _login_props := NULL;
    _global_props := NULL;
    _login_service := NULL;

    -- Obtain real user word
    SELECT password, RTRIM(usu_estado)
    INTO   _real_word, _user_state
    FROM   ecuaccusu
    WHERE  usu_codigo = _wss_user_code;
    IF (NOT FOUND) THEN
        RAISE EXCEPTION 'Usuario especificado no existe';
    END IF;

    -- Check that real word matches supplied user word
    IF (_user_word != _real_word) THEN
        RAISE EXCEPTION 'El usuario y/o la contraseña son incorrectos';
    END IF; 

    -- Check that the user is currently enabled
    IF (_user_state != 'HA') THEN
        RAISE EXCEPTION 'El usuario no esta habilitado';
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
    WHERE usu_codigo = _wss_user_code;
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

    -- #ResultSet @CAPACITY CAPACITIES
    --   #Column  CODE      VARCHAR
    --   #Column  NAME      VARCHAR
    --   #Column  TYPE      INTEGER
    --   #Column  VALUE     VARCHAR
    -- #EndResultSet
    OPEN _capacities FOR
        SELECT c.cap_codigo AS CODE, 
               c.cap_nombre AS NAME,
               c.cap_tipo   AS TYPE,
               u.cap_valor  AS VALUE
        FROM  ecuacccap c, ecuaccc2u u
        WHERE u.codigo_adi = _wss_user_code
        AND   c.cap_codigo = u.cap_codigo
        UNION
        SELECT c.cap_codigo AS CODE, 
               c.cap_nombre AS NAME,
               c.cap_tipo   AS TYPE,
               p.cap_valor  AS VALUE
        FROM  ecuacccap c, ecuaccc2p p
        WHERE p.codigo_ecu = _wss_profile_code
        AND   c.cap_codigo = p.cap_codigo
        AND   c.cap_codigo NOT IN (
                SELECT cap_codigo FROM ecuaccc2u 
                WHERE codigo_adi = _wss_user_code)
        ORDER BY CODE;
END;
$BODY$ LANGUAGE plpgsql;
