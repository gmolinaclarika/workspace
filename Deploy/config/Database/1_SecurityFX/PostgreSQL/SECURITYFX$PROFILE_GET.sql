CREATE OR REPLACE FUNCTION securityfx$profile_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _profile_code       IN  INTEGER,
    -- General Properties
    _code               OUT INTEGER,
    _name               OUT VARCHAR,
    _flags              OUT VARCHAR,
    _menu               OUT VARCHAR,
    _domain             OUT VARCHAR,
    -- Privilege Properties
    _priv_menu          OUT VARCHAR,
    _priv_varl          OUT VARCHAR,
    _priv_varm          OUT VARCHAR,
    _priv_regl          OUT VARCHAR,
    _priv_regm          OUT VARCHAR,
    -- Restriction Properties
    _expires            OUT INTEGER,
    _hour_from          OUT DECIMAL,
    _hour_to            OUT DECIMAL,
    _pwd_days           OUT INTEGER,
    -- Terminal Properties
    _terminal01         OUT VARCHAR,
    _terminal02         OUT VARCHAR,
    _terminal03         OUT VARCHAR,
    _terminal04         OUT VARCHAR,
    _terminal05         OUT VARCHAR,
    _terminal06         OUT VARCHAR,
    _terminal07         OUT VARCHAR,
    _terminal08         OUT VARCHAR,
    _terminal09         OUT VARCHAR,
    _terminal10         OUT VARCHAR,
    _terminal11         OUT VARCHAR,
    _terminal12         OUT VARCHAR,
    _terminal13         OUT VARCHAR,
    _terminal14         OUT VARCHAR,
    _terminal15         OUT VARCHAR,
    _terminal16         OUT VARCHAR,
    -- Profile Capacities
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
BEGIN
    SELECT 
        -- General Properties
        v_acc_code_num,
        RTRIM(v_acc_name),
        RTRIM(v_acc_indicadores),
        RTRIM(v_acc_prog_ini),
        RTRIM(v_acc_familia),
        -- Privilege Properties
        RTRIM(v_acc_priv_men),
        RTRIM(v_acc_priv_varl),
        RTRIM(v_acc_priv_varm),
        RTRIM(v_acc_priv_regl),
        RTRIM(v_acc_priv_regm),
        -- Restriction Properties
        v_acc_exp,
        v_acc_hora_inic,
        v_acc_hora_fin,
        v_acc_dias_vig_passw,
        -- Terminal Properties
        RTRIM(v_acc_term_001),
        RTRIM(v_acc_term_002),
        RTRIM(v_acc_term_003),
        RTRIM(v_acc_term_004),
        RTRIM(v_acc_term_005),
        RTRIM(v_acc_term_006),
        RTRIM(v_acc_term_007),
        RTRIM(v_acc_term_008),
        RTRIM(v_acc_term_009),
        RTRIM(v_acc_term_010),
        RTRIM(v_acc_term_011),
        RTRIM(v_acc_term_012),
        RTRIM(v_acc_term_013),
        RTRIM(v_acc_term_014),
        RTRIM(v_acc_term_015),
        RTRIM(v_acc_term_016)
    INTO
        -- General Properties
        _code,
        _name,
        _flags,
        _menu,
        _domain,
        -- Privilege Properties
        _priv_menu,
        _priv_varl,
        _priv_varm,
        _priv_regl,
        _priv_regm,
        -- Restriction Properties
        _expires,
        _hour_from,
        _hour_to,
        _pwd_days,
        -- Terminal Properties
        _terminal01,
        _terminal02,
        _terminal03,
        _terminal04,
        _terminal05,
        _terminal06,
        _terminal07,
        _terminal08,
        _terminal09,
        _terminal10,
        _terminal11,
        _terminal12,
        _terminal13,
        _terminal14,
        _terminal15,
        _terminal16
    FROM   ecuaccper
    WHERE  v_acc_code_num = _profile_code;
    IF (NOT FOUND) THEN
        RAISE EXCEPTION 'Perfil no está definido: %s', _profile_code;
    END IF;

    -- #ResultSet CAPACITY CAPACITIES
    --   #Column  CODE      VARCHAR
    --   #Column  VALUE     VARCHAR
    -- #EndResultSet
    OPEN _capacities FOR
        SELECT RTRIM(cap_codigo)    AS CODE, 
               RTRIM(cap_valor)     AS VALUE
        FROM  ecuaccc2p
        WHERE codigo_ecu = _profile_code
        ORDER BY cap_codigo;
END;
$BODY$ LANGUAGE plpgsql;
