--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------

DROP TABLE EMPLEADOS CASCADE CONSTRAINTS;
DROP SEQUENCE EMPLEADOS_SEQ;

DROP TABLE DEPARTAMENTOS CASCADE CONSTRAINTS;
DROP SEQUENCE DEPARTAMENTOS_SEQ;

--------------------------------------------------------------------------------
-- DEPARTAMENTOS ---------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE DEPARTAMENTOS
(
    ID                      DECIMAL(19)     DEFAULT 0       NOT NULL,
    NOMBRE                  NVARCHAR2(50)   DEFAULT ' '     NOT NULL,
    DIRECCION               NVARCHAR2(100)  DEFAULT ' '     NOT NULL,
    CIUDAD                  NVARCHAR2(25)   DEFAULT ' '     NOT NULL,
    TELEFONO                NVARCHAR2(15)   DEFAULT ' '     NOT NULL,
    CONSTRAINT DEPARTAMENTOS_PK PRIMARY KEY (ID)
);

CREATE UNIQUE INDEX DEPARTAMENTOS_UK
    ON DEPARTAMENTOS (NOMBRE);

CREATE SEQUENCE DEPARTAMENTOS_SEQ
    START WITH  10
    INCREMENT BY 1
    MINVALUE     1
    NOCYCLE 
    NOCACHE;

--------------------------------------------------------------------------------
-- EMPLEADOS -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EMPLEADOS
(
    ID                      DECIMAL(19)     DEFAULT  0      NOT NULL,
    DEPT_ID                 DECIMAL(19)     DEFAULT  0      NOT NULL,
    NOMBRE                  NVARCHAR2(50)   DEFAULT ' '     NOT NULL, 
    PATERNO                 NVARCHAR2(50)   DEFAULT ' '     NOT NULL,
    MATERNO                 NVARCHAR2(50)   DEFAULT ' '     NOT NULL,
    RUT                     NVARCHAR2(10)   DEFAULT ' '     NOT NULL,
    NACIMIENTO              TIMESTAMP       DEFAULT     
        TO_DATE('01-01-0001', 'DD-MM-YYYY')                 NOT NULL,
    SUELDO                  NUMBER(10)      DEFAULT  0      NOT NULL,
    CONSTRAINT EMPLEADOS_PK PRIMARY KEY (ID),
    CONSTRAINT EMPLEADOS_FK FOREIGN KEY (DEPT_ID)
        REFERENCES DEPARTAMENTOS (ID) ON DELETE CASCADE
);

CREATE UNIQUE INDEX EMPLEADOS_UK
    ON EMPLEADOS (RUT);

CREATE SEQUENCE EMPLEADOS_SEQ
    START WITH  10
    INCREMENT BY 1
    MINVALUE     1
    NOCYCLE 
    NOCACHE;

--------------------------------------------------------------------------------

COMMIT;
QUIT;
