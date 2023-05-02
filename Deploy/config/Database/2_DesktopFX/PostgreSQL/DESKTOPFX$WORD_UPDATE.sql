CREATE OR REPLACE FUNCTION desktopfx$word_update (
    _user_code          IN  VARCHAR,
    _user_word          IN  VARCHAR,
    _user_state         IN  VARCHAR,
    _valid_from         IN  VARCHAR
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
    -- Update user passwords info
    UPDATE ecuaccusu 
    SET    psw_ultimas_006 = psw_ultimas_005,
           psw_ultimas_005 = psw_ultimas_004,
           psw_ultimas_004 = psw_ultimas_003,
           psw_ultimas_003 = psw_ultimas_002,
           psw_ultimas_002 = psw_ultimas_001,
           psw_ultimas_001 = password,
           password        = _user_word,
           psw_estado      = _user_state,
           psw_vig_desd    = _valid_from
    WHERE  usu_codigo = _user_code;
END;
$BODY$ LANGUAGE plpgsql;
