-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------

DROP TABLE IF EXISTS EMPLEADOS;
DROP TABLE IF EXISTS DEPARTAMENTOS;

-- -----------------------------------------------------------------------------
-- DEPARTAMENTOS ---------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS DEPARTAMENTOS
(
    ID                      BIGINT          NOT NULL    AUTO_INCREMENT,
    NOMBRE                  VARCHAR(50)     NOT NULL    DEFAULT '',
    DIRECCION               VARCHAR(100)    NOT NULL    DEFAULT '',
    CIUDAD                  VARCHAR(25)     NOT NULL    DEFAULT '',
    TELEFONO                VARCHAR(15)     NOT NULL    DEFAULT '',
    CONSTRAINT DEPARTAMENTOS_PK PRIMARY KEY (ID),
    CONSTRAINT DEPARTAMENTOS_IX UNIQUE (NOMBRE)
);

-- -----------------------------------------------------------------------------
-- EMPLEADOS -------------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS EMPLEADOS
(
    ID                      BIGINT          NOT NULL    AUTO_INCREMENT,
    DEPT_ID                 BIGINT          NOT NULL    DEFAULT 0,
    NOMBRE                  VARCHAR(50)     NOT NULL    DEFAULT '',
    PATERNO                 VARCHAR(50)     NOT NULL    DEFAULT '',
    MATERNO                 VARCHAR(50)     NOT NULL    DEFAULT '',
    RUT                     VARCHAR(10)     NOT NULL    DEFAULT '',
    NACIMIENTO              DATETIME(3)     NOT NULL    DEFAULT '1000-01-01 00:00:00',
    SUELDO                  DECIMAL(10)     NOT NULL    DEFAULT 0,
    CONSTRAINT EMPLEADOS_PK PRIMARY KEY (ID),
    CONSTRAINT EMPLEADOS_IX UNIQUE (RUT),
    CONSTRAINT EMPLEADOS_FK FOREIGN KEY (DEPT_ID)
        REFERENCES DEPARTAMENTOS (ID) ON DELETE CASCADE
);

-- -----------------------------------------------------------------------------
