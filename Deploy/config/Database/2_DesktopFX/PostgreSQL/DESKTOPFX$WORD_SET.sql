CREATE OR REPLACE FUNCTION desktopfx$word_set (
    _user_code          IN  VARCHAR,
    _user_word          IN  VARCHAR,
    _updated            OUT INTEGER
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
    _password           ecuaccusu.password%type;
    _psw_ultimas_001    ecuaccusu.psw_ultimas_001%type;
    _psw_ultimas_002    ecuaccusu.psw_ultimas_002%type;
    _psw_ultimas_003    ecuaccusu.psw_ultimas_003%type;
    _psw_ultimas_004    ecuaccusu.psw_ultimas_004%type;
    _psw_ultimas_005    ecuaccusu.psw_ultimas_005%type;
    _psw_ultimas_006    ecuaccusu.psw_ultimas_006%type;
    _fec_vig_desd       ecuaccusu.fec_vig_desd%type;
    _fec_vig_hast       ecuaccusu.fec_vig_hast%type;
    _usu_estado         ecuaccusu.usu_estado%type;
    _psw_tipo           ecuaccusu.psw_tipo%type;
    _usu_codigo         ecuaccusu.usu_codigo%type;
    _yyyymmdd           ecuaccusu.fec_vig_desd%type;
BEGIN
    -- Normalize specified user name
    _usu_codigo := UPPER(RTRIM(_user_code));

    -- Obtain properties of specified user
    SELECT password,
           psw_ultimas_001,
           psw_ultimas_002,
           psw_ultimas_003,
           psw_ultimas_004,
           psw_ultimas_005,
           psw_ultimas_006,
           fec_vig_desd,
           fec_vig_hast,
           usu_estado,
           psw_tipo
    INTO   _password,
           _psw_ultimas_001,
           _psw_ultimas_002,
           _psw_ultimas_003,
           _psw_ultimas_004,
           _psw_ultimas_005,
           _psw_ultimas_006,
           _fec_vig_desd,
           _fec_vig_hast,
           _usu_estado,
           _psw_tipo
    FROM  ecuaccusu
    WHERE usu_codigo = _usu_codigo;
    IF (NOT FOUND) THEN
        RAISE EXCEPTION 'Usuario no está definido: %s', _user_code;
    END IF;

    -- Obtain current date in "YYYYMMDD" decimal format
    _yyyymmdd := CAST(TO_CHAR(CURRENT_TIMESTAMP, 'YYYYMMDD') AS DECIMAL);
 
    -- Check the user is working in valid date range
    IF (_yyyymmdd < _fec_vig_desd) OR (_yyyymmdd > _fec_vig_hast) THEN
        RAISE EXCEPTION 'Usuario no autorizado en esta fecha: %s', _user_code;
    END IF;

    -- Check the password can be changed (is not 'FIJ')
    IF (_psw_tipo != 'CAD') AND (_psw_tipo != 'NCA') THEN
        RAISE EXCEPTION 'La contraseña no se puede cambiar porque está bloqueada';
    END IF;

    -- Check the user is not disabled ('HA' = habilitado)
    IF (_usu_estado != 'HA') THEN
        RAISE EXCEPTION 'Usuario está deshabilitado: %s', _user_code;
    END IF;

    -- Check new password has not been used before
    IF (_password        = _user_word)
    OR (_psw_ultimas_001 = _user_word)
    OR (_psw_ultimas_002 = _user_word)
    OR (_psw_ultimas_003 = _user_word)
    OR (_psw_ultimas_004 = _user_word)
    OR (_psw_ultimas_005 = _user_word)
    OR (_psw_ultimas_006 = _user_word) 
    THEN
        RAISE EXCEPTION 'Contraseña ya se utilizó anteriormente';
    END IF;

    -- Update user password info
    UPDATE ecuaccusu 
    SET    psw_ultimas_006 = psw_ultimas_005,
           psw_ultimas_005 = psw_ultimas_004,
           psw_ultimas_004 = psw_ultimas_003,
           psw_ultimas_003 = psw_ultimas_002,
           psw_ultimas_002 = psw_ultimas_001,
           psw_ultimas_001 = password,
           password        = _user_word,
           psw_vig_desd    = _yyyymmdd,
           psw_estado      = 'VIG'
    WHERE  usu_codigo = _usu_codigo
    AND    usu_estado = 'HA'
    AND    psw_tipo  IN ('CAD', 'NCA')
    AND    _yyyymmdd BETWEEN fec_vig_desd AND fec_vig_hast;
    IF (NOT FOUND) THEN
        RAISE EXCEPTION 'No se pudo cambiar la contraseña de %s', _user_code;
    END IF;

    -- User updated
    _updated := 1;
END;
$BODY$ LANGUAGE plpgsql;
