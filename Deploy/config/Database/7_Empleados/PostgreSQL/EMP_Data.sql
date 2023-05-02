--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- DEPARTAMENTOS ---------------------------------------------------------------
--------------------------------------------------------------------------------

INSERT INTO departamentos (
    id, nombre, direccion, ciudad, telefono
) VALUES (
     0
    ,'Comercial'
    ,'La Calle'
    ,'Santiago'
    ,'510-4561'
);

INSERT INTO departamentos (
    id, nombre, direccion, ciudad, telefono
) VALUES (
     1
    ,'Productos'
    ,'Otra Calle'
    ,'Valdivia'
    ,'765-4567'
);

--------------------------------------------------------------------------------
-- EMPLEADOS -------------------------------------------------------------------
--------------------------------------------------------------------------------

INSERT INTO empleados (
    dept_id, nombre, paterno, materno, rut, nacimiento, sueldo
) VALUES (
    0, 
    'Pedro', 
    'Muñoz', 
    'Boysen', 
    '2-7', 
    to_timestamp('23-06-1957', 'DD-MM-YYYY'), 
    560000
);

INSERT INTO empleados (
    dept_id, nombre, paterno, materno, rut, nacimiento, sueldo
) VALUES (
    0, 
    'Jaime', 
    'Realmente', 
    'Lentito', 
    '1-9', 
    to_timestamp('15-02-1975', 'DD-MM-YYYY'), 
    750000
);

INSERT INTO empleados (
    dept_id, nombre, paterno, materno, rut, nacimiento, sueldo
) VALUES (
    0, 
    'Vanessa', 
    'Casi', 
    'Mira', 
    '3-5', 
    to_timestamp('23-10-1970', 'DD-MM-YYYY'), 
    1350000
);

INSERT INTO empleados (
    dept_id, nombre, paterno, materno, rut, nacimiento, sueldo
) VALUES (
    0, 
    'María', 
    'Westerdahl', 
    'Peña', 
    '4-3', 
    to_timestamp('07-09-1960', 'DD-MM-YYYY'), 
    2100000
);

INSERT INTO empleados (
    dept_id, nombre, paterno, materno, rut, nacimiento, sueldo
) VALUES (
    0, 
    'Rafaela', 
    'Sefue', 
    'Ayer', 
    '5-1', 
    to_timestamp('07-09-1965', 'DD-MM-YYYY'), 
    780000
);

INSERT INTO empleados (
    dept_id, nombre, paterno, materno, rut, nacimiento, sueldo
) VALUES (
    0, 
    'Pablo', 
    'Salta', 
    'Cerca', 
    '6-K', 
    to_timestamp('14-03-1968', 'DD-MM-YYYY'), 
    2100000
);

INSERT INTO empleados (
    dept_id, nombre, paterno, materno, rut, nacimiento, sueldo
) VALUES (
    0, 
    'Teresa', 
    'Ayer', 
    'Novino', 
    '7-8', 
    to_timestamp('21-10-1993', 'DD-MM-YYYY'), 
    1350000
);

INSERT INTO empleados (
    dept_id, nombre, paterno, materno, rut, nacimiento, sueldo
) VALUES (
    0, 
    'Cecilia', 
    'Pótamo', 
    'Hagberg', 
    '8-6', 
    to_timestamp('25-04-1989', 'DD-MM-YYYY'), 
    1350000
);

INSERT INTO empleados (
    dept_id, nombre, paterno, materno, rut, nacimiento, sueldo
) VALUES (
    0, 
    'Arturo', 
    'Llega', 
    'Mañana', 
    '9-4', 
    to_timestamp('19-08-1991', 'DD-MM-YYYY'), 
    780000
);

--------------------------------------------------------------------------------
