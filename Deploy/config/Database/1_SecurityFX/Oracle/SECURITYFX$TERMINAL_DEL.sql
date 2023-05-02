CREATE OR REPLACE PROCEDURE SECURITYFX$TERMINAL_DEL
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
    TERMINAL_NAME$          IN  NVARCHAR2
)
AS
    V_NET_NOMBRE$           EcuACCNET.V_NET_NOMBRE%TYPE;
BEGIN
    -- Normalize specified terminal name
    V_NET_NOMBRE$ := UPPER(RTRIM(TERMINAL_NAME$));

    -- Delete the properties of specified terminal
    DELETE FROM EcuACCNET
    WHERE  V_NET_NOMBRE = V_NET_NOMBRE$;

    -- Generate an audit record
    SECURITYFX$AUDIT_PUT(
        WSS_USER_CODE$, WSS_PROFILE_CODE$, WSS_STATION_CODE$, 
        12, 'Terminal fue eliminado: ' || TERMINAL_NAME$);
END SECURITYFX$TERMINAL_DEL;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
