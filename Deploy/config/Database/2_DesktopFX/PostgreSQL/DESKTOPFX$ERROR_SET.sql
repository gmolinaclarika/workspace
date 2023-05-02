CREATE OR REPLACE FUNCTION desktopfx$error_set (
    _user_code          IN  VARCHAR,
    _error_count        IN  INTEGER,
    _error_date         IN  VARCHAR
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
    -- Update user error info
    UPDATE ecuaccusu 
    SET    error_login = _error_count,
           fec_err_log = _error_date
    WHERE  usu_codigo = _user_code;
END;
$BODY$ LANGUAGE plpgsql;
