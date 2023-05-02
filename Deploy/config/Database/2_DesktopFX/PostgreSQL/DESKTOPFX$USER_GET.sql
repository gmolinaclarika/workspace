CREATE OR REPLACE FUNCTION desktopfx$user_get (
    _user_id            IN  VARCHAR,
    _users              OUT REFCURSOR
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
DECLARE
    _usu_codigo     ecuaccusu.usu_codigo%type := _user_id;
BEGIN
    -- #ResultSet USER USERS
    --   #Column  USER_CODE         VARCHAR
    --   #Column  ESTADO            VARCHAR
    --   #Column  FAMILIA           VARCHAR
    --   #Column  NOMBRES           VARCHAR
    --   #Column  APELLIDO_PAT      VARCHAR
    --   #Column  APELLIDO_MAT      VARCHAR
    --   #Column  FEC_CRE_USU       VARCHAR
    --   #Column  FEC_PRI_LOG       VARCHAR
    --   #Column  FEC_ULT_LOG       VARCHAR
    --   #Column  FEC_VIG_DESD      INTEGER
    --   #Column  FEC_VIG_HAST      INTEGER
    --   #Column  PASSWORD          VARCHAR
    --   #Column  PSW_TIPO          VARCHAR
    --   #Column  PSW_ESTADO        VARCHAR
    --   #Column  PSW_VIG_DESD      INTEGER
    --   #Column  PSW_DIAS_CADUC    INTEGER
    --   #Column  PSW_ULTIMAS1      VARCHAR
    --   #Column  PSW_ULTIMAS2      VARCHAR
    --   #Column  PSW_ULTIMAS3      VARCHAR
    --   #Column  PSW_ULTIMAS4      VARCHAR
    --   #Column  PSW_ULTIMAS5      VARCHAR
    --   #Column  PSW_ULTIMAS6      VARCHAR
    --   #Column  EMAIL             VARCHAR
    --   #Column  ERROR_LOGIN       INTEGER
    --   #Column  FEC_ERR_LOG       VARCHAR
    -- #EndResultSet
    OPEN _users FOR
        SELECT RTRIM(usu_codigo)                AS USER_CODE,
               RTRIM(usu_estado)                AS ESTADO,
               RTRIM(familia)                   AS FAMILIA,
               RTRIM(nombres)                   AS NOMBRES,
               RTRIM(apellido_pat)              AS APELLIDO_PAT,
               RTRIM(apellido_mat)              AS APELLIDO_MAT,
               RTRIM(fec_cre_usu)               AS FEC_CRE_USU,
               RTRIM(fec_pri_log)               AS FEC_PRI_LOG,
               RTRIM(fec_ult_log)               AS FEC_ULT_LOG,
               fec_vig_desd                     AS FEC_VIG_DESD,
               fec_vig_hast                     AS FEC_VIG_HAST,
               RTRIM(password)                  AS PASSWORD,
               RTRIM(psw_tipo)                  AS PSW_TIPO,
               RTRIM(psw_estado)                AS PSW_ESTADO,
               psw_vig_desd                     AS PSW_VIG_DESD,
               psw_dias_caduc                   AS PSW_DIAS_CADUC,
               RTRIM(psw_ultimas_001)           AS PSW_ULTIMAS1,
               RTRIM(psw_ultimas_002)           AS PSW_ULTIMAS2,
               RTRIM(psw_ultimas_003)           AS PSW_ULTIMAS3,
               RTRIM(psw_ultimas_004)           AS PSW_ULTIMAS4,
               RTRIM(psw_ultimas_005)           AS PSW_ULTIMAS5,
               RTRIM(psw_ultimas_006)           AS PSW_ULTIMAS6,
               RTRIM(email)                     AS EMAIL,
               error_login                      AS ERROR_LOGIN,
               RTRIM(fec_err_log)               AS FEC_ERR_LOG
        FROM   ecuaccusu
        WHERE  usu_codigo = _usu_codigo;
END;
$BODY$ LANGUAGE plpgsql;
