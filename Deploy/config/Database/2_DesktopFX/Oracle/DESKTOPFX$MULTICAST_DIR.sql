CREATE OR REPLACE PROCEDURE DESKTOPFX$MULTICAST_DIR
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
    VALID_FROM$             IN  TIMESTAMP,
    MULTICASTS_MAX$         IN  INTEGER,
    RECEIVE_TIME$           OUT TIMESTAMP,
    TRANSMIT_TIME$          OUT TIMESTAMP,
    MULTICASTS$             OUT SYS_REFCURSOR
)
AS
BEGIN
    -- Initialize receive time
    RECEIVE_TIME$ := SYSTIMESTAMP;

    -- Update last user poll date
    UPDATE DESKTOPFX_USER
    SET    LAST_POLL = RECEIVE_TIME$
    WHERE  USER_CODE = WSS_USER_CODE$;

    -- #ResultSet ITEM ITEMS
    --   #Column  ID                DECIMAL
    --   #Column  NAME              NVARCHAR
    --   #Column  MESSAGE           NVARCHAR
    --   #Column  VALID_FROM        TIMESTAMP
    --   #Column  VALID_TO          TIMESTAMP
    --   #Column  ATTACHMENT_TYPE   NVARCHAR
    -- #EndResultSet
    OPEN MULTICASTS$ FOR
        SELECT * FROM (
            SELECT ID               AS ID,
                   NAME             AS NAME,
                   MESSAGE          AS MESSAGE,
                   VALID_FROM       AS VALID_FROM,
                   VALID_TO         AS VALID_TO,
                   ATTACHMENT_TYPE  AS ATTACHMENT_TYPE
            FROM   DESKTOPFX_MULTICAST
            WHERE  VALID_FROM > VALID_FROM$
            AND    (RECEIVE_TIME$ BETWEEN VALID_FROM AND VALID_TO)
            AND    ((PROFILE_FILTER IS NULL) OR (PROFILE_FILTER = WSS_PROFILE_CODE$) OR (PROFILE_FILTER < 0 AND WSS_PROFILE_CODE$ != -PROFILE_FILTER))
            AND    ((USER_FILTER IS NULL) OR (USER_FILTER = WSS_USER_CODE$) OR (SUBSTR(USER_FILTER,1,1) = '!' AND WSS_USER_CODE$ != SUBSTR(USER_FILTER,2)))
            AND    ((STATION_FILTER IS NULL) OR (STATION_FILTER = WSS_STATION_CODE$) OR (SUBSTR(STATION_FILTER,1,1) = '!' AND WSS_STATION_CODE$ != SUBSTR(STATION_FILTER,2)))
            ORDER BY VALID_FROM)
        WHERE ROWNUM <= MULTICASTS_MAX$;

    -- Initialize transmit time
    TRANSMIT_TIME$ := SYSTIMESTAMP;
END DESKTOPFX$MULTICAST_DIR;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
