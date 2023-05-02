CREATE OR REPLACE FUNCTION actviewer$activity_get (
    _valid_from         TIMESTAMP,
    _valid_to           TIMESTAMP,
    --------------------------------
    _activity_max       IN  INTEGER,
    _activity           OUT REFCURSOR
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
    -- Assign default to _valid_to
    IF (_valid_to IS NULL) THEN
        _valid_to = NOW() + INTERVAL '5 seconds';
    END IF;

    -- Assign default to _valid_from
    IF (_valid_from IS NULL) THEN
        _valid_from = NOW() - INTERVAL '60 seconds';
    END IF;

    -- #ResultSet ACTIVITY ACTIVITIES
    --    #Column USER_CODE     NVARCHAR
    --    #Column GIVEN_NAMES   NVARCHAR
    --    #Column FATHER_NAME   NVARCHAR
    --    #Column MOTHER_NAME   NVARCHAR
    --    #Column STATION_CODE  NVARCHAR
    --    #Column LAST_LOGIN    NVARCHAR
    --    #Column LAST_POLL     DATETIME
    -- #EndResultSet
    OPEN _activity FOR
        SELECT d.user_code          AS USER_CODE,
               TRIM(e.nombres)      AS GIVEN_NAMES,
               TRIM(e.apellido_pat) AS FATHER_NAME,
               TRIM(e.apellido_mat) AS MOTHER_NAME,
               d.station_code       AS STATION_CODE,
               e.fec_ult_log        AS LAST_LOGIN,
               d.last_poll          AS LAST_POLL
        FROM   desktopfx_user d, ecuaccusu e
        WHERE  e.usu_codigo = d.user_code
        AND    d.last_poll BETWEEN _valid_from AND _valid_to
        UNION
        SELECT d.user_code          AS USER_CODE,
               TRIM(e.nombres)      AS GIVEN_NAMES,
               TRIM(e.apellido_pat) AS FATHER_NAME,
               TRIM(e.apellido_mat) AS MOTHER_NAME,
               d.station_code       AS STATION_CODE,
               e.fec_ult_log        AS LAST_LOGIN,
               d.last_poll          AS LAST_POLL
        FROM   desktopfx_user d, ecuaccusu e
        WHERE  e.usu_codigo = '_ANONYMOUS'
        AND    LEFT(d.user_code, 1) = '$'
        AND    d.last_poll BETWEEN _valid_from AND _valid_to
        ORDER BY user_code
        LIMIT _activity_max;
END;
$BODY$ LANGUAGE plpgsql;
