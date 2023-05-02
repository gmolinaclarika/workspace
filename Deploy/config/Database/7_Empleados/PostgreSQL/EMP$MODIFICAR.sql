CREATE OR REPLACE FUNCTION emp$modificar (
    _emp_id             IN  DECIMAL,
    _nombre             IN  VARCHAR,
    _paterno            IN  VARCHAR,
    _materno            IN  VARCHAR,
    _rut                IN  VARCHAR,
    _nacimiento         IN  TIMESTAMP,
    _sueldo             IN  DECIMAL
) RETURNS void
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

    -- Modificamos el Empleado
    UPDATE empleados
       SET nombre     = _nombre,
           paterno    = _paterno,
           materno    = _materno,
           rut        = _rut,
           nacimiento = _nacimiento,
           sueldo     = _sueldo
    WHERE  id = _emp_id;
END;
$BODY$ LANGUAGE plpgsql;
