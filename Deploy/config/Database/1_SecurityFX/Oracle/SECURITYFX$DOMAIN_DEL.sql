CREATE OR REPLACE PROCEDURE SECURITYFX$DOMAIN_DEL
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
    DOMAIN_NAME$            IN  NVARCHAR2
)
AS
    V_FAM_FAMILIA$          EcuACCFAM.V_FAM_FAMILIA%TYPE;
    COUNT$                  INTEGER;
BEGIN
    -- Normalize specified domain name
    V_FAM_FAMILIA$ := UPPER(RTRIM(DOMAIN_NAME$));
    IF (V_FAM_FAMILIA$ = 'GENERAL') THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se puede borrar el dominio ' || V_FAM_FAMILIA$);
    END IF;

    -- Check the domain is not assigned to a user
    SELECT COUNT(*) INTO COUNT$ FROM EcuACCUSU WHERE FAMILIA = V_FAM_FAMILIA$ AND ROWNUM = 1;
    IF (COUNT$ > 0) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Dominio ' || V_FAM_FAMILIA$ || ' está asignado a uno o más usuarios');
    END IF;

    -- Check the domain is not assigned to a profile
    SELECT COUNT(*) INTO COUNT$ FROM EcuACCPER WHERE V_ACC_FAMILIA = V_FAM_FAMILIA$ AND ROWNUM = 1;
    IF (COUNT$ > 0) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Dominio ' || V_FAM_FAMILIA$ || ' está asignado a uno o más perfiles');
    END IF;

    -- Check the domain is not assigned to a terminal
    SELECT COUNT(*) INTO COUNT$ FROM EcuACCNET WHERE V_NET_FAMILIA = V_FAM_FAMILIA$ AND ROWNUM = 1;
    IF (COUNT$ > 0) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Dominio ' || V_FAM_FAMILIA$ || ' está asignado a uno o más terminales');
    END IF;

    -- Delete the properties of specified domain
    DELETE FROM EcuACCFAM
    WHERE  V_FAM_FAMILIA = V_FAM_FAMILIA$;

    -- Generate an audit record
    SECURITYFX$AUDIT_PUT(
        WSS_USER_CODE$, WSS_PROFILE_CODE$, WSS_STATION_CODE$, 
        12, 'Familia fue eliminada: ' || V_FAM_FAMILIA$);
END SECURITYFX$DOMAIN_DEL;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
