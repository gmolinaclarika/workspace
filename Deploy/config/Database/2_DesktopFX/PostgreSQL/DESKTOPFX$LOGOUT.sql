CREATE OR REPLACE FUNCTION desktopfx$logout (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _last_desktop       IN  INTEGER,
    _login_state        IN  BYTEA
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
DECLARE
    _last_poll          TIMESTAMP;
    _user_id            BIGINT;
BEGIN
    -- Compute last poll datetime
    IF (_last_desktop = 0) THEN
        _last_poll := NOW();
    ELSE    
        _last_poll := NOW() - INTERVAL '5 minutes';
    END IF;

    -- Update last user poll date
    WITH updated AS (
        UPDATE desktopfx_user
        SET    last_poll = _last_poll
        WHERE  user_code = _wss_user_code
        RETURNING id)
    SELECT id INTO _user_id FROM updated;

    -- Update login state if not null
    IF (_user_id IS NOT NULL) THEN
        IF (_login_state IS NOT NULL) THEN
            UPDATE desktopfx_login
            SET    login_state = _login_state
            WHERE  user_id = _user_id
            AND    profile_code = _wss_profile_code;
        END IF;
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
