CREATE OR REPLACE FUNCTION securityfx$profile_pwd (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _profile_code       IN INTEGER,
    _profile_word       IN DECIMAL
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
BEGIN
    -- Update the password of the profile
    UPDATE ecuaccper
    SET    v_acc_otras_passw_006 = v_acc_otras_passw_005,
           v_acc_otras_passw_005 = v_acc_otras_passw_004,
           v_acc_otras_passw_004 = v_acc_otras_passw_003,
           v_acc_otras_passw_003 = v_acc_otras_passw_002,
           v_acc_otras_passw_002 = v_acc_otras_passw_001,
           v_acc_otras_passw_001 = v_acc_password,
           v_acc_password        = _profile_word
    WHERE  v_acc_code_num = _profile_code;
    IF (NOT FOUND) THEN
        RAISE EXCEPTION 'Perfil no está definido: %s', _profile_code;
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
