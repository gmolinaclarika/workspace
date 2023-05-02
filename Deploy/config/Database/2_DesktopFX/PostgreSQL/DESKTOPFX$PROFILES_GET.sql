CREATE OR REPLACE FUNCTION desktopfx$profiles_get (
    _user_code          IN  VARCHAR,
    _profiles           OUT REFCURSOR
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
DECLARE
    _codigo_adi     ecuaccu2p.codigo_adi%type := _user_code;
BEGIN
    -- #ResultSet PROFILE PROFILES
    --   #Column  PROFILE_CODE  INTEGER
    -- #EndResultSet
    OPEN _profiles FOR
        SELECT codigo_ecu AS PROFILE_CODE
        FROM   ecuaccu2p
        WHERE  codigo_adi = _codigo_adi;
END;
$BODY$ LANGUAGE plpgsql;
