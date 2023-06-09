CREATE OR REPLACE FUNCTION desktopfx$word_state (
    _user_code          IN  VARCHAR,
    _pwd_state          IN  VARCHAR
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
    -- Update user expiration info
    UPDATE ecuaccusu 
    SET    psw_estado = _pwd_state
    WHERE  usu_codigo = _user_code;
END;
$BODY$ LANGUAGE plpgsql;
