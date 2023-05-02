CREATE OR REPLACE FUNCTION emp$crear (
    _nombre             IN  VARCHAR,
    _paterno            IN  VARCHAR,
    _materno            IN  VARCHAR,
    _rut                IN  VARCHAR,
    _nacimiento         IN  TIMESTAMP,
    _sueldo             IN  DECIMAL,
    _emp_id             OUT DECIMAL
)
AS $BODY$
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
BEGIN
    -- Removemos blancos sobrantes
    _nombre  := RTRIM(_nombre);
    _paterno := RTRIM(_paterno);
    _materno := RTRIM(_materno);
    _rut     := RTRIM(_rut);

    -- Verificamos el Nombre del Empleado
    IF (_nombre IS NULL) OR (_paterno IS NULL) OR (_materno IS NULL) THEN
        RAISE EXCEPTION 'Nombre del Empleado es inválido';
    END IF;

    -- Verificamos el RUT del Empleado
    IF (_rut IS NULL) OR (LEN(_rut) = 0) THEN
        RAISE EXCEPTION 'RUT del Empleado es inválido'; 
    END IF;

    -- Insertamos el nuevo Empleado
    WITH inserted AS (
        INSERT INTO empleados
            (dept_id, nombre, paterno, materno, rut, nacimiento, sueldo)
        VALUES
            (0, _nombre, _paterno, _materno, _rut, _nacimiento, _sueldo)
        RETURNING id)
    SELECT id INTO _emp_id FROM inserted;
END;
$BODY$ LANGUAGE plpgsql;
