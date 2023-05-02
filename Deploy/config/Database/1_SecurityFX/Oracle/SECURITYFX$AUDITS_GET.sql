CREATE OR REPLACE PROCEDURE SECURITYFX$AUDITS_GET
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
    DATE_TIME_FROM$         IN  NVARCHAR2,
    DATE_TIME_TO$           IN  NVARCHAR2,
    USER_CODE$              IN  NVARCHAR2,
    PROFILE_CODE$           IN  INTEGER,
    TERMINAL_NAME$          IN  NVARCHAR2,
    EVENT_CODE$             IN  INTEGER,
    AUDITS_MAX$             IN  INTEGER,
    AUDITS$                 OUT SYS_REFCURSOR
)
AS
BEGIN
    -- #ResultSet AUDIT AUDITS
    --    #Column DATE_TIME         NVARCHAR
    --    #Column USER_CODE         NVARCHAR
    --    #Column PROFILE_CODE      INTEGER
    --    #Column TERMINAL_NAME     NVARCHAR
    --    #Column EVENT_CODE        INTEGER
    --    #Column MESSAGE           NVARCHAR
    -- #EndResultSet
    OPEN AUDITS$ FOR
        SELECT * FROM (
            SELECT RTRIM(V_ECULOG_HORA)         AS DATE_TIME,
                   RTRIM(V_ECULOG_CODIGO_ADI)   AS USER_CODE,
                   V_ECULOG_CODIGO_ECU          AS PROFILE_CODE,
                   RTRIM(V_ECULOG_TERMINAL)     AS TERMINAL_NAME,
                   V_ECULOG_CODIGO_MSG          AS EVENT_CODE,
                   RTRIM(V_ECULOG_MENSAJE)      AS MESSAGE
            FROM  EcuACCLOG
            WHERE V_ECULOG_HORA BETWEEN DATE_TIME_FROM$ AND DATE_TIME_TO$
            AND   (USER_CODE$     IS NULL OR USER_CODE$ = V_ECULOG_CODIGO_ADI)
            AND   (PROFILE_CODE$  IS NULL OR PROFILE_CODE$ = V_ECULOG_CODIGO_ECU)
            AND   (TERMINAL_NAME$ IS NULL OR TERMINAL_NAME$ = V_ECULOG_TERMINAL)
            AND   (EVENT_CODE$    IS NULL OR EVENT_CODE$ = V_ECULOG_CODIGO_MSG)
            ORDER BY V_ECULOG_HORA DESC)
        WHERE ROWNUM <= AUDITS_MAX$;
END SECURITYFX$AUDITS_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
