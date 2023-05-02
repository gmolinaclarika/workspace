CREATE OR REPLACE PROCEDURE SECURITYFX$DOMAIN_PUT
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
    FUNCTION$               IN  NVARCHAR2,
    LOCATION$               IN  NVARCHAR2,
    TEXT1$                  IN  NVARCHAR2,
    TEXT2$                  IN  NVARCHAR2,
    TEXT3$                  IN  NVARCHAR2,
    TEXT4$                  IN  NVARCHAR2,
    CREATED$                OUT INTEGER
)
AS
    V_FAM_FAMILIA$          EcuACCFAM.V_FAM_FAMILIA%TYPE;
BEGIN
    -- Asume the domain exists
    CREATED$ := 0;

    -- Normalize specified domain name
    V_FAM_FAMILIA$ := UPPER(RTRIM(DOMAIN_NAME$));

    -- Update the properties of specified domain
    UPDATE EcuACCFAM
    SET    V_FAM_NOMBRE_USUARIO = NVL(FUNCTION$,' '),
           V_FAM_UBICACION      = NVL(LOCATION$,' '),
           V_FAM_TEXTO1         = NVL(TEXT1$,' '),
           V_FAM_TEXTO2         = NVL(TEXT2$,' '),
           V_FAM_TEXTO3         = NVL(TEXT3$,' '),
           V_FAM_TEXTO4         = NVL(TEXT4$,' ')
    WHERE  V_FAM_FAMILIA = V_FAM_FAMILIA$;

    -- Create domain if it didn't exist
    IF (SQL%ROWCOUNT = 0) THEN
        INSERT INTO EcuACCFAM (
             V_FAM_FAMILIA
            ,V_FAM_NOMBRE_USUARIO
            ,V_FAM_UBICACION
            ,V_FAM_TEXTO1
            ,V_FAM_TEXTO2
            ,V_FAM_TEXTO3
            ,V_FAM_TEXTO4
        ) VALUES (
             V_FAM_FAMILIA$
            ,NVL(FUNCTION$,' ')
            ,NVL(LOCATION$,' ')
            ,NVL(TEXT1$,' ')
            ,NVL(TEXT2$,' ')
            ,NVL(TEXT3$,' ')
            ,NVL(TEXT4$,' ')
        );
        CREATED$ := 1;
    END IF;

    -- Generate an audit record
    IF (CREATED$ = 0) THEN
        SECURITYFX$AUDIT_PUT(
            WSS_USER_CODE$, WSS_PROFILE_CODE$, WSS_STATION_CODE$, 
            15, 'Familia fue modificada: ' || DOMAIN_NAME$);
    ELSE
        SECURITYFX$AUDIT_PUT(
            WSS_USER_CODE$, WSS_PROFILE_CODE$, WSS_STATION_CODE$, 
            16, 'Familia fue creada: ' || DOMAIN_NAME$);
    END IF;
END SECURITYFX$DOMAIN_PUT;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
