CREATE OR REPLACE PROCEDURE DESKTOPFX$PLUGIN_MAX
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
    MAX_MODIFIED$   OUT TIMESTAMP
)
AS
BEGIN
    -- Return plugin max modified date
    IF (PLUGIN_PREFIX$ IS NULL) THEN
        SELECT MAX(MODIFIED) 
        INTO   MAX_MODIFIED$ 
        FROM   DESKTOPFX_PLUGIN 
        WHERE  ENABLED = 1;
    ELSE
        SELECT MAX(MODIFIED) 
        INTO   MAX_MODIFIED$ 
        FROM   DESKTOPFX_PLUGIN 
        WHERE  NAME LIKE PLUGIN_PREFIX$ || '%'
          AND  ENABLED = 1;
    END IF;

    -- Make sure we don't return NULL
    IF (MAX_MODIFIED$ IS NULL) THEN
        MAX_MODIFIED$ := TO_TIMESTAMP('1/1/1900', 'MM/DD/YYYY');
    END IF;
END DESKTOPFX$PLUGIN_MAX;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
