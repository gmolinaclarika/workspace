CREATE OR REPLACE PROCEDURE SECURITYFX$DOMAIN_GET
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
    WSS_USER_CODE$          IN  NVARCHAR2,
    WSS_PROFILE_CODE$       IN  INTEGER,
    WSS_STATION_CODE$       IN  NVARCHAR2,
    --------------------------------------
    DOMAIN_NAME$            IN  NVARCHAR2,
    -- General Properties
    NAME$                   OUT NVARCHAR2,
    FUNCTION$               OUT NVARCHAR2,
    LOCATION$               OUT NVARCHAR2,
    TEXT1$                  OUT NVARCHAR2,
    TEXT2$                  OUT NVARCHAR2,
    TEXT3$                  OUT NVARCHAR2,
    TEXT4$                  OUT NVARCHAR2
)
AS
    V_FAM_FAMILIA$          EcuACCFAM.V_FAM_FAMILIA%TYPE;
BEGIN
    -- Normalize specified domain name
    V_FAM_FAMILIA$ := UPPER(RTRIM(DOMAIN_NAME$));

    -- Returns the properties of the domain
    BEGIN
        SELECT
            -- General Properties
            RTRIM(V_FAM_FAMILIA),
            RTRIM(V_FAM_NOMBRE_USUARIO),
            RTRIM(V_FAM_UBICACION),
            RTRIM(V_FAM_TEXTO1),
            RTRIM(V_FAM_TEXTO2),
            RTRIM(V_FAM_TEXTO3),
            RTRIM(V_FAM_TEXTO4)
        INTO
            -- General Properties
            NAME$,
            FUNCTION$,
            LOCATION$,
            TEXT1$,
            TEXT2$,
            TEXT3$,
            TEXT4$
        FROM   EcuACCFAM
        WHERE  V_FAM_FAMILIA = V_FAM_FAMILIA$;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Dominio no está definido: ' || DOMAIN_NAME$);
    END;
END SECURITYFX$DOMAIN_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
