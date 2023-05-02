--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------

IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.EMPLEADOS') AND type in (N'U'))
    DROP TABLE dbo.EMPLEADOS
GO
IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.DEPARTAMENTOS') AND type in (N'U'))
    DROP TABLE dbo.DEPARTAMENTOS
GO

--------------------------------------------------------------------------------
-- DEPARTAMENTOS ---------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE dbo.DEPARTAMENTOS
(
    ID              DECIMAL(19)     IDENTITY        NOT NULL,
    NOMBRE          NVARCHAR(50)    DEFAULT ''      NOT NULL,
    DIRECCION       NVARCHAR(100)   DEFAULT ''      NOT NULL,
    CIUDAD          NVARCHAR(25)    DEFAULT ''      NOT NULL,
    TELEFONO        NVARCHAR(15)    DEFAULT ''      NOT NULL,
    CONSTRAINT DEPARTAMENTOS_PK PRIMARY KEY NONCLUSTERED (ID),
    CONSTRAINT DEPARTAMENTOS_IX UNIQUE CLUSTERED (NOMBRE)
)
GO

--------------------------------------------------------------------------------
-- EMPLEADOS -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE dbo.EMPLEADOS
(
    ID              DECIMAL(19)     IDENTITY        NOT NULL,
    DEPT_ID         DECIMAL(19)     DEFAULT 0       NOT NULL,
    NOMBRE          NVARCHAR(50)    DEFAULT ''      NOT NULL,
    PATERNO         NVARCHAR(50)    DEFAULT ''      NOT NULL,
    MATERNO         NVARCHAR(50)    DEFAULT ''      NOT NULL,
    RUT             NVARCHAR(10)    DEFAULT ''      NOT NULL,
    NACIMIENTO      DATETIME        DEFAULT 0       NOT NULL,
    SUELDO          DECIMAL(10)     DEFAULT 0       NOT NULL,
    CONSTRAINT EMPLEADOS_PK PRIMARY KEY NONCLUSTERED (ID),
    CONSTRAINT EMPLEADOS_IX UNIQUE CLUSTERED (RUT),
    CONSTRAINT EMPLEADOS_FK FOREIGN KEY (DEPT_ID)
        REFERENCES dbo.DEPARTAMENTOS (ID) ON DELETE CASCADE
)
GO

--------------------------------------------------------------------------------
