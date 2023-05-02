CREATE OR REPLACE FUNCTION desktopfx$mresponse_add (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _multicast_id       IN  DECIMAL,
    _request_time       IN  TIMESTAMP,
    _message            IN  VARCHAR,
    _attachment_type    IN  VARCHAR,
    _attachment         IN  BYTEA,
    _tresponse_id       OUT DECIMAL
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
    -- Add new Multicast Response data
    WITH inserted AS (
        INSERT INTO desktopfx_mresponse (
             multicast_id
            ,station_code
            ,request_time
            ,response_time
            ,message
            ,attachment_type
            ,attachment
        ) VALUES (
             _multicast_id
            ,_wss_station_code
            ,_request_time
            ,NOW()
            ,_message
            ,_attachment_type
            ,_attachment
        ) RETURNING id)
    SELECT id INTO _tresponse_id FROM inserted;
END;
$BODY$ LANGUAGE plpgsql;
