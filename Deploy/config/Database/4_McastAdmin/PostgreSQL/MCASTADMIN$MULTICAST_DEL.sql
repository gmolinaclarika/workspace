CREATE OR REPLACE FUNCTION mcastadmin$multicast_del (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _multicast_id       IN  DECIMAL
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
BEGIN
    -- Delete the Multicast Responses
    DELETE FROM desktopfx_mresponse
    WHERE  multicast_id = _multicast_id;

    -- Delete the Multicast itself
    DELETE FROM desktopfx_multicast
    WHERE  id = _multicast_id;
END;
$BODY$ LANGUAGE plpgsql;
