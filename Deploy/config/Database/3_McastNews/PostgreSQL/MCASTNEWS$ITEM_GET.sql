CREATE OR REPLACE FUNCTION mcastnews$item_get (
    _wss_user_code      IN  VARCHAR,
    _wss_profile_code   IN  INTEGER,
    _wss_station_code   IN  VARCHAR,
    --------------------------------
    _news_id            IN  DECIMAL,
    _valid_from         OUT TIMESTAMP,
    _message            OUT VARCHAR,
    _attachment_type    OUT VARCHAR,
    _attachment         OUT BYTEA
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
    SELECT  valid_from,  message,  attachment_type,  attachment 
    INTO   _valid_from, _message, _attachment_type, _attachment
    FROM  desktopfx_multicast
    WHERE id = _news_id;
END;
$BODY$ LANGUAGE plpgsql;
