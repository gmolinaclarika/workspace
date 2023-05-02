CREATE OR REPLACE FUNCTION desktopfx$serial_set (
    _station_code       IN  VARCHAR,
    _serial             IN  VARCHAR
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
    -- Update station serial info
    UPDATE ecuaccnet 
    SET    v_net_serieterm = _serial
    WHERE  v_net_nombre = _station_code;
END;
$BODY$ LANGUAGE plpgsql;
