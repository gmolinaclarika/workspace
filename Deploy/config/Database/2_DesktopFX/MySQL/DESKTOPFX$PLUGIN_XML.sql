DROP PROCEDURE IF EXISTS DESKTOPFX$PLUGIN_XML;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$PLUGIN_XML (
-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------
    IN  _PLUGIN_PREFIX      VARCHAR(200)
)
BEGIN
    -- #ResultSet PLUGIN PLUGINS
    --   #Column  NAME  VARCHAR
    --   #Column  XML   VARCHAR
    -- #EndResultSet
    IF (LENGTH(_PLUGIN_PREFIX) = 0) THEN
        SELECT NAME AS NAME,
               XML  AS XML
        FROM  DESKTOPFX_PLUGIN 
        WHERE ENABLED = 1
        ORDER BY NAME;
    ELSE
        SELECT NAME AS NAME,
               XML  AS XML
        FROM  DESKTOPFX_PLUGIN 
        WHERE NAME LIKE CONCAT(_PLUGIN_PREFIX, '%')
          AND ENABLED = 1
        ORDER BY NAME;
    END IF;
END$$
DELIMITER ;
