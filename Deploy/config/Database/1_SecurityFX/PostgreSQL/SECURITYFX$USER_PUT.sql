CREATE OR REPLACE FUNCTION securityfx$user_put (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _user_code          IN  VARCHAR,
    -- General Properties
    _given_names        IN  VARCHAR,
    _father_name        IN  VARCHAR,
    _mother_name        IN  VARCHAR,
    _position           IN  VARCHAR,
    _user_rut           IN  VARCHAR,
    _domain             IN  VARCHAR,
    _user_state         IN  VARCHAR,
    _valid_from         IN  INTEGER,
    _valid_to           IN  INTEGER,
    -- Contact Properties
    _address            IN  VARCHAR,
    _county             IN  VARCHAR,
    _city               IN  VARCHAR,
    _state              IN  VARCHAR,
    _country            IN  VARCHAR,
    _phone1             IN  VARCHAR,
    _phone2             IN  VARCHAR,
    _fax                IN  VARCHAR,
    _email              IN  VARCHAR,
    -- Authentication Properties
    _cert_id            IN  VARCHAR,
    _cert_state         IN  VARCHAR,
    _cert_reqst         IN  VARCHAR,
    _pwd_type           IN  VARCHAR,
    _pwd_days           IN  INTEGER,
    _pwd_state          IN  VARCHAR,
    _pwd_text           IN  VARCHAR,
    -- Billing Properties
    _billing_type       IN  VARCHAR,
    _billing_code       IN  VARCHAR,
    _contract_code      IN  VARCHAR,
    _contract_annex     IN  VARCHAR,
    _company_rut        IN  VARCHAR,
    -- User Profiles
    _profiles           IN  VARCHAR,
    -- Output Parameters
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
    _index              INT;
    _profile_code       INTEGER;
    _profile_txt        VARCHAR;
    _usu_codigo         ecuaccusu.usu_codigo%type;
BEGIN
    -- Asume the user exists
    _created := 0;

    -- Normalize specified user name
    _usu_codigo := UPPER(RTRIM(_user_code));

    -- Update the properties of specified user
    UPDATE ecuaccusu
    SET    nombres          = COALESCE(_given_names,''),
           apellido_pat     = COALESCE(_father_name,''),
           apellido_mat     = COALESCE(_mother_name,''),
           cargo            = COALESCE(_position,''),
           rut              = COALESCE(_user_rut,''),
           familia          = COALESCE(_domain,''),
           usu_estado       = COALESCE(_user_state,''),
           fec_vig_desd     = _valid_from,
           fec_vig_hast     = _valid_to,
           -- Contact Properties
           direccion        = COALESCE(_address,''),
           comuna           = COALESCE(_county,''),
           ciudad           = COALESCE(_city,''),
           estado           = COALESCE(_state,''),
           pais             = COALESCE(_country,''),
           fono1            = COALESCE(_phone1,''),
           fono2            = COALESCE(_phone2,''),
           fax              = COALESCE(_fax,''),
           email            = COALESCE(_email,''),
           -- Authentication Properties
           certif_id        = COALESCE(_cert_id,''),
           psw_tipo         = COALESCE(_pwd_type,''),
           psw_dias_caduc   = _pwd_days,
           psw_estado       = COALESCE(_pwd_state,''),
           -- Billing Properties
           facturacion      = COALESCE(_billing_type,''),
           cod_facturacion  = COALESCE(_billing_code,''),
           cod_contrato     = COALESCE(_contract_code,''),
           anexo_contrato   = COALESCE(_contract_annex,''),
           rut_inst         = COALESCE(_company_rut,'')
    WHERE  usu_codigo = _usu_codigo;

    -- Create user if it didn't exist
    IF (NOT FOUND) THEN
        INSERT INTO ecuaccusu (
             usu_codigo
            -- General Properties
            ,nombres
            ,apellido_pat
            ,apellido_mat
            ,cargo
            ,rut
            ,familia
            ,usu_estado
            ,fec_vig_desd
            ,fec_vig_hast
            ,fec_cre_usu
            -- Contact Properties
            ,direccion
            ,comuna
            ,ciudad
            ,estado
            ,pais
            ,fono1
            ,fono2
            ,fax
            ,email
            -- Authentication Properties
            ,certif_id
            ,psw_tipo
            ,psw_dias_caduc
            ,psw_estado
            ,password
            -- Billing Properties
            ,facturacion
            ,cod_facturacion
            ,cod_contrato
            ,anexo_contrato
            ,rut_inst
        ) VALUES (
             _usu_codigo
            -- General Properties
            ,COALESCE(_given_names,'')
            ,COALESCE(_father_name,'')
            ,COALESCE(_mother_name,'')
            ,COALESCE(_position,'')
            ,COALESCE(_user_rut,'')
            ,COALESCE(_domain,'')
            ,COALESCE(_user_state,'')
            ,_valid_from
            ,_valid_to
            ,TO_CHAR(CURRENT_TIMESTAMP,'YYYY-MM-DD:HH24:MI:SS.US')
            -- Contact Properties
            ,COALESCE(_address,'')
            ,COALESCE(_county,'')
            ,COALESCE(_city,'')
            ,COALESCE(_state,'')
            ,COALESCE(_country,'')
            ,COALESCE(_phone1,'')
            ,COALESCE(_phone2,'')
            ,COALESCE(_fax,'')
            ,COALESCE(_email,'')
            -- Authentication Properties
            ,COALESCE(_cert_id,'')
            ,COALESCE(_pwd_type,'')
            ,_pwd_days
            ,COALESCE(_pwd_state,'')
            ,COALESCE(_pwd_text,'')
            -- Billing Properties
            ,COALESCE(_billing_type,'')
            ,COALESCE(_billing_code,'')
            ,COALESCE(_contract_code,'')
            ,COALESCE(_contract_annex,'')
            ,COALESCE(_company_rut,'')
        );
        _created := 1;
    END IF;

    -- Update the user password (if supplied)
    _pwd_text := COALESCE(_pwd_text,'');
    IF (LENGTH(_pwd_text) > 0) THEN
        UPDATE ecuaccusu
        SET    psw_ultimas_006 = psw_ultimas_005,
               psw_ultimas_005 = psw_ultimas_004,
               psw_ultimas_004 = psw_ultimas_003,
               psw_ultimas_003 = psw_ultimas_002,
               psw_ultimas_002 = psw_ultimas_001,
               psw_ultimas_001 = password,
               password        = _pwd_text,
               psw_estado      = 'EXP',
               psw_vig_desd    = 0
        WHERE  usu_codigo = _usu_codigo;
    END IF;

    -- Delete all profiles of the user
    DELETE FROM ecuaccu2p
    WHERE codigo_adi = _usu_codigo;

    -- Insert the supplied user profiles
    _profiles := RTRIM(_profiles);
    WHILE (LENGTH(_profiles) > 0) LOOP
        -- Locate "<LF>" of next "ProfileID<LF>"
        _index := STRPOS(_profiles, CHR(10));
        EXIT WHEN (_index = 0);

        -- Extract "ProfileCode" from list of profiles
        _profile_txt := SUBSTR(_profiles, 1, _index - 1);
        _profile_code := TO_NUMBER(_profile_txt, '9999999');
        _profiles := SUBSTR(_profiles, _index + 1);

        -- Verify that the profile code exists
        IF (NOT EXISTS(SELECT 1 FROM ecuaccper WHERE v_acc_code_num = _profile_code)) THEN
            RAISE EXCEPTION 'Perfil no está definido: %d', _profile_code;
        END IF;

        -- Assign a new profile to the user
        INSERT INTO ecuaccu2p
            (codigo_adi, codigo_ecu)
        VALUES 
            (_usu_codigo, _profile_code);
    END LOOP;

    -- Generate an audit record
    IF (_created = 0) THEN
        PERFORM securityfx$audit_put(
            _wss_user_code, _wss_profile_code, _wss_station_code, 
            15, 'Usuario fue modificado: ' || _user_code);
    ELSE
        PERFORM securityfx$audit_put(
            _wss_user_code, _wss_profile_code, _wss_station_code, 
            13, 'Usuario fue creado: ' || _user_code);
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
