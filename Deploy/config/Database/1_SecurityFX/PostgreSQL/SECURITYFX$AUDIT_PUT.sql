CREATE OR REPLACE FUNCTION securityfx$audit_put (
    _user_code          IN  VARCHAR,
    _profile_code       IN  INTEGER,
    _station_code       IN  VARCHAR,
    _event_code         IN  INTEGER,
    _message            IN  VARCHAR
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
    INSERT INTO ecuacclog (
         v_eculog_hora
        ,v_eculog_codigo_adi
        ,v_eculog_codigo_ecu
        ,v_eculog_terminal
        ,v_eculog_codigo_msg
        ,v_eculog_mensaje
    ) VALUES (
         TO_CHAR(NOW(), 'YYYY-MM-DD:HH24:MI:SS.US')
        ,COALESCE(_user_code, '?')
        ,COALESCE(_profile_code, 9999999)
        ,COALESCE(_station_code, '?')
        ,COALESCE(_event_code, 9999)
        ,COALESCE(_message, '?')
    );
END;
$BODY$ LANGUAGE plpgsql;
