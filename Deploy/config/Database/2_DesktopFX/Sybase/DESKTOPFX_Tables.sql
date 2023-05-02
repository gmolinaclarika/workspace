--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------

IF EXISTS(SELECT * FROM sysobjects WHERE name = 'DESKTOPFX_MRESPONSE' AND type = 'U')
    DROP TABLE DESKTOPFX_MRESPONSE
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'DESKTOPFX_MULTICAST' AND type = 'U')
    DROP TABLE DESKTOPFX_MULTICAST
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'DESKTOPFX_PLUGIN' AND type = 'U')
    DROP TABLE DESKTOPFX_PLUGIN
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'DESKTOPFX_OBJECT' AND type = 'U')
    DROP TABLE DESKTOPFX_OBJECT
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'DESKTOPFX_LOGIN' AND type = 'U')
    DROP TABLE DESKTOPFX_LOGIN
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'DESKTOPFX_USER' AND type = 'U')
    DROP TABLE DESKTOPFX_USER
GO

--------------------------------------------------------------------------------
-- DESKTOPFX_USER --------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE DESKTOPFX_USER
(
    ID                  BIGINT          NOT NULL    IDENTITY,
    USER_CODE           NVARCHAR(200)   NOT NULL    DEFAULT '',
    SERVICE_NAME        NVARCHAR(200)   NOT NULL    DEFAULT 'SERVICE',
    STATION_CODE        NVARCHAR(200)   NOT NULL    DEFAULT '',
    LAST_POLL           DATETIME        NOT NULL    DEFAULT GETDATE(),
    CONSTRAINT DESKTOPFX_USER_PK PRIMARY KEY NONCLUSTERED (ID),
    CONSTRAINT DESKTOPFX_USER_IX UNIQUE CLUSTERED (USER_CODE)
)
GO

--------------------------------------------------------------------------------
-- DESKTOPFX_LOGIN -------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE DESKTOPFX_LOGIN
(
    ID                  BIGINT          NOT NULL    IDENTITY,
    USER_ID             BIGINT          NOT NULL    DEFAULT 0,
    PROFILE_CODE        INTEGER         NOT NULL    DEFAULT 0,
    LOGIN_STATE         IMAGE           NULL,
    CONSTRAINT DESKTOPFX_LOGIN_PK PRIMARY KEY NONCLUSTERED (ID),
    CONSTRAINT DESKTOPFX_LOGIN_IX UNIQUE CLUSTERED (USER_ID,PROFILE_CODE),
    CONSTRAINT DESKTOPFX_LOGIN_FK FOREIGN KEY (USER_ID)
        REFERENCES DESKTOPFX_USER(ID) -- ON DELETE CASCADE
)
GO

--------------------------------------------------------------------------------
-- DESKTOPFX_OBJECT ------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE DESKTOPFX_OBJECT
(
    ID                  BIGINT          NOT NULL    IDENTITY,
    LOGIN_ID            BIGINT          NOT NULL    DEFAULT 0,
    NAME                NVARCHAR(200)   NOT NULL    DEFAULT '',
    MODIFIED            DATETIME        NOT NULL    DEFAULT GETDATE(),
    TYPE                INTEGER         NOT NULL    DEFAULT 0,
    BYTES               IMAGE           NULL,
    CONSTRAINT DESKTOPFX_OBJECT_PK PRIMARY KEY NONCLUSTERED (ID),
    CONSTRAINT DESKTOPFX_OBJECT_IX UNIQUE CLUSTERED (LOGIN_ID,TYPE,NAME),
    CONSTRAINT DESKTOPFX_OBJECT_FK FOREIGN KEY (LOGIN_ID)
        REFERENCES DESKTOPFX_LOGIN(ID) -- ON DELETE CASCADE
)
GO

--------------------------------------------------------------------------------
-- DESKTOPFX_PLUGIN ------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE DESKTOPFX_PLUGIN
(
    ID                  BIGINT          NOT NULL    IDENTITY,
    NAME                NVARCHAR(200)   NOT NULL    DEFAULT '',
    MODIFIED            DATETIME        NOT NULL    DEFAULT GETDATE(),
    ENABLED             INTEGER         NOT NULL    DEFAULT 0,
    XML                 UNITEXT         NOT NULL    DEFAULT '',
    CONSTRAINT DESKTOPFX_PLUGIN_PK PRIMARY KEY NONCLUSTERED (ID),
    CONSTRAINT DESKTOPFX_PLUGIN_IX UNIQUE CLUSTERED (NAME)
)
GO

--------------------------------------------------------------------------------
-- DESKTOPFX_MULTICAST ---------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE DESKTOPFX_MULTICAST
(
    ID                  BIGINT          NOT NULL    IDENTITY,
    VALID_FROM          DATETIME        NOT NULL    DEFAULT GETDATE(),
    VALID_TO            DATETIME        NOT NULL    DEFAULT GETDATE(),
    NAME                NVARCHAR(200)   NOT NULL    DEFAULT '',
    MESSAGE             NVARCHAR(1000)  NOT NULL    DEFAULT '',
    ATTACHMENT_TYPE     NVARCHAR(200)   NULL,
    ATTACHMENT          IMAGE           NULL,
    USER_FILTER         NVARCHAR(200)   NULL,
    PROFILE_FILTER      INTEGER         NULL,
    STATION_FILTER      NVARCHAR(200)   NULL,
    CONSTRAINT DESKTOPFX_MULTICAST_PK PRIMARY KEY CLUSTERED (ID)
)
GO

--------------------------------------------------------------------------------
-- DESKTOPFX_MRESPONSE ---------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE DESKTOPFX_MRESPONSE
(
    ID                  BIGINT          NOT NULL    IDENTITY,
    MULTICAST_ID        BIGINT          NOT NULL    DEFAULT 0,
    STATION_CODE        NVARCHAR(200)   NOT NULL    DEFAULT '',
    REQUEST_TIME        DATETIME        NOT NULL    DEFAULT GETDATE(),
    RESPONSE_TIME       DATETIME        NOT NULL    DEFAULT GETDATE(),
    MESSAGE             NVARCHAR(1000)  NOT NULL    DEFAULT '',
    ATTACHMENT_TYPE     NVARCHAR(200)   NULL,
    ATTACHMENT          IMAGE           NULL,
    CONSTRAINT DESKTOPFX_MRESPONSE_PK PRIMARY KEY CLUSTERED (ID),
    CONSTRAINT DESKTOPFX_MRESPONSE_FK FOREIGN KEY (MULTICAST_ID)
        REFERENCES DESKTOPFX_MULTICAST(ID) -- ON DELETE CASCADE
)
GO

--------------------------------------------------------------------------------
