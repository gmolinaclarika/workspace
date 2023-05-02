CREATE OR REPLACE FUNCTION mcastadmin$mresponse_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _mresponse_id       IN  DECIMAL,
    _multicast_id       OUT DECIMAL,
    _message            OUT VARCHAR,
    _station_code       OUT VARCHAR,
    _request_time       OUT TIMESTAMP,
    _response_time      OUT TIMESTAMP,
    _attachment_type    OUT VARCHAR,
    _attachment         OUT BYTEA
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
    SELECT 
        multicast_id, 
        message, 
        station_code, 
        request_time, 
        response_time,
        attachment_type,
        attachment
    INTO   
        _multicast_id, 
        _message, 
        _station_code, 
        _request_time, 
        _response_time,
        _attachment_type,
        _attachment
    FROM  desktopfx_mresponse
    WHERE id = _mresponse_id;
END;
$BODY$ LANGUAGE plpgsql;
