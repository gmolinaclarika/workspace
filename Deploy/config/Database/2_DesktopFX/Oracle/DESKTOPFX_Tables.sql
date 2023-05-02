--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------

DROP TABLE DESKTOPFX_USER       CASCADE CONSTRAINTS;
DROP TABLE DESKTOPFX_LOGIN      CASCADE CONSTRAINTS;
DROP TABLE DESKTOPFX_OBJECT     CASCADE CONSTRAINTS;
DROP TABLE DESKTOPFX_PLUGIN     CASCADE CONSTRAINTS;
DROP TABLE DESKTOPFX_MULTICAST  CASCADE CONSTRAINTS;
DROP TABLE DESKTOPFX_MRESPONSE  CASCADE CONSTRAINTS;

DROP SEQUENCE DESKTOPFX_USER_SQ;
DROP SEQUENCE DESKTOPFX_LOGIN_SQ;
DROP SEQUENCE DESKTOPFX_OBJECT_SQ;
DROP SEQUENCE DESKTOPFX_PLUGIN_SQ;
DROP SEQUENCE DESKTOPFX_MULTICAST_SQ;
DROP SEQUENCE DESKTOPFX_MRESPONSE_SQ;

--------------------------------------------------------------------------------
-- DESKTOPFX_USER --------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE DESKTOPFX_USER
(
    ID                      DECIMAL(19)     DEFAULT 0               NOT NULL,
    USER_CODE               NVARCHAR2(200)  DEFAULT ' '             NOT NULL,
    SERVICE_NAME            NVARCHAR2(200)  DEFAULT 'SERVICE'       NOT NULL,
    STATION_CODE            NVARCHAR2(200)  DEFAULT ' '             NOT NULL,
    LAST_POLL               TIMESTAMP(3)    DEFAULT SYSTIMESTAMP    NOT NULL,
    CONSTRAINT DESKTOPFX_USER_PK PRIMARY KEY (ID)
);

CREATE UNIQUE INDEX DESKTOPFX_USER_IX
    ON DESKTOPFX_USER (USER_CODE);

CREATE SEQUENCE DESKTOPFX_USER_SQ
    START WITH   1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

--------------------------------------------------------------------------------
-- DESKTOPFX_LOGIN -------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE DESKTOPFX_LOGIN
(
    ID                      DECIMAL(19)     DEFAULT 0   NOT NULL,
    USER_ID                 DECIMAL(19)     DEFAULT 0   NOT NULL,
    PROFILE_CODE            INTEGER         DEFAULT 0   NOT NULL,
    LOGIN_STATE             BLOB                        NULL,
    CONSTRAINT DESKTOPFX_LOGIN_PK PRIMARY KEY (ID),
    CONSTRAINT DESKTOPFX_LOGIN_FK FOREIGN KEY (USER_ID)
        REFERENCES DESKTOPFX_USER(ID) ON DELETE CASCADE
);

CREATE UNIQUE INDEX DESKTOPFX_LOGIN_IX
    ON DESKTOPFX_LOGIN (USER_ID,PROFILE_CODE);

CREATE SEQUENCE DESKTOPFX_LOGIN_SQ
    START WITH   1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

--------------------------------------------------------------------------------
-- DESKTOPFX_OBJECT ------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE DESKTOPFX_OBJECT
(
    ID                      DECIMAL(19)     DEFAULT 0               NOT NULL,
    LOGIN_ID                DECIMAL(19)     DEFAULT 0               NOT NULL,
    NAME                    NVARCHAR2(200)  DEFAULT ' '             NOT NULL,
    MODIFIED                TIMESTAMP(3)    DEFAULT SYSTIMESTAMP    NOT NULL,
    TYPE                    INTEGER         DEFAULT 0               NOT NULL,
    BYTES                   BLOB                                    NULL,
    CONSTRAINT DESKTOPFX_OBJECT_PK PRIMARY KEY (ID),
    CONSTRAINT DESKTOPFX_OBJECT_FK FOREIGN KEY (LOGIN_ID)
        REFERENCES DESKTOPFX_LOGIN(ID) ON DELETE CASCADE
);

