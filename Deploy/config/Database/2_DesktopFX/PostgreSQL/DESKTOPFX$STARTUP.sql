CREATE OR REPLACE FUNCTION desktopfx$startup (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _serial             IN  VARCHAR,
    _nonce              IN  BYTEA,
    _version            OUT INTEGER,
    _bytes              OUT BYTEA,
    _digest             OUT BYTEA
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
    -- Initialize outputs
    _version := NULL;
    _bytes := NULL;
    _digest := NULL;

    -- Verify station name
    IF (LENGTH(_wss_station_code) = 0) THEN
        RAISE EXCEPTION 'No se suministro nombre de la estación de trabajo';
    END IF;

    -- Verify serial number
    IF (LENGTH(_serial) = 0) THEN
        RAISE EXCEPTION 'No se suministro serie de la estación de trabajo';
    END IF;

    -- Return startup properties (NULL if not defined)
    SELECT bytes INTO _bytes
    FROM   desktopfx_object
    WHERE  login_id = 0
    AND    type = 1
    AND    name = 'STARTUP';
    IF (NOT FOUND) THEN
        _bytes := NULL;
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
