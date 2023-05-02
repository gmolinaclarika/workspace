CREATE OR REPLACE FUNCTION mcastadmin$multicast_add (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _name               IN  VARCHAR,
    _message            IN  VARCHAR,
    _valid_from         IN  TIMESTAMP,
    _valid_to           IN  TIMESTAMP,
    _user_filter        IN  VARCHAR,
    _profile_filter     IN  INTEGER,
    _station_filter     IN  VARCHAR,
    _attachment_type    IN  VARCHAR,
    _attachment         IN  BYTEA,
    _new_multicast_id   OUT DECIMAL
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
    -- Create new Multicast instance
    WITH inserted AS (
        INSERT INTO desktopfx_multicast (
            name, message, valid_from, valid_to, user_filter,
            profile_filter, station_filter, attachment_type, attachment
        ) VALUES (
            COALESCE(_name,''), COALESCE(_message,''), _valid_from, _valid_to, 
            RTRIM(_user_filter), _profile_filter, RTRIM(_station_filter), 
            RTRIM(_attachment_type), _attachment
        ) RETURNING id)
    SELECT id INTO _new_multicast_id FROM inserted;
END;
$BODY$ LANGUAGE plpgsql;
