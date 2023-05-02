CREATE OR REPLACE FUNCTION securityfx$audits_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _date_time_from     IN  VARCHAR,
    _date_time_to       IN  VARCHAR,
    _user_code          IN  VARCHAR,
    _profile_code       IN  INTEGER,
    _terminal_name      IN  VARCHAR,
    _event_code         IN  INTEGER,
    _audits_max         IN  INTEGER,
    _audits             OUT REFCURSOR
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
    -- #ResultSet AUDIT AUDITS
    --    #Column DATE_TIME         VARCHAR
    --    #Column USER_CODE         VARCHAR
    --    #Column PROFILE_CODE      INTEGER
    --    #Column TERMINAL_NAME     VARCHAR
    --    #Column EVENT_CODE        INTEGER
    --    #Column MESSAGE           VARCHAR
    -- #EndResultSet
    OPEN _audits FOR
        SELECT RTRIM(v_eculog_hora)         AS DATE_TIME,
               RTRIM(v_eculog_codigo_adi)   AS USER_CODE,
               v_eculog_codigo_ecu          AS PROFILE_CODE,
               RTRIM(v_eculog_terminal)     AS TERMINAL_NAME,
               v_eculog_codigo_msg          AS EVENT_CODE,
               RTRIM(v_eculog_mensaje)      AS MESSAGE
        FROM  ecuacclog
        WHERE v_eculog_hora BETWEEN _date_time_from AND _date_time_to
        AND   (_user_code     IS NULL OR _user_code = v_eculog_codigo_adi)
        AND   (_profile_code  IS NULL OR _profile_code = v_eculog_codigo_ecu)
        AND   (_terminal_name IS NULL OR _terminal_name = v_eculog_terminal)
        AND   (_event_code    IS NULL OR _event_code = v_eculog_codigo_msg)
        ORDER BY v_eculog_hora DESC
        LIMIT _audits_max;
END;
$BODY$ LANGUAGE plpgsql;
