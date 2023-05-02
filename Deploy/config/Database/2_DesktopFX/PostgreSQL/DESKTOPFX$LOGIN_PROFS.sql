CREATE OR REPLACE FUNCTION desktopfx$login_profs (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _user_word          IN  VARCHAR,
    _profiles_max       IN  INTEGER,
    _profiles           OUT REFCURSOR
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
BEGIN
    -- Obtain real user word
    SELECT password
    INTO   _real_word
    FROM   ecuaccusu
    WHERE  usu_codigo = _wss_user_code;
    IF (NOT FOUND) THEN
        RAISE EXCEPTION 'Usuario especificado no existe';
    END IF;

    -- Check that real word matches supplied user word
    IF (_user_word != _real_word) THEN
        RAISE EXCEPTION 'El usuario y/o la contraseña son incorrectos';
    END IF; 

    -- #ResultSet PROFILE PROFILES
    --   #Column  PROFILE_CODE INTEGER
    --   #Column  PROFILE_NAME VARCHAR
    -- #EndResultSet
    OPEN _profiles FOR
        SELECT p.v_acc_code_num     AS PROFILE_CODE, 
               RTRIM(p.v_acc_name)  AS PROFILE_NAME
        FROM   ecuaccper p, ecuaccu2p x
        WHERE  p.v_acc_code_num = x.codigo_ecu
        AND    x.codigo_adi = _wss_user_code
        ORDER  BY p.v_acc_code_num ASC
        LIMIT  _profiles_max;
END;
$BODY$ LANGUAGE plpgsql;
