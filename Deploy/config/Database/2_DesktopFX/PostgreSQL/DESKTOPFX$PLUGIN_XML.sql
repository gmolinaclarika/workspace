CREATE OR REPLACE FUNCTION desktopfx$plugin_xml (
    _plugin_prefix      IN  VARCHAR,
    _plugins            OUT REFCURSOR
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
    -- #ResultSet PLUGIN PLUGINS
    --   #Column  NAME  VARCHAR
    --   #Column  XML   VARCHAR
    -- #EndResultSet
    IF (LENGTH(_plugin_prefix) = 0) THEN
        OPEN _plugins FOR
            SELECT name AS NAME,
                   xml  AS XML
            FROM  desktopfx_plugin 
            WHERE enabled = 1
            ORDER BY name;
    ELSE
        OPEN _plugins FOR
            SELECT name AS NAME,
                   xml  AS XML
            FROM  desktopfx_plugin 
            WHERE name LIKE _plugin_prefix || '%'
              AND enabled = 1
            ORDER BY name;
    END IF;
END;
$BODY$ LANGUAGE plpgsql;
