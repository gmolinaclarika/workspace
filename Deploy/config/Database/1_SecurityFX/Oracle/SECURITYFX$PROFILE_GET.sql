CREATE OR REPLACE PROCEDURE SECURITYFX$PROFILE_GET
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
    PROFILE_CODE$           IN  INTEGER,
    -- General Properties
    CODE$                   OUT INTEGER,
    NAME$                   OUT NVARCHAR2,
    FLAGS$                  OUT NVARCHAR2,
    MENU$                   OUT NVARCHAR2,
    DOMAIN$                 OUT NVARCHAR2,
    -- Privilege Properties
    PRIV_MENU$              OUT NVARCHAR2,
    PRIV_VARL$              OUT NVARCHAR2,
    PRIV_VARM$              OUT NVARCHAR2,
    PRIV_REGL$              OUT NVARCHAR2,
    PRIV_REGM$              OUT NVARCHAR2,
    -- Restriction Properties
    EXPIRES$                OUT INTEGER,
    HOUR_FROM$              OUT DECIMAL,
    HOUR_TO$                OUT DECIMAL,
    PWD_DAYS$               OUT INTEGER,
    -- Terminal Properties
    TERMINAL01$             OUT NVARCHAR2,
    TERMINAL02$             OUT NVARCHAR2,
    TERMINAL03$             OUT NVARCHAR2,
    TERMINAL04$             OUT NVARCHAR2,
    TERMINAL05$             OUT NVARCHAR2,
    TERMINAL06$             OUT NVARCHAR2,
    TERMINAL07$             OUT NVARCHAR2,
    TERMINAL08$             OUT NVARCHAR2,
    TERMINAL09$             OUT NVARCHAR2,
    TERMINAL10$             OUT NVARCHAR2,
    TERMINAL11$             OUT NVARCHAR2,
    TERMINAL12$             OUT NVARCHAR2,
    TERMINAL13$             OUT NVARCHAR2,
    TERMINAL14$             OUT NVARCHAR2,
    TERMINAL15$             OUT NVARCHAR2,
    TERMINAL16$             OUT NVARCHAR2,
    -- Profile Capacities
    CAPACITIES$             OUT SYS_REFCURSOR
)
AS
BEGIN
    BEGIN
        SELECT
            -- General Properties
            V_ACC_CODE_NUM,
            RTRIM(V_ACC_NAME),
            RTRIM(V_ACC_INDICADORES),
            RTRIM(V_ACC_PROG_INI),
            RTRIM(V_ACC_FAMILIA),
            -- Privilege Properties
            RTRIM(V_ACC_PRIV_MEN),
            RTRIM(V_ACC_PRIV_VARL),
            RTRIM(V_ACC_PRIV_VARM),
            RTRIM(V_ACC_PRIV_REGL),
            RTRIM(V_ACC_PRIV_REGM),
            -- Restriction Properties
            V_ACC_EXP,
            V_ACC_HORA_INIC,
            V_ACC_HORA_FIN,
            V_ACC_DIAS_VIG_PASSW,
            -- Terminal Properties
            RTRIM(V_ACC_TERM_001),
            RTRIM(V_ACC_TERM_002),
            RTRIM(V_ACC_TERM_003),
            RTRIM(V_ACC_TERM_004),
            RTRIM(V_ACC_TERM_005),
            RTRIM(V_ACC_TERM_006),
            RTRIM(V_ACC_TERM_007),
            RTRIM(V_ACC_TERM_008),
            RTRIM(V_ACC_TERM_009),
            RTRIM(V_ACC_TERM_010),
            RTRIM(V_ACC_TERM_011),
            RTRIM(V_ACC_TERM_012),
            RTRIM(V_ACC_TERM_013),
            RTRIM(V_ACC_TERM_014),
            RTRIM(V_ACC_TERM_015),
            RTRIM(V_ACC_TERM_016)
        INTO
            -- General Properties
            CODE$,
            NAME$,
            FLAGS$,
            MENU$,
            DOMAIN$,
            -- Privilege Properties
            PRIV_MENU$,
            PRIV_VARL$,
            PRIV_VARM$,
            PRIV_REGL$,
            PRIV_REGM$,
            -- Restriction Properties
            EXPIRES$,
            HOUR_FROM$,
            HOUR_TO$,
            PWD_DAYS$,
            -- Terminal Properties
            TERMINAL01$,
            TERMINAL02$,
            TERMINAL03$,
            TERMINAL04$,
            TERMINAL05$,
            TERMINAL06$,
            TERMINAL07$,
            TERMINAL08$,
            TERMINAL09$,
            TERMINAL10$,
            TERMINAL11$,
            TERMINAL12$,
            TERMINAL13$,
            TERMINAL14$,
            TERMINAL15$,
            TERMINAL16$
        FROM   EcuACCPER
        WHERE  V_ACC_CODE_NUM = PROFILE_CODE$;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Perfil no está definido: ' || PROFILE_CODE$);
    END;

    -- #ResultSet CAPACITY CAPACITIES
    --   #Column  CODE      NVARCHAR
    --   #Column  VALUE     NVARCHAR
    -- #EndResultSet
    OPEN CAPACITIES$ FOR
        SELECT RTRIM(CAP_CODIGO)    AS CODE,
               RTRIM(CAP_VALOR)     AS VALUE
        FROM  EcuACCC2P
        WHERE CODIGO_ECU = PROFILE_CODE$
        ORDER BY CAP_CODIGO;
END SECURITYFX$PROFILE_GET;
/

--------------------------------------------------------------------------------

COMMIT;
QUIT;