CREATE UNIQUE INDEX DESKTOPFX_OBJECT_IX
    ON DESKTOPFX_OBJECT (LOGIN_ID,TYPE,NAME);

CREATE SEQUENCE DESKTOPFX_OBJECT_SQ
    START WITH   1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

--------------------------------------------------------------------------------
-- DESKTOPFX_PLUGIN ------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE DESKTOPFX_PLUGIN
(
    ID                      DECIMAL(19)     DEFAULT 0               NOT NULL,
    NAME                    NVARCHAR2(200)  DEFAULT ' '             NOT NULL,
    MODIFIED                TIMESTAMP(3)    DEFAULT SYSTIMESTAMP    NOT NULL,
    ENABLED                 INTEGER         DEFAULT 0               NOT NULL,
    XML                     NCLOB           DEFAULT ' '             NOT NULL,
    CONSTRAINT DESKTOPFX_PLUGIN_PK PRIMARY KEY (ID)
);

CREATE UNIQUE INDEX DESKTOPFX_PLUGIN_IX
    ON DESKTOPFX_PLUGIN (NAME);

CREATE SEQUENCE DESKTOPFX_PLUGIN_SQ
    START WITH   1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

--------------------------------------------------------------------------------
-- DESKTOPFX_MULTICAST ---------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE DESKTOPFX_MULTICAST
(
    ID                      DECIMAL(19)     DEFAULT 0               NOT NULL,
    VALID_FROM              TIMESTAMP(3)    DEFAULT SYSTIMESTAMP    NOT NULL,
    VALID_TO                TIMESTAMP(3)    DEFAULT SYSTIMESTAMP    NOT NULL,
    NAME                    NVARCHAR2(200)  DEFAULT ' '             NOT NULL,
    MESSAGE                 NVARCHAR2(2000) DEFAULT ' '             NOT NULL,
    ATTACHMENT_TYPE         NVARCHAR2(200)                          NULL,
    ATTACHMENT              BLOB                                    NULL,
    USER_FILTER             NVARCHAR2(200)                          NULL,
    PROFILE_FILTER          INTEGER                                 NULL,
    STATION_FILTER          NVARCHAR2(200)                          NULL,
    CONSTRAINT DESKTOPFX_MULTICAST_PK PRIMARY KEY (ID)
);

CREATE SEQUENCE DESKTOPFX_MULTICAST_SQ
    START WITH   1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

--------------------------------------------------------------------------------
-- DESKTOPFX_MRESPONSE ---------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE DESKTOPFX_MRESPONSE
(
    ID                      DECIMAL(19)     DEFAULT 0               NOT NULL,
    MULTICAST_ID            DECIMAL(19)     DEFAULT 0               NOT NULL,
    STATION_CODE            NVARCHAR2(200)  DEFAULT ' '             NOT NULL,
    REQUEST_TIME            TIMESTAMP(3)    DEFAULT SYSTIMESTAMP    NOT NULL,
    RESPONSE_TIME           TIMESTAMP(3)    DEFAULT SYSTIMESTAMP    NOT NULL,
    MESSAGE                 NVARCHAR2(2000) DEFAULT ' '             NOT NULL,
    ATTACHMENT_TYPE         NVARCHAR2(200)                          NULL,
    ATTACHMENT              BLOB                                    NULL,
    CONSTRAINT DESKTOPFX_MRESPONSE_PK PRIMARY KEY (ID),
    CONSTRAINT DESKTOPFX_MRESPONSE_FK FOREIGN KEY (MULTICAST_ID)
        REFERENCES DESKTOPFX_MULTICAST(ID) ON DELETE CASCADE
);

CREATE SEQUENCE DESKTOPFX_MRESPONSE_SQ
    START WITH   1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

--------------------------------------------------------------------------------

COMMIT;
QUIT;
