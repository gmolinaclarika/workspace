DROP PROCEDURE IF EXISTS SECURITYFX$CAPACITIES_GET;

DELIMITER $$
CREATE PROCEDURE SECURITYFX$CAPACITIES_GET (
-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------
    IN  _WSS_USER_CODE      VARCHAR(100),
    IN  _WSS_PROFILE_CODE   INTEGER,
    IN  _WSS_STATION_CODE   VARCHAR(100),
    -- -----------------------------------
    IN  _CAPACITIES_MAX     INTEGER
)
BEGIN
    -- #ResultSet CAPACITY CAPACITIES
    --    #Column CODE  VARCHAR
    --    #Column NAME  VARCHAR
    --    #Column TYPE  INTEGER
    -- #EndResultSet
    SELECT
           CAP_CODIGO   AS CODE,
           CAP_NOMBRE   AS NAME,
           CAP_TIPO     AS TYPE
    FROM  EcuACCCAP
    ORDER BY CAP_CODIGO
    LIMIT _CAPACITIES_MAX;
END$$
DELIMITER ;
