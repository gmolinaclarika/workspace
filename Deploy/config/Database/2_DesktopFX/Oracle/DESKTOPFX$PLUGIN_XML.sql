CREATE OR REPLACE PROCEDURE DESKTOPFX$PLUGIN_XML
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
(
    PLUGIN_PREFIX$  IN  NVARCHAR2,
    PLUGINS$        OUT SYS_REFCURSOR
)
AS
BEGIN
    -- #ResultSet PLUGIN PLUGINS
    --   #Column  NAME  VARCHAR
    --   #Column  XML   VARCHAR
    -- #EndResultSet
    IF (PLUGIN_PREFIX$ IS NULL) THEN
        OPEN PLUGINS$ FOR
            SELECT NAME AS NAME,
                   XML  AS XML
            FROM  DESKTOPFX_PLUGIN 
            WHERE ENABLED = 1
            ORDER BY NAME;
    ELSE
        OPEN PLUGINS$ FOR
            SELECT NAME AS NAME,
                   XML  AS XML
            FROM  DESKTOPFX_PLUGIN 
            WHERE NAME LIKE PLUGIN_PREFIX$ || '%'
              AND ENABLED = 1
            ORDER BY NAME;
    END IF;
END DESKTOPFX$PLUGIN_XML;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
