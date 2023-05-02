CREATE OR REPLACE FUNCTION desktopfx$dates_set (
    _user_code          IN  VARCHAR,
    _first_date         IN  VARCHAR,
    _last_date          IN  VARCHAR
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
    -- Update user login date info
    UPDATE ecuaccusu 
    SET    fec_pri_log = _first_date, 
           fec_ult_log = _last_date 
    WHERE  usu_codigo = _user_code;
END;
$BODY$ LANGUAGE plpgsql;
