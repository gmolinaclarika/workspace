--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- DESKTOPFX_USER --------------------------------------------------------------
--------------------------------------------------------------------------------

INSERT INTO DESKTOPFX_USER (
    ID, USER_CODE, SERVICE_NAME, STATION_CODE
) VALUES (
    0, '[GLOBAL]', 'SERVICE', '[GLOBAL]'
);

--------------------------------------------------------------------------------
-- DESKTOPFX_LOGIN -------------------------------------------------------------
--------------------------------------------------------------------------------

INSERT INTO DESKTOPFX_LOGIN (
    ID, USER_ID, PROFILE_CODE
) VALUES (
    0, 0, 0
);

--------------------------------------------------------------------------------

COMMIT;
QUIT;
