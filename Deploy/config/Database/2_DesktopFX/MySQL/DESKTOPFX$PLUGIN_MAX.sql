DROP PROCEDURE IF EXISTS DESKTOPFX$PLUGIN_MAX;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$PLUGIN_MAX (
-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------
    IN  _PLUGIN_PREFIX      VARCHAR(200),
    OUT _MAX_MODIFIED       DATETIME(3)
)
BEGIN
    -- Return plugin max modified date
    IF (LENGTH(_PLUGIN_PREFIX) = 0) THEN
        SELECT MAX(MODIFIED) INTO _MAX_MODIFIED
        FROM  DESKTOPFX_PLUGIN 
        WHERE ENABLED = 1;
    ELSE
        SELECT MAX(MODIFIED) INTO _MAX_MODIFIED
        FROM  DESKTOPFX_PLUGIN 
        WHERE NAME LIKE CONCAT(_PLUGIN_PREFIX, '%')
          AND ENABLED = 1;
    END IF;    

    -- Make sure we don't return NULL
    IF (_MAX_MODIFIED IS NULL) THEN
	    SET _MAX_MODIFIED = STR_TO_DATE('1900/01/01', '%Y/%m/%d'); 
    END IF;
END$$
DELIMITER ;
