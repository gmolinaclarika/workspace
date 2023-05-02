CREATE OR REPLACE PROCEDURE SECURITYFX$PROFILE_DEL
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
    PROFILE_CODE$           IN INTEGER
)
AS
BEGIN
    -- Cannot delete ADMIN (0) profile
    IF (PROFILE_CODE$ = 0) THEN
        RAISE_APPLICATION_ERROR(-20001, 'No puede borrar el perfil: ' || PROFILE_CODE$);
    END IF;

    -- Delete all users of the profile
    DELETE FROM EcuACCU2P
    WHERE CODIGO_ECU = PROFILE_CODE$;

    -- Delete all capacities of the profile
    DELETE FROM EcuACCC2P
    WHERE CODIGO_ECU = PROFILE_CODE$;

    -- Delete the properties of the profile
    DELETE FROM EcuACCPER
    WHERE  V_ACC_CODE_NUM = PROFILE_CODE$;

    -- Generate an audit record
    SECURITYFX$AUDIT_PUT(
        WSS_USER_CODE$, WSS_PROFILE_CODE$, WSS_STATION_CODE$,
        57, 'Perfil fue eliminado: ' || PROFILE_CODE$);
END SECURITYFX$PROFILE_DEL;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
