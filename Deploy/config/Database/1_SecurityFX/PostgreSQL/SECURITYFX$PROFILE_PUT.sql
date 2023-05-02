CREATE OR REPLACE FUNCTION securityfx$profile_put (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _profile_code       IN  INTEGER,
    _name               IN  VARCHAR,
    _flags              IN  VARCHAR,
    _menu               IN  VARCHAR,
    _domain             IN  VARCHAR,
    -- Privilege Properties
    _priv_menu          IN  VARCHAR,
    _priv_varl          IN  VARCHAR,
    _priv_varm          IN  VARCHAR,
    _priv_regl          IN  VARCHAR,
    _priv_regm          IN  VARCHAR,
    -- Restriction Properties
    _expires            IN  INTEGER,
    _hour_from          IN  DECIMAL,
    _hour_to            IN  DECIMAL,
    _pwd_days           IN  INTEGER,
    -- Terminal Properties
    _term_count         IN  INTEGER,
    _terminal01         IN  VARCHAR,
    _terminal02         IN  VARCHAR,
    _terminal03         IN  VARCHAR,
    _terminal04         IN  VARCHAR,
    _terminal05         IN  VARCHAR,
    _terminal06         IN  VARCHAR,
    _terminal07         IN  VARCHAR,
    _terminal08         IN  VARCHAR,
    _terminal09         IN  VARCHAR,
    _terminal10         IN  VARCHAR,
    _terminal11         IN  VARCHAR,
    _terminal12         IN  VARCHAR,
    _terminal13         IN  VARCHAR,
    _terminal14         IN  VARCHAR,
    _terminal15         IN  VARCHAR,
    _terminal16         IN  VARCHAR,
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
BEGIN
    -- Asume the profile exists
    _created := 0;

    -- Update the properties of specified profile
    UPDATE ecuaccper
    SET    v_acc_name           = COALESCE(_name,''),
           v_acc_indicadores    = COALESCE(_flags,''),
           v_acc_prog_ini       = COALESCE(_menu,''),
           v_acc_familia        = COALESCE(_domain,''),
           -- Privilege Properties
           v_acc_priv_men       = COALESCE(_priv_menu,''),
           v_acc_priv_varl      = COALESCE(_priv_varl,''),
           v_acc_priv_varm      = COALESCE(_priv_varm,''),
           v_acc_priv_regl      = COALESCE(_priv_regl,''),
           v_acc_priv_regm      = COALESCE(_priv_regm,''),
           -- Restriction Properties
           v_acc_exp            = _expires,
           v_acc_hora_inic      = _hour_from,
           v_acc_hora_fin       = _hour_to,
           v_acc_dias_vig_passw = _pwd_days,
           -- Terminal Properties
           v_acc_cant_term      = _term_count,
           v_acc_term_001       = COALESCE(_terminal01,''),
           v_acc_term_002       = COALESCE(_terminal02,''),
           v_acc_term_003       = COALESCE(_terminal03,''),
           v_acc_term_004       = COALESCE(_terminal04,''),
           v_acc_term_005       = COALESCE(_terminal05,''),
           v_acc_term_006       = COALESCE(_terminal06,''),
           v_acc_term_007       = COALESCE(_terminal07,''),
           v_acc_term_008       = COALESCE(_terminal08,''),
           v_acc_term_009       = COALESCE(_terminal09,''),
           v_acc_term_010       = COALESCE(_terminal10,''),
           v_acc_term_011       = COALESCE(_terminal11,''),
           v_acc_term_012       = COALESCE(_terminal12,''),
           v_acc_term_013       = COALESCE(_terminal13,''),
           v_acc_term_014       = COALESCE(_terminal14,''),
           v_acc_term_015       = COALESCE(_terminal15,''),
           v_acc_term_016       = COALESCE(_terminal16,'')
    WHERE  v_acc_code_num = _profile_code;

    -- Create profile if it didn't exist
    IF (NOT FOUND) THEN
        INSERT INTO ecuaccper (
             v_acc_code_num
            ,v_acc_name
            ,v_acc_indicadores
            ,v_acc_prog_ini
            ,v_acc_familia
            -- Privilege Properties
            ,v_acc_priv_men
            ,v_acc_priv_varl
            ,v_acc_priv_varm
            ,v_acc_priv_regl
            ,v_acc_priv_regm
            -- Restriction Properties
            ,v_acc_exp
            ,v_acc_hora_inic
            ,v_acc_hora_fin
            ,v_acc_dias_vig_passw
            -- Terminal Properties
            ,v_acc_cant_term
            ,v_acc_term_001
            ,v_acc_term_002
            ,v_acc_term_003
            ,v_acc_term_004
            ,v_acc_term_005
            ,v_acc_term_006
            ,v_acc_term_007
            ,v_acc_term_008
            ,v_acc_term_009
            ,v_acc_term_010
            ,v_acc_term_011
            ,v_acc_term_012
            ,v_acc_term_013
            ,v_acc_term_014
            ,v_acc_term_015
            ,v_acc_term_016
        ) VALUES (
             _profile_code
            ,COALESCE(_name,'')
            ,COALESCE(_flags,'')
            ,COALESCE(_menu,'')
            ,COALESCE(_domain,'')
            -- Privilege Properties
            ,COALESCE(_priv_menu,'')
            ,COALESCE(_priv_varl,'')
            ,COALESCE(_priv_varm,'')
            ,COALESCE(_priv_regl,'')
            ,COALESCE(_priv_regm,'')
            -- Restriction Properties
            ,_expires
            ,_hour_from
            ,_hour_to
            ,_pwd_days
            -- Terminal Properties
            ,_term_count
            ,COALESCE(_terminal01,'')
            ,COALESCE(_terminal02,'')
            ,COALESCE(_terminal03,'')
            ,COALESCE(_terminal04,'')
            ,COALESCE(_terminal05,'')
            ,COALESCE(_terminal06,'')
            ,COALESCE(_terminal07,'')
            ,COALESCE(_terminal08,'')
            ,COALESCE(_terminal09,'')
            ,COALESCE(_terminal10,'')
            ,COALESCE(_terminal11,'')
            ,COALESCE(_terminal12,'')
            ,COALESCE(_terminal13,'')
            ,COALESCE(_terminal14,'')
            ,COALESCE(_terminal15,'')
            ,COALESCE(_terminal16,'')
        );
        _created := 1;
    END IF;

    -- Generate an audit record
    IF (_created = 0) THEN
        PERFORM securityfx$audit_put(
            _wss_user_code, _wss_profile_code, _wss_station_code,
            56, 'Perfil fue modificado: ' || _profile_code);
    ELSE
        PERFORM securityfx$audit_put(
            _wss_user_code, _wss_profile_code, _wss_station_code,
            55, 'Perfil fue creado: ' || _profile_code);
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
