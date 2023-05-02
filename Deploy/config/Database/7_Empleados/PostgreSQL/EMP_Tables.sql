--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------

DROP TABLE IF EXISTS empleados CASCADE;
DROP TABLE IF EXISTS departamentos CASCADE;

--------------------------------------------------------------------------------
-- departamentos ---------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE departamentos
(
    id                      BIGSERIAL       NOT NULL,
    nombre                  VARCHAR(50)     NOT NULL    DEFAULT '',
    direccion               VARCHAR(100)    NOT NULL    DEFAULT '',
    ciudad                  VARCHAR(25)     NOT NULL    DEFAULT '',
    telefono                VARCHAR(15)     NOT NULL    DEFAULT '',
    CONSTRAINT departamentos_pk PRIMARY KEY (id)
);

--------------------------------------------------------------------------------
-- empleados -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE empleados
(
    id                      BIGSERIAL       NOT NULL,
    dept_id                 BIGINT          NOT NULL    DEFAULT 0,
    nombre                  VARCHAR(50)     NOT NULL    DEFAULT '', 
    paterno                 VARCHAR(50)     NOT NULL    DEFAULT '',
    materno                 VARCHAR(50)     NOT NULL    DEFAULT '',
    rut                     VARCHAR(10)     NOT NULL    DEFAULT '',
    nacimiento              TIMESTAMP       NOT NULL    DEFAULT to_timestamp('01-01-0001', 'DD-MM-YYYY'),
    sueldo                  DECIMAL(10)     NOT NULL    DEFAULT 0,
    CONSTRAINT empleados_pk PRIMARY KEY (id),
    CONSTRAINT empleados_uk UNIQUE (rut),
    CONSTRAINT empleados_fk FOREIGN KEY (dept_id)
        REFERENCES departamentos (id) ON DELETE CASCADE
);

--------------------------------------------------------------------------------
