DROP PROCEDURE IF EXISTS DESKTOPFX$PROFILE_GET;

DELIMITER $$
CREATE PROCEDURE DESKTOPFX$PROFILE_GET (
-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------
    IN  _PROFILE_CODE   INTEGER
)
BEGIN
    -- #ResultSet PROFILE PROFILES
    --   #Column  PROFILE_CODE      INTEGER
    --   #Column  EXPIRES           INTEGER
    --   #Column  FAMILIA           VARCHAR
    --   #Column  PROG_INI          VARCHAR
    --   #Column  NAME              VARCHAR
    --   #Column  PRIV_MEN          VARCHAR
    --   #Column  PRIV_VARL         VARCHAR
    --   #Column  PRIV_VARM         VARCHAR
    --   #Column  PRIV_REGL         VARCHAR
    --   #Column  PRIV_REGM         VARCHAR
    --   #Column  INDICADORES       VARCHAR
    --   #Column  TERM1             VARCHAR
    --   #Column  TERM2             VARCHAR
    --   #Column  TERM3             VARCHAR
    --   #Column  TERM4             VARCHAR
    --   #Column  TERM5             VARCHAR
    --   #Column  TERM6             VARCHAR
    --   #Column  TERM7             VARCHAR
    --   #Column  TERM8             VARCHAR
    --   #Column  TERM9             VARCHAR
    --   #Column  TERM10            VARCHAR
    --   #Column  TERM11            VARCHAR
    --   #Column  TERM12            VARCHAR
    --   #Column  TERM13            VARCHAR
    --   #Column  TERM14            VARCHAR
    --   #Column  TERM15            VARCHAR
    --   #Column  TERM16            VARCHAR
    -- #EndResultSet
    SELECT V_ACC_CODE_NUM               AS PROFILE_CODE,
           V_ACC_EXP                    AS EXPIRES,
           RTRIM(V_ACC_FAMILIA)         AS FAMILIA,
           RTRIM(V_ACC_PROG_INI)        AS PROG_INI,
           RTRIM(V_ACC_NAME)            AS NAME,
           RTRIM(V_ACC_PRIV_MEN)        AS PRIV_MEN,
           RTRIM(V_ACC_PRIV_VARL)       AS PRIV_VARL,
           RTRIM(V_ACC_PRIV_VARM)       AS PRIV_VARM,
           RTRIM(V_ACC_PRIV_REGL)       AS PRIV_REGL,
           RTRIM(V_ACC_PRIV_REGM)       AS PRIV_REGM,
           RTRIM(V_ACC_INDICADORES)     AS INDICADORES,
           RTRIM(V_ACC_TERM_001)        AS TERM1,
           RTRIM(V_ACC_TERM_002)        AS TERM2,
           RTRIM(V_ACC_TERM_003)        AS TERM3,
           RTRIM(V_ACC_TERM_004)        AS TERM4,
           RTRIM(V_ACC_TERM_005)        AS TERM5,
           RTRIM(V_ACC_TERM_006)        AS TERM6,
           RTRIM(V_ACC_TERM_007)        AS TERM7,
           RTRIM(V_ACC_TERM_008)        AS TERM8,
           RTRIM(V_ACC_TERM_009)        AS TERM9,
           RTRIM(V_ACC_TERM_010)        AS TERM10,
           RTRIM(V_ACC_TERM_011)        AS TERM11,
           RTRIM(V_ACC_TERM_012)        AS TERM12,
           RTRIM(V_ACC_TERM_013)        AS TERM13,
           RTRIM(V_ACC_TERM_014)        AS TERM14,
           RTRIM(V_ACC_TERM_015)        AS TERM15,
           RTRIM(V_ACC_TERM_016)        AS TERM16
    FROM   EcuACCPER
    WHERE  V_ACC_CODE_NUM = _PROFILE_CODE;
END$$
DELIMITER ;
