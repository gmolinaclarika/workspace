CREATE OR REPLACE FUNCTION securityfx$domain_del (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _domain_name        IN  VARCHAR
) RETURNS void
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
    -- Normalize specified domain name
    _v_fam_familia := UPPER(RTRIM(_domain_name));
    IF (_v_fam_familia = 'GENERAL') THEN
        RAISE EXCEPTION 'No se puede borrar el dominio %s', _v_fam_familia;
    END IF;

    -- Check the domain is not assigned to a user
    IF EXISTS(SELECT * FROM ecuaccusu WHERE familia = _v_fam_familia) THEN
        RAISE EXCEPTION 'Dominio %s está asignado a uno o más usuarios', _v_fam_familia;
    END IF;

    -- Check the domain is not assigned to a profile
    IF EXISTS(SELECT * FROM ecuaccper WHERE v_acc_familia = _v_fam_familia) THEN
        RAISE EXCEPTION 'Dominio %s está asignado a uno o más perfiles', _v_fam_familia;
    END IF;

    -- Check the domain is not assigned to a terminal
    IF EXISTS(SELECT * FROM ecuaccnet WHERE v_net_familia = _v_fam_familia) THEN
        RAISE EXCEPTION 'Dominio %s está asignado a uno o más terminales', _v_fam_familia;
    END IF;

    -- Delete the properties of specified domain
    DELETE FROM ecuaccfam
    WHERE  v_fam_familia = _v_fam_familia;

    -- Generate an audit record
    PERFORM securityfx$audit_put(
        _wss_user_code, _wss_profile_code, _wss_station_code, 
        12, 'Familia fue eliminada: ' || _domain_name);
END;
$BODY$ LANGUAGE plpgsql;
