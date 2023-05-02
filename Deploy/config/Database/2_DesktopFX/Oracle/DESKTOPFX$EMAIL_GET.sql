CREATE OR REPLACE PROCEDURE DESKTOPFX$EMAIL_GET
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
(
    USER_CODE$      IN  NVARCHAR2,
    EMAIL_ADDR$     OUT NVARCHAR2
) 
AS
    USU_CODIGO$     ECUACCUSU.USU_CODIGO%TYPE;
    USU_ESTADO$     ECUACCUSU.USU_ESTADO%TYPE;
    PSW_TIPO$       ECUACCUSU.PSW_TIPO%TYPE;
BEGIN
    -- Normalize specified user name
    USU_CODIGO$ := UPPER(RTRIM(USER_CODE$));

    -- Obtain properties of specified user
    BEGIN
        SELECT USU_ESTADO, PSW_TIPO, RTRIM(EMAIL)
        INTO   USU_ESTADO$, PSW_TIPO$, EMAIL_ADDR$
        FROM   ECUACCUSU
        WHERE  USU_CODIGO = USU_CODIGO$;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Usuario especificado no está definido');
    END;

    -- Check the user is not disabled ('HA'=habilitado)
    IF (USU_ESTADO$ != 'HA') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Usuario especificado no está habilitado');
    END IF;

    -- Check user can change password ('CAD'=caducado,'NCA'=no-caducado)
    IF (PSW_TIPO$ != 'CAD' AND PSW_TIPO$ != 'NCA') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Usuario no puede cambiar la contraseña');
    END IF;

    -- Check the user has an E-mail address
    IF (EMAIL_ADDR$ IS NULL) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Usuario no tiene una dirección de correo');
    END IF;
END DESKTOPFX$EMAIL_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
