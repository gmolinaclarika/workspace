--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------

IF EXISTS(SELECT * FROM sysobjects WHERE name = 'EMPLEADOS' AND type = 'U')
    DROP TABLE EMPLEADOS
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'DEPARTAMENTOS' AND type = 'U')
    DROP TABLE DEPARTAMENTOS
GO

--------------------------------------------------------------------------------
-- DEPARTAMENTOS ---------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE DEPARTAMENTOS
(
    ID                      DECIMAL(19)     NOT NULL    IDENTITY,
    NOMBRE                  NVARCHAR(50)    NOT NULL    DEFAULT '',
    DIRECCION               NVARCHAR(100)   NOT NULL    DEFAULT '',
    CIUDAD                  NVARCHAR(25)    NOT NULL    DEFAULT '',
    TELEFONO                NVARCHAR(15)    NOT NULL    DEFAULT '',
    CONSTRAINT DEPARTAMENTOS_PK PRIMARY KEY NONCLUSTERED (ID),
    CONSTRAINT DEPARTAMENTOS_IX UNIQUE CLUSTERED (NOMBRE)
)
GO

--------------------------------------------------------------------------------
-- EMPLEADOS -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EMPLEADOS
(
    ID                      DECIMAL(19)     NOT NULL    IDENTITY,
    DEPT_ID                 DECIMAL(19)     NOT NULL    DEFAULT 0,
    NOMBRE                  NVARCHAR(50)    NOT NULL    DEFAULT '',
    PATERNO                 NVARCHAR(50)    NOT NULL    DEFAULT '',
    MATERNO                 NVARCHAR(50)    NOT NULL    DEFAULT '',
    RUT                     NVARCHAR(10)    NOT NULL    DEFAULT '',
    NACIMIENTO              DATETIME        NOT NULL    DEFAULT 0,
    SUELDO                  DECIMAL(10)     NOT NULL    DEFAULT 0,
    CONSTRAINT EMPLEADOS_PK PRIMARY KEY NONCLUSTERED (ID),
    CONSTRAINT EMPLEADOS_IX UNIQUE CLUSTERED (RUT),
    CONSTRAINT EMPLEADOS_FK FOREIGN KEY (DEPT_ID)
        REFERENCES dbo.DEPARTAMENTOS (ID) --ON DELETE CASCADE
)
GO

--------------------------------------------------------------------------------
