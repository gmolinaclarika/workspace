CREATE OR REPLACE FUNCTION securityfx$domain_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _domain_name        IN  VARCHAR,
    -- General Properties
    _name               OUT VARCHAR,
    _function           OUT VARCHAR,
    _location           OUT VARCHAR,
    _text1              OUT VARCHAR,
    _text2              OUT VARCHAR,
    _text3              OUT VARCHAR,
    _text4              OUT VARCHAR
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
    _v_fam_familia  ecuaccfam.v_fam_familia%type;
BEGIN
    -- Normalize specified domain name
    _v_fam_familia := UPPER(RTRIM(_domain_name));

    -- Returns the properties of the domain
    SELECT 
        -- General Properties
        RTRIM(v_fam_familia),
        RTRIM(v_fam_nombre_usuario),
        RTRIM(v_fam_ubicacion),
        RTRIM(v_fam_texto1),
        RTRIM(v_fam_texto2),
        RTRIM(v_fam_texto3),
        RTRIM(v_fam_texto4)
    INTO
        -- General Properties
        _name,
        _function,
        _location,
        _text1,
        _text2,
        _text3,
        _text4
    FROM   ecuaccfam
    WHERE  v_fam_familia = _v_fam_familia;
    IF (NOT FOUND) THEN
        RAISE EXCEPTION 'Dominio no está definido: %s', _domain_name;
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
