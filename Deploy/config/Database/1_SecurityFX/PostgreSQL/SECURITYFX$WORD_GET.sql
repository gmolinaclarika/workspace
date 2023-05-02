CREATE OR REPLACE FUNCTION securityfx$word_get (
    _user_code          IN  VARCHAR,    -- EcuACCUSU.USU_CODIGO     CHAR(40)
    _profile_code       IN  INTEGER,    -- EcuACCPER.V_ACC_CODE_NUM DECIMAL(7)
    _station_code       IN  VARCHAR,    -- EcuACCNET.V_NET_NOMBRE   CHAR(16)
    _user_word          OUT VARCHAR     -- EcuACCUSU.PASSWORD       CHAR(51)
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
    _usu_codigo     ecuaccusu.usu_codigo%type := _user_code;
BEGIN
    SELECT password 
    INTO   _user_word
    FROM   ecuaccusu
    WHERE  usu_codigo = _usu_codigo;
    IF (NOT FOUND) THEN
        _user_word := NULL;
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
