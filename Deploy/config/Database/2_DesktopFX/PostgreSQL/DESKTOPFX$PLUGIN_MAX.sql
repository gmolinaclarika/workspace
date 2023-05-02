CREATE OR REPLACE FUNCTION desktopfx$plugin_max (
    _plugin_prefix      IN  VARCHAR,
    _max_modified       OUT TIMESTAMP
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
    -- Return plugin max modified date
    IF (LENGTH(_plugin_prefix) = 0) THEN
        SELECT MAX(modified) 
        INTO   _max_modified 
        FROM   desktopfx_plugin 
        WHERE  enabled = 1;
    ELSE
        SELECT MAX(modified) 
        INTO   _max_modified 
        FROM   desktopfx_plugin 
        WHERE  name LIKE _plugin_prefix || '%'
          AND  enabled = 1;
    END IF;

    -- Make sure we don't return NULL
    IF (_max_modified IS NULL) THEN
        _max_modified := timestamp '1900-01-01 00:00';
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
