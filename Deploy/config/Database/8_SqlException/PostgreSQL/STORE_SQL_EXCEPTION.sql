CREATE OR REPLACE FUNCTION store_sql_exception (
    _method_name    IN  VARCHAR,        -- Method that threw SQLException
    _sql_state      IN  CHAR,           -- SQLException SQL State
    _error_code     IN  INTEGER,        -- SQLException Error Code
    _message        IN  VARCHAR         -- SQLException Message
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
-- CREATE TABLE sql_exception
-- (
--     id              BIGSERIAL       NOT NULL,
--     method_name     VARCHAR(200)    NOT NULL    DEFAULT '',
--     date_time       TIMESTAMP(3)    NOT NULL    DEFAULT NOW(),
--     sql_state       CHAR(5)         NOT NULL    DEFAULT '00000',
--     error_code      INTEGER         NOT NULL    DEFAULT 0,
--     message         VARCHAR(500)    NOT NULL    DEFAULT '',
--     CONSTRAINT sql_exception_pk PRIMARY KEY (id)
-- );
--------------------------------------------------------------------------------
-- https://en.wikipedia.org/wiki/SQLSTATE
-- https://www.postgresql.org/docs/9.4/errcodes-appendix.html
--------------------------------------------------------------------------------
BEGIN
    INSERT INTO sql_exception (
        method_name,
        sql_state,
        error_code,
        message
    ) VALUES (
        _method_name,
        _sql_state,
        _error_code,
        _message
    );
END;
$BODY$ LANGUAGE plpgsql;
