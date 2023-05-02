CREATE OR REPLACE PROCEDURE SECURITYFX$AUDIT_PUT
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
    USER_CODE$          IN  NVARCHAR2,
    PROFILE_CODE$       IN  INTEGER,
    STATION_CODE$       IN  NVARCHAR2,
    EVENT_CODE$         IN  INTEGER,
    MESSAGE$            IN  NVARCHAR2
)
AS
BEGIN
    INSERT INTO EcuACCLOG (
         V_ECULOG_HORA
        ,V_ECULOG_CODIGO_ADI
        ,V_ECULOG_CODIGO_ECU
        ,V_ECULOG_TERMINAL
        ,V_ECULOG_CODIGO_MSG
        ,V_ECULOG_MENSAJE
    ) VALUES (
         TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD:HH24:MI:SS.FF6')
        ,NVL(USER_CODE$, '?')
        ,NVL(PROFILE_CODE$, 9999999)
        ,NVL(STATION_CODE$, '?')
        ,NVL(EVENT_CODE$, 9999)
        ,NVL(MESSAGE$, '?')
    );
END SECURITYFX$AUDIT_PUT;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
