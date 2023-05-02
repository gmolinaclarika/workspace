CREATE OR REPLACE PROCEDURE SECURITYFX$USER_DEL
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
    USER_CODE$              IN  NVARCHAR2
)
AS
    USU_CODIGO$             EcuACCUSU.USU_CODIGO%TYPE;
BEGIN
    -- Cannot delete ADMIN user
    USU_CODIGO$ := UPPER(RTRIM(USER_CODE$));
    IF (USU_CODIGO$ = 'ADMIN') THEN
        RAISE_APPLICATION_ERROR(-20001, 'No puede borrar el usuario: ' || USER_CODE$);
    END IF;

    -- Delete all profiles of the user
    DELETE FROM EcuACCU2P
    WHERE CODIGO_ADI = USU_CODIGO$;

    -- Delete all capacities of the user
    DELETE FROM EcuACCC2U
    WHERE CODIGO_ADI = USU_CODIGO$;

    -- Delete the properties of the user
    DELETE FROM EcuACCUSU
    WHERE  USU_CODIGO = USU_CODIGO$;

    -- Generate an audit record
    SECURITYFX$AUDIT_PUT(
        WSS_USER_CODE$, WSS_PROFILE_CODE$, WSS_STATION_CODE$,
        57, 'Usuario fue eliminado: ' || USER_CODE$);
END SECURITYFX$USER_DEL;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
