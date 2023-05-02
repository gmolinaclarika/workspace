-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- DEPARTAMENTOS ---------------------------------------------------------------
-- -----------------------------------------------------------------------------

INSERT INTO DEPARTAMENTOS (
    ID, NOMBRE, DIRECCION, CIUDAD, TELEFONO
) VALUES (
     1
    ,'Comercial'
    ,'La Calle'
    ,'Santiago'
    ,'510-4561'
);

INSERT INTO DEPARTAMENTOS (
    ID, NOMBRE, DIRECCION, CIUDAD, TELEFONO
) VALUES (
     2
    ,'Productos'
    ,'Otra Calle'
    ,'Valdivia'
    ,'765-4567'
);

-- -----------------------------------------------------------------------------
-- EMPLEADOS -------------------------------------------------------------------
-- -----------------------------------------------------------------------------

INSERT INTO EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     1
    ,'Pedro'
    ,'Muñoz' 
    ,'Boysen'
    ,'2-7'
    ,STR_TO_DATE('1957-06-23', '%Y-%m-%d')
    ,560000
);

INSERT INTO EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     1
    ,'Jaime'
    ,'Realmente'
    ,'Lentito'
    ,'1-9'
    ,STR_TO_DATE('1975-02-15', '%Y-%m-%d')
    ,750000
);

INSERT INTO EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     1
    ,'Vanessa'
    ,'Casi'
    ,'Mira'
    ,'3-5'
    ,STR_TO_DATE('1970-10-23', '%Y-%m-%d')
    ,1350000
);

INSERT INTO EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     2
    ,'María'
    ,'Westerdahl'
    ,'Peña'
    ,'4-3'
    ,STR_TO_DATE('1960-09-07', '%Y-%m-%d')
    ,2100000
);

INSERT INTO EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     1
    ,'Rafaela'
    ,'Sefue'
    ,'Ayer'
    ,'5-1'
    ,STR_TO_DATE('1965-09-07', '%Y-%m-%d')
    ,780000
);

INSERT INTO EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     1
    ,'Pablo'
    ,'Salta'
    ,'Cerca'
    ,'6-K'
    ,STR_TO_DATE('1968-03-14', '%Y-%m-%d')
    ,2100000
);

INSERT INTO EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     1
    ,'Teresa'
    ,'Ayer'
    ,'Novino'
    ,'7-8'
    ,STR_TO_DATE('1993-10-21', '%Y-%m-%d')
    ,1350000
);

INSERT INTO EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     1
    ,'Cecilia'
    ,'Pótamo'
    ,'Hagberg'
    ,'8-6'
    ,STR_TO_DATE('1989-04-25', '%Y-%m-%d')
    ,1350000
);

INSERT INTO EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     1
    ,'Arturo'
    ,'Llega'
    ,'Mañana'
    ,'9-4'
    ,STR_TO_DATE('1991-08-19', '%Y-%m-%d')
    ,780000
);

-- -----------------------------------------------------------------------------
