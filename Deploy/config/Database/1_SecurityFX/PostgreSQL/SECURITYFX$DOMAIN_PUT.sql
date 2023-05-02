CREATE OR REPLACE FUNCTION securityfx$domain_put (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _domain_name        IN  VARCHAR,
    _function           IN  VARCHAR,
    _location           IN  VARCHAR,
    _text1              IN  VARCHAR,
    _text2              IN  VARCHAR,
    _text3              IN  VARCHAR,
    _text4              IN  VARCHAR,
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
    _v_fam_familia      ecuaccfam.v_fam_familia%type;
BEGIN
    -- Asume the domain exists
    _created := 0;

    -- Normalize specified domain name
    _v_fam_familia := UPPER(RTRIM(_domain_name));

    -- Update the properties of specified domain
    UPDATE ecuaccfam
    SET    v_fam_nombre_usuario = COALESCE(_function,''),
           v_fam_ubicacion      = COALESCE(_location,''),
           v_fam_texto1         = COALESCE(_text1,''),
           v_fam_texto2         = COALESCE(_text2,''),
           v_fam_texto3         = COALESCE(_text3,''),
           v_fam_texto4         = COALESCE(_text4,'')
    WHERE  v_fam_familia = _v_fam_familia;

    -- Create domain if it didn't exist
    IF (NOT FOUND) THEN
        INSERT INTO ecuaccfam (
             v_fam_familia
            ,v_fam_nombre_usuario
            ,v_fam_ubicacion
            ,v_fam_texto1
            ,v_fam_texto2
            ,v_fam_texto3
            ,v_fam_texto4
        ) VALUES (
             _v_fam_familia
            ,COALESCE(_function,'')
            ,COALESCE(_location,'')
            ,COALESCE(_text1,'')
            ,COALESCE(_text2,'')
            ,COALESCE(_text3,'')
            ,COALESCE(_text4,'')
        );
        _created := 1;
    END IF;

    -- Generate an audit record
    IF (_created = 0) THEN
        PERFORM securityfx$audit_put(
            _wss_user_code, _wss_profile_code, _wss_station_code, 
            15, 'Familia fue modificada: ' || _domain_name);
    ELSE
        PERFORM securityfx$audit_put(
            _wss_user_code, _wss_profile_code, _wss_station_code, 
            16, 'Familia fue creada: ' || _domain_name);
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
