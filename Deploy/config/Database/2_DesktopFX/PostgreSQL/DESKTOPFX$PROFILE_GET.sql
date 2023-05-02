CREATE OR REPLACE FUNCTION desktopfx$profile_get (
    _profile_code       IN  INTEGER,
    _profiles           OUT REFCURSOR
)
AS $BODY$
--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------
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
    OPEN _profiles FOR
        SELECT v_acc_code_num               AS PROFILE_CODE,
               v_acc_exp                    AS EXPIRES,
               RTRIM(v_acc_familia)         AS FAMILIA,
               RTRIM(v_acc_prog_ini)        AS PROG_INI,
               RTRIM(v_acc_name)            AS NAME,
               RTRIM(v_acc_priv_men)        AS PRIV_MEN,
               RTRIM(v_acc_priv_varl)       AS PRIV_VARL,
               RTRIM(v_acc_priv_varm)       AS PRIV_VARM,
               RTRIM(v_acc_priv_regl)       AS PRIV_REGL,
               RTRIM(v_acc_priv_regm)       AS PRIV_REGM,
               RTRIM(v_acc_indicadores)     AS INDICADORES,
               RTRIM(v_acc_term_001)        AS TERM1,
               RTRIM(v_acc_term_002)        AS TERM2,
               RTRIM(v_acc_term_003)        AS TERM3,
               RTRIM(v_acc_term_004)        AS TERM4,
               RTRIM(v_acc_term_005)        AS TERM5,
               RTRIM(v_acc_term_006)        AS TERM6,
               RTRIM(v_acc_term_007)        AS TERM7,
               RTRIM(v_acc_term_008)        AS TERM8,
               RTRIM(v_acc_term_009)        AS TERM9,
               RTRIM(v_acc_term_010)        AS TERM10,
               RTRIM(v_acc_term_011)        AS TERM11,
               RTRIM(v_acc_term_012)        AS TERM12,
               RTRIM(v_acc_term_013)        AS TERM13,
               RTRIM(v_acc_term_014)        AS TERM14,
               RTRIM(v_acc_term_015)        AS TERM15,
               RTRIM(v_acc_term_016)        AS TERM16
        FROM   ecuaccper 
        WHERE  v_acc_code_num = _profile_code;
END;
$BODY$ LANGUAGE plpgsql;
