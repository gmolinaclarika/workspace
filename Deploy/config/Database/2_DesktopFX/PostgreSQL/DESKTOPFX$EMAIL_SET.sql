CREATE OR REPLACE FUNCTION desktopfx$email_set (
    _user_code          IN  VARCHAR,
    _email_addr         IN  VARCHAR,
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
BEGIN
    -- Update user email info
    UPDATE ecuaccusu 
    SET    email = _email_addr
    WHERE  usu_codigo = _user_code
    AND    usu_estado = 'HA'
    AND    psw_tipo IN ('CAD', 'NCA');

    -- Return TRUE if update successful
    IF (FOUND) THEN
        _updated := 1;
    ELSE
        _updated := 0;
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
