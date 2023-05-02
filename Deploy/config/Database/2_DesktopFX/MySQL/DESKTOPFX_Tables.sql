-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------

DROP TABLE IF EXISTS DESKTOPFX_MRESPONSE;
DROP TABLE IF EXISTS DESKTOPFX_MULTICAST;
DROP TABLE IF EXISTS DESKTOPFX_PLUGIN;
DROP TABLE IF EXISTS DESKTOPFX_OBJECT;
DROP TABLE IF EXISTS DESKTOPFX_LOGIN;
DROP TABLE IF EXISTS DESKTOPFX_USER;

-- -----------------------------------------------------------------------------
-- DESKTOPFX_USER --------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS DESKTOPFX_USER
(
    ID                      BIGINT          NOT NULL    AUTO_INCREMENT,
    USER_CODE               VARCHAR(200)    NOT NULL    DEFAULT '',
    SERVICE_NAME            VARCHAR(200)    NOT NULL    DEFAULT 'SERVICE',
    STATION_CODE            VARCHAR(200)    NOT NULL    DEFAULT '',
    LAST_POLL               DATETIME(3)     NOT NULL    DEFAULT NOW(3),
    CONSTRAINT DESKTOPFX_USER_PK PRIMARY KEY (ID),
    CONSTRAINT DESKTOPFX_USER_IX UNIQUE (USER_CODE)
);

-- -----------------------------------------------------------------------------
-- DESKTOPFX_LOGIN -------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS DESKTOPFX_LOGIN
(
    ID                      BIGINT          NOT NULL    AUTO_INCREMENT,
    USER_ID                 BIGINT          NOT NULL    DEFAULT 0,
    PROFILE_CODE            INTEGER         NOT NULL    DEFAULT 0,
    LOGIN_STATE             LONGBLOB        NULL,
    CONSTRAINT DESKTOPFX_LOGIN_PK PRIMARY KEY (ID),
    CONSTRAINT DESKTOPFX_LOGIN_IX UNIQUE (USER_ID,PROFILE_CODE),
    CONSTRAINT DESKTOPFX_LOGIN_FK FOREIGN KEY (USER_ID)
        REFERENCES DESKTOPFX_USER(ID) ON DELETE CASCADE
);

-- -----------------------------------------------------------------------------
-- DESKTOPFX_OBJECT ------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS DESKTOPFX_OBJECT
(
    ID                      BIGINT          NOT NULL    AUTO_INCREMENT,
    LOGIN_ID                BIGINT          NOT NULL    DEFAULT 0,
    NAME                    VARCHAR(200)    NOT NULL    DEFAULT '',
    MODIFIED                DATETIME(3)     NOT NULL    DEFAULT NOW(3),
    TYPE                    INTEGER         NOT NULL    DEFAULT 0,
    BYTES                   LONGBLOB        NULL,
    CONSTRAINT DESKTOPFX_OBJECT_PK PRIMARY KEY (ID),
    CONSTRAINT DESKTOPFX_OBJECT_IX UNIQUE (LOGIN_ID,TYPE,NAME),
    CONSTRAINT DESKTOPFX_OBJECT_FK FOREIGN KEY (LOGIN_ID)
        REFERENCES DESKTOPFX_LOGIN(ID) ON DELETE CASCADE
);

-- -----------------------------------------------------------------------------
-- DESKTOPFX_PLUGIN ------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS DESKTOPFX_PLUGIN
(
    ID                      BIGINT          NOT NULL    AUTO_INCREMENT,
    NAME                    VARCHAR(200)    NOT NULL    DEFAULT '',
    MODIFIED                DATETIME(3)     NOT NULL    DEFAULT NOW(3),
    ENABLED                 INTEGER         NOT NULL    DEFAULT 0,
    XML                     LONGTEXT        NOT NULL,
    CONSTRAINT DESKTOPFX_PLUGIN_PK PRIMARY KEY (ID),
    CONSTRAINT DESKTOPFX_PLUGIN_IX UNIQUE (NAME)
);

-- -----------------------------------------------------------------------------
-- DESKTOPFX_MULTICAST ---------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS DESKTOPFX_MULTICAST
(
    ID                      BIGINT          NOT NULL    AUTO_INCREMENT,
    VALID_FROM              DATETIME(3)     NOT NULL    DEFAULT NOW(3),
    VALID_TO                DATETIME(3)     NOT NULL    DEFAULT NOW(3),
    NAME                    VARCHAR(200)    NOT NULL    DEFAULT '',
    MESSAGE                 VARCHAR(2000)   NOT NULL    DEFAULT '',
    ATTACHMENT_TYPE         VARCHAR(200)    NULL,
    ATTACHMENT              LONGBLOB        NULL,
    USER_FILTER             VARCHAR(200)    NULL,
    PROFILE_FILTER          INTEGER         NULL,
    STATION_FILTER          VARCHAR(200)    NULL,
    CONSTRAINT DESKTOPFX_MULTICAST_PK PRIMARY KEY (ID)
);

-- -----------------------------------------------------------------------------
-- DESKTOPFX_MRESPONSE ---------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS DESKTOPFX_MRESPONSE
(
    ID                      BIGINT          NOT NULL    AUTO_INCREMENT,
    MULTICAST_ID            BIGINT          NOT NULL    DEFAULT 0,
    STATION_CODE            VARCHAR(200)    NOT NULL    DEFAULT '',
    REQUEST_TIME            DATETIME(3)     NOT NULL    DEFAULT NOW(3),
    RESPONSE_TIME           DATETIME(3)     NOT NULL    DEFAULT NOW(3),
    MESSAGE                 VARCHAR(2000)   NOT NULL    DEFAULT '',
    ATTACHMENT_TYPE         VARCHAR(200)    NULL,
    ATTACHMENT              LONGBLOB        NULL,
    CONSTRAINT DESKTOPFX_MRESPONSE_PK PRIMARY KEY (ID),
    CONSTRAINT DESKTOPFX_MRESPONSE_FK FOREIGN KEY (MULTICAST_ID)
        REFERENCES DESKTOPFX_MULTICAST(ID) ON DELETE CASCADE
);

-- -----------------------------------------------------------------------------
