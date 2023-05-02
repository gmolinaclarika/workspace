CREATE OR REPLACE FUNCTION securityfx$user_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _user_code          IN  VARCHAR,
    -- General Properties
    _code               OUT VARCHAR,
    _given_names        OUT VARCHAR,
    _father_name        OUT VARCHAR,
    _mother_name        OUT VARCHAR,
    _position           OUT VARCHAR,
    _user_rut           OUT VARCHAR,
    _domain             OUT VARCHAR,
    _user_state         OUT VARCHAR,
    _valid_from         OUT INTEGER,
    _valid_to           OUT INTEGER,
    -- Contact Properties
    _address            OUT VARCHAR,
    _county             OUT VARCHAR,
    _city               OUT VARCHAR,
    _state              OUT VARCHAR,
    _country            OUT VARCHAR,
    _phone1             OUT VARCHAR,
    _phone2             OUT VARCHAR,
    _fax                OUT VARCHAR,
    _email              OUT VARCHAR,
    -- Authentication Properties
    _cert_id            OUT VARCHAR,
    _cert_state         OUT VARCHAR,
    _cert_reqst         OUT VARCHAR,
    _pwd_type           OUT VARCHAR,
    _pwd_days           OUT INTEGER,
    _pwd_state          OUT VARCHAR,
    -- Billing Properties
    _billing_type       OUT VARCHAR,
    _billing_code       OUT VARCHAR,
    _contract_code      OUT VARCHAR,
    _contract_annex     OUT VARCHAR,
    _company_rut        OUT VARCHAR,
    -- User Profiles And Capacities
    _profiles           OUT REFCURSOR,
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
    _usu_codigo         ecuaccusu.usu_codigo%type;
BEGIN
    -- Normalize specified user name
    _usu_codigo := UPPER(RTRIM(_user_code));

    -- Return the properties of specified user
    SELECT 
        -- General Properties
        RTRIM(usu_codigo),
        RTRIM(nombres),
        RTRIM(apellido_pat),
        RTRIM(apellido_mat),
        RTRIM(cargo),
        RTRIM(rut),
        RTRIM(familia),
        RTRIM(usu_estado),
        fec_vig_desd,
        fec_vig_hast,
        -- Contact Properties
        RTRIM(direccion),
        RTRIM(comuna),
        RTRIM(ciudad),
        RTRIM(estado),
        RTRIM(pais),
        RTRIM(fono1),
        RTRIM(fono2),
        RTRIM(fax),
        RTRIM(email),
        -- Authentication Properties
        RTRIM(certif_id),
        'NT',
        '',
        RTRIM(psw_tipo),
        psw_dias_caduc,
        RTRIM(psw_estado),
        -- Billing Properties
        RTRIM(facturacion),
        RTRIM(cod_facturacion),
        RTRIM(cod_contrato),
        RTRIM(anexo_contrato),
        RTRIM(rut_inst)
    INTO   
        -- General Properties
        _code,
        _given_names,
        _father_name,
        _mother_name,
        _position,
        _user_rut,
        _domain,
        _user_state,
        _valid_from,
        _valid_to,
        -- Contact Properties
        _address,
        _county,
        _city,
        _state,
        _country,
        _phone1,
        _phone2,
        _fax,
        _email,
        -- Authentication Properties
        _cert_id,
        _cert_state,
        _cert_reqst,
        _pwd_type,
        _pwd_days,
        _pwd_state,
        -- Billing Properties
        _billing_type,
        _billing_code,
        _contract_code,
        _contract_annex,
        _company_rut
    FROM   ecuaccusu
    WHERE  usu_codigo = _usu_codigo;
    IF (NOT FOUND) THEN
        RAISE EXCEPTION 'Usuario no está definido: %s', _user_code;
    END IF;

    -- #ResultSet PROFILE PROFILES
    --   #Column  CODE      INTEGER
    --   #Column  NAME      VARCHAR
    -- #EndResultSet
    OPEN _profiles FOR
        SELECT p.v_acc_code_num     AS CODE, 
               RTRIM(p.v_acc_name)  AS NAME
        FROM   ecuaccper p, ecuaccu2p x
        WHERE  p.v_acc_code_num = x.codigo_ecu
        AND    x.codigo_adi = _usu_codigo
        ORDER  BY p.v_acc_code_num;

    -- #ResultSet CAPACITY CAPACITIES
    --   #Column  CODE      VARCHAR
    --   #Column  VALUE     VARCHAR
    -- #EndResultSet
    OPEN _capacities FOR
        SELECT RTRIM(cap_codigo)    AS CODE, 
               RTRIM(cap_valor)     AS VALUE
        FROM  ecuaccc2u
        WHERE codigo_adi = _usu_codigo
        ORDER BY cap_codigo;
END;
$BODY$ LANGUAGE plpgsql;
