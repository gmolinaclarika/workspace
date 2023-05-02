CREATE OR REPLACE FUNCTION desktopfx$email_get (
    _user_code          IN  VARCHAR,
    _email_addr         OUT VARCHAR
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
    _usu_estado         ecuaccusu.usu_estado%type;
    _psw_tipo           ecuaccusu.psw_tipo%type;
BEGIN
    -- Obtain properties of specified user
    SELECT usu_estado, psw_tipo, RTRIM(email)
    INTO  _usu_estado, _psw_tipo, _email_addr
    FROM   ecuaccusu
    WHERE  usu_codigo = _user_code;
    IF (NOT FOUND) THEN
        RAISE EXCEPTION 'Usuario especificado no está definido';
    END IF;

    -- Check the user is not disabled ('HA'=habilitado)
    IF (_usu_estado != 'HA') THEN
        RAISE EXCEPTION 'Usuario especificado no está habilitado';
    END IF;

    -- Check user can change password ('CAD'=caducado,'NCA'=no-caducado)
    IF (_psw_tipo != 'CAD' AND _psw_tipo != 'NCA') THEN
        RAISE EXCEPTION 'Usuario no puede cambiar la contraseña';
    END IF;

    -- Check the user has an E-mail address
    IF (LENGTH(_email_addr) = 0) THEN
        RAISE EXCEPTION 'Usuario no tiene una dirección de correo';
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
