CREATE OR REPLACE FUNCTION desktopfx$multicast_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _multicast_id       IN  DECIMAL,
    _valid_from         OUT TIMESTAMP,
    _valid_to           OUT TIMESTAMP,
    _name               OUT VARCHAR,
    _message            OUT VARCHAR,
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
    -- Return Multicast properties
    SELECT _valid_from      = valid_from,
           _valid_to        = valid_to,
           _name            = name,
           _message         = message,
           _attachment_type = attachment_type,
           _attachment      = attachment
    FROM  desktopfx_multicast
    WHERE id = _multicast_id;
END;
$BODY$ LANGUAGE plpgsql;
