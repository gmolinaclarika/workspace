--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------

DROP TABLE IF EXISTS desktopfx_user       CASCADE;
DROP TABLE IF EXISTS desktopfx_login      CASCADE;
DROP TABLE IF EXISTS desktopfx_object     CASCADE;
DROP TABLE IF EXISTS desktopfx_plugin     CASCADE;
DROP TABLE IF EXISTS desktopfx_multicast  CASCADE;
DROP TABLE IF EXISTS desktopfx_mresponse  CASCADE;

--------------------------------------------------------------------------------
-- DESKTOPFX_USER --------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE desktopfx_user
(
    id                  BIGSERIAL       NOT NULL,
    user_code           VARCHAR(200)    NOT NULL    DEFAULT '',
    service_name        VARCHAR(200)    NOT NULL    DEFAULT 'SERVICE',
    station_code        VARCHAR(200)    NOT NULL    DEFAULT '',
    last_poll           TIMESTAMP(3)    NOT NULL    DEFAULT NOW(),
    CONSTRAINT desktopfx_user_pk PRIMARY KEY (id),
    CONSTRAINT desktopfx_user_ix UNIQUE (user_code)
);

--------------------------------------------------------------------------------
-- DESKTOPFX_LOGIN -------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE desktopfx_login
(
    id                  BIGSERIAL       NOT NULL,
    user_id             BIGINT          NOT NULL    DEFAULT 0,
    profile_code        INTEGER         NOT NULL    DEFAULT 0,
    login_state         BYTEA           NULL,
    CONSTRAINT desktopfx_login_pk PRIMARY KEY (id),
    CONSTRAINT desktopfx_login_ix UNIQUE (user_id,profile_code),
    CONSTRAINT desktopfx_login_fk FOREIGN KEY (user_id)
        REFERENCES desktopfx_user(id) ON DELETE CASCADE
);

--------------------------------------------------------------------------------
-- DESKTOPFX_OBJECT ------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE desktopfx_object
(
    id                  BIGSERIAL       NOT NULL,
    login_id            BIGINT          NOT NULL    DEFAULT 0,
    name                VARCHAR(200)    NOT NULL    DEFAULT '',
    modified            TIMESTAMP(3)    NOT NULL    DEFAULT NOW(),
    type                INTEGER         NOT NULL    DEFAULT 0,
    bytes               BYTEA           NULL,
    CONSTRAINT desktopfx_object_pk PRIMARY KEY (id),
    CONSTRAINT desktopfx_object_ix UNIQUE (login_id,type,name),
    CONSTRAINT desktopfx_object_fk FOREIGN KEY (login_id)
        REFERENCES desktopfx_login(id) ON DELETE CASCADE
);

--------------------------------------------------------------------------------
-- DESKTOPFX_PLUGIN ------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE desktopfx_plugin
(
    id                  BIGSERIAL       NOT NULL,
    name                VARCHAR(200)    NOT NULL    DEFAULT '',
    modified            TIMESTAMP(3)    NOT NULL    DEFAULT NOW(),
    enabled             INTEGER         NOT NULL    DEFAULT 0,
    xml                 TEXT            NOT NULL    DEFAULT '',
    CONSTRAINT desktopfx_plugin_pk PRIMARY KEY (id),
    CONSTRAINT desktopfx_plugin_ix UNIQUE (name)
);

--------------------------------------------------------------------------------
-- DESKTOPFX_MULTICAST ---------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE desktopfx_multicast
(
    id                  BIGSERIAL       NOT NULL,
    valid_from          TIMESTAMP(3)    NOT NULL    DEFAULT NOW(),
    valid_to            TIMESTAMP(3)    NOT NULL    DEFAULT NOW(),
    name                VARCHAR(200)    NOT NULL    DEFAULT '',
    message             VARCHAR(2000)   NOT NULL    DEFAULT '',
    attachment_type     VARCHAR(200)    NULL,
    attachment          BYTEA           NULL,
    user_filter         VARCHAR(200)    NULL,
    profile_filter      INTEGER         NULL,
    station_filter      VARCHAR(200)    NULL,
    CONSTRAINT desktopfx_multicast_pk PRIMARY KEY (id)
);

--------------------------------------------------------------------------------
-- DESKTOPFX_MRESPONSE ---------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE desktopfx_mresponse
(
    id                  BIGSERIAL       NOT NULL,
    multicast_id        BIGINT          NOT NULL    DEFAULT 0,
    station_code        VARCHAR(200)    NOT NULL    DEFAULT '',
    request_time        TIMESTAMP(3)    NOT NULL    DEFAULT NOW(),
    response_time       TIMESTAMP(3)    NOT NULL    DEFAULT NOW(),
    message             VARCHAR(2000)   NOT NULL    DEFAULT '',
    attachment_type     VARCHAR(200)    NULL,
    attachment          BYTEA           NULL,
    CONSTRAINT desktopfx_mresponse_pk PRIMARY KEY (id),
    CONSTRAINT desktopfx_mresponse_fk FOREIGN KEY (multicast_id)
        REFERENCES desktopfx_multicast(id) ON DELETE CASCADE
);

--------------------------------------------------------------------------------
