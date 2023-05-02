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

SET IDENTITY_INSERT dbo.DEPARTAMENTOS ON
GO

INSERT INTO dbo.DEPARTAMENTOS (
    ID, NOMBRE, DIRECCION, CIUDAD, TELEFONO
) VALUES (
     1
    ,N'Comercial'
    ,N'La Calle'
    ,N'Santiago'
    ,N'510-4561'
)
GO

INSERT INTO dbo.DEPARTAMENTOS (
    ID, NOMBRE, DIRECCION, CIUDAD, TELEFONO
) VALUES (
     2
    ,N'Productos'
    ,N'Otra Calle'
    ,N'Valdivia'
    ,N'765-4567'
)
GO

SET IDENTITY_INSERT dbo.DEPARTAMENTOS OFF
GO

--------------------------------------------------------------------------------
-- EMPLEADOS -------------------------------------------------------------------
--------------------------------------------------------------------------------

INSERT INTO dbo.EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     1
    ,N'Pedro'
    ,N'Muñoz' 
    ,N'Boysen'
    ,N'2-7'
    ,CONVERT(DATETIME, '1957.06.23', 102)
    ,560000
)
GO

INSERT INTO dbo.EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     1
    ,N'Jaime'
    ,N'Realmente'
    ,N'Lentito'
    ,N'1-9'
    ,CONVERT(DATETIME, '1975.02.15', 102)
    ,750000
)
GO

INSERT INTO dbo.EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     1
    ,N'Vanessa'
    ,N'Casi'
    ,N'Mira'
    ,N'3-5'
    ,CONVERT(DATETIME, '1970.10.23', 102)
    ,1350000
)
GO

INSERT INTO dbo.EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     1
    ,N'María'
    ,N'Westerdahl'
    ,N'Peña'
    ,N'4-3'
    ,CONVERT(DATETIME, '1960.09.07', 102)
    ,2100000
)
GO

INSERT INTO dbo.EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     1
    ,N'Rafaela'
    ,N'Sefue'
    ,N'Ayer'
    ,N'5-1'
    ,CONVERT(DATETIME, '1965.09.07', 102)
    ,780000
)
GO

INSERT INTO dbo.EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     1
    ,N'Pablo'
    ,N'Salta'
    ,N'Cerca'
    ,N'6-K'
    ,CONVERT(DATETIME, '1968.03.14', 102)
    ,2100000
)
GO

INSERT INTO dbo.EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     1
    ,N'Teresa'
    ,N'Ayer'
    ,N'Novino'
    ,N'7-8'
    ,CONVERT(DATETIME, '1993.10.21', 102)
    ,1350000
)
GO

INSERT INTO dbo.EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     1
    ,N'Cecilia'
    ,N'Pótamo'
    ,N'Hagberg'
    ,N'8-6'
    ,CONVERT(DATETIME, '1989.04.25', 102)
    ,1350000
)
GO

INSERT INTO dbo.EMPLEADOS (
    DEPT_ID, NOMBRE, PATERNO, MATERNO, RUT, NACIMIENTO, SUELDO
) VALUES (
     1
    ,N'Arturo'
    ,N'Llega'
    ,N'Mañana'
    ,N'9-4'
    ,CONVERT(DATETIME, '1991.08.19', 102)
    ,780000
)
GO

--------------------------------------------------------------------------------
