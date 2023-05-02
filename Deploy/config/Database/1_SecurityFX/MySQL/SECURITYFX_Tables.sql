-- -----------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
-- -----------------------------------------------------------------------------

DROP TABLE IF EXISTS EcuACCPRV;
DROP TABLE IF EXISTS EcuACCLOG;
DROP TABLE IF EXISTS EcuACCCTX;
DROP TABLE IF EXISTS EcuACCCON;
DROP TABLE IF EXISTS EcuACCC2P;
DROP TABLE IF EXISTS EcuACCC2U;
DROP TABLE IF EXISTS EcuACCCAP;
DROP TABLE IF EXISTS EcuACCU2P;
DROP TABLE IF EXISTS EcuACCUSU;
DROP TABLE IF EXISTS EcuACCPER;
DROP TABLE IF EXISTS EcuACCNET;
DROP TABLE IF EXISTS EcuACCFAM;

-- -----------------------------------------------------------------------------
-- EcuACCFAM -------------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS EcuACCFAM
(
    V_FAM_FAMILIA           CHAR(10)        NOT NULL    DEFAULT '',
    V_FAM_NOMBRE_USUARIO    CHAR(40)        NOT NULL    DEFAULT '',
    V_FAM_UBICACION         CHAR(40)        NOT NULL    DEFAULT '',
    V_FAM_TEXTO1            CHAR(40)        NOT NULL    DEFAULT '',
    V_FAM_TEXTO2            CHAR(40)        NOT NULL    DEFAULT '',
    V_FAM_TEXTO3            CHAR(40)        NOT NULL    DEFAULT '',
    V_FAM_TEXTO4            CHAR(40)        NOT NULL    DEFAULT '',
    CONSTRAINT EcuACCFAM_PK PRIMARY KEY (V_FAM_FAMILIA)
);

-- -----------------------------------------------------------------------------
-- EcuACCNET -------------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS EcuACCNET
(
    V_NET_NOMBRE            CHAR(16)        NOT NULL    DEFAULT '',
    V_NET_FAMILIA           CHAR(10)        NOT NULL    DEFAULT '',
    V_NET_TIPO              CHAR(1)         NOT NULL    DEFAULT '',
    V_NET_DIRECCION_IP      CHAR(16)        NOT NULL    DEFAULT '',
    V_NET_POLL_PRIMARIO     CHAR(10)        NOT NULL    DEFAULT '',
    V_NET_POLL_BACKUP       CHAR(10)        NOT NULL    DEFAULT '',
    V_NET_CIRCUITO          DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    V_NET_MASTERKEY1        CHAR(16)        NOT NULL    DEFAULT '',
    V_NET_MASTERKEY2        CHAR(16)        NOT NULL    DEFAULT '',
    V_NET_HORA_KEY1         CHAR(26)        NOT NULL    DEFAULT '',
    V_NET_HORA_KEY2         CHAR(26)        NOT NULL    DEFAULT '',
    V_NET_GRUPO_DYN         CHAR(10)        NOT NULL    DEFAULT '',
    V_NET_PRINTER           CHAR(10)        NOT NULL    DEFAULT '',
    V_NET_NOMBRE_USUARIO    CHAR(40)        NOT NULL    DEFAULT '',
    V_NET_UBICACION         CHAR(40)        NOT NULL    DEFAULT '',
    V_NET_TEXTO1            CHAR(40)        NOT NULL    DEFAULT '',
    V_NET_TEXTO2            CHAR(40)        NOT NULL    DEFAULT '',
    V_NET_TEXTO3            CHAR(40)        NOT NULL    DEFAULT '',
    V_NET_TEXTO4            CHAR(40)        NOT NULL    DEFAULT '',
    V_NET_SERIETERM         CHAR(20)        NOT NULL    DEFAULT '',
    V_NET_HABILITADO        CHAR(1)         NOT NULL    DEFAULT '',
    CONSTRAINT EcuACCNET_PK PRIMARY KEY (V_NET_NOMBRE),
    CONSTRAINT EcuACCNET_F1 FOREIGN KEY (V_NET_FAMILIA)
        REFERENCES EcuACCFAM (V_FAM_FAMILIA)
);

-- -----------------------------------------------------------------------------
-- EcuACCPER -------------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS EcuACCPER
(
    V_ACC_CODE_NUM          DECIMAL(7)      NOT NULL    DEFAULT 0 ,
    V_ACC_PRIV_MEN          CHAR(32)        NOT NULL    DEFAULT '',
    V_ACC_PRIV_VARL         CHAR(32)        NOT NULL    DEFAULT '',
    V_ACC_PRIV_VARM         CHAR(32)        NOT NULL    DEFAULT '',
    V_ACC_PRIV_REGL         CHAR(32)        NOT NULL    DEFAULT '',
    V_ACC_PRIV_REGM         CHAR(32)        NOT NULL    DEFAULT '',
    V_ACC_NAME              CHAR(30)        NOT NULL    DEFAULT '',
    V_ACC_EXP               DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    V_ACC_INDICADORES       CHAR(6)         NOT NULL    DEFAULT '',
    V_ACC_HORA_INIC         DECIMAL(4,2)    NOT NULL    DEFAULT 0 ,
    V_ACC_HORA_FIN          DECIMAL(4,2)    NOT NULL    DEFAULT 0 ,
    V_ACC_CLASE_PD          CHAR(1)         NOT NULL    DEFAULT '',
    V_ACC_PROG_INI          CHAR(12)        NOT NULL    DEFAULT '',
    V_ACC_FAMILIA           CHAR(10)        NOT NULL    DEFAULT '',
    V_ACC_CANT_TERM         DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    V_ACC_TERM_001          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_TERM_002          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_TERM_003          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_TERM_004          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_TERM_005          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_TERM_006          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_TERM_007          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_TERM_008          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_TERM_009          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_TERM_010          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_TERM_011          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_TERM_012          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_TERM_013          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_TERM_014          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_TERM_015          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_TERM_016          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_DIAS_VIG_PASSW    DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    V_ACC_VIG_PASSW         DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    V_ACC_PASSWORD          DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    V_ACC_OTRAS_PASSW_001   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    V_ACC_OTRAS_PASSW_002   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    V_ACC_OTRAS_PASSW_003   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    V_ACC_OTRAS_PASSW_004   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    V_ACC_OTRAS_PASSW_005   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    V_ACC_OTRAS_PASSW_006   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    V_ACC_FAM_IMPR          CHAR(10)        NOT NULL    DEFAULT '',
    V_ACC_IMPR_PRE          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_CANT_IMPR         DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    V_ACC_IMPR_001          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_IMPR_002          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_IMPR_003          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_IMPR_004          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_IMPR_005          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_IMPR_006          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_IMPR_007          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_IMPR_008          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_IMPR_009          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_IMPR_010          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_IMPR_011          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_IMPR_012          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_IMPR_013          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_IMPR_014          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_IMPR_015          CHAR(16)        NOT NULL    DEFAULT '',
    V_ACC_IMPR_016          CHAR(16)        NOT NULL    DEFAULT '',
    CONSTRAINT EcuACCPER_PK PRIMARY KEY (V_ACC_CODE_NUM),
    CONSTRAINT EcuACCPER_F1 FOREIGN KEY (V_ACC_FAMILIA)
        REFERENCES EcuACCFAM (V_FAM_FAMILIA)
);

-- -----------------------------------------------------------------------------
-- EcuACCUSU -------------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS EcuACCUSU
(
    USU_CODIGO              CHAR(40)        NOT NULL    DEFAULT '',
    APELLIDO_PAT            CHAR(20)        NOT NULL    DEFAULT '',
    APELLIDO_MAT            CHAR(20)        NOT NULL    DEFAULT '',
    NOMBRES                 CHAR(30)        NOT NULL    DEFAULT '',
    RUT                     CHAR(11)        NOT NULL    DEFAULT '',
    USU_ESTADO              CHAR(2)         NOT NULL    DEFAULT '',
    CERTIF_ID               CHAR(26)        NOT NULL    DEFAULT '',
    PSW_TIPO                CHAR(3)         NOT NULL    DEFAULT '',
    PASSWORD                CHAR(51)        NOT NULL    DEFAULT '',
    PSW_VIG_DESD            DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    PSW_ULTIMAS_001         CHAR(51)        NOT NULL    DEFAULT '',
    PSW_ULTIMAS_002         CHAR(51)        NOT NULL    DEFAULT '',
    PSW_ULTIMAS_003         CHAR(51)        NOT NULL    DEFAULT '',
    PSW_ULTIMAS_004         CHAR(51)        NOT NULL    DEFAULT '',
    PSW_ULTIMAS_005         CHAR(51)        NOT NULL    DEFAULT '',
    PSW_ULTIMAS_006         CHAR(51)        NOT NULL    DEFAULT '',
    PSW_DIAS_CADUC          DECIMAL(6)      NOT NULL    DEFAULT 0 ,
    PSW_ESTADO              CHAR(3)         NOT NULL    DEFAULT '',
    RUT_INST                CHAR(11)        NOT NULL    DEFAULT '',
    FAMILIA                 CHAR(10)        NOT NULL    DEFAULT '',
    CARGO                   CHAR(40)        NOT NULL    DEFAULT '',
    DIRECCION               CHAR(40)        NOT NULL    DEFAULT '',
    COMUNA                  CHAR(20)        NOT NULL    DEFAULT '',
    CIUDAD                  CHAR(20)        NOT NULL    DEFAULT '',
    ESTADO                  CHAR(20)        NOT NULL    DEFAULT '',
    PAIS                    CHAR(20)        NOT NULL    DEFAULT '',
    FONO1                   CHAR(20)        NOT NULL    DEFAULT '',
    FONO2                   CHAR(20)        NOT NULL    DEFAULT '',
    FAX                     CHAR(20)        NOT NULL    DEFAULT '',
    EMAIL                   CHAR(40)        NOT NULL    DEFAULT '',
    FEC_REGISTRO            DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    COD_CONTRATO            CHAR(20)        NOT NULL    DEFAULT '',
    ANEXO_CONTRATO          CHAR(10)        NOT NULL    DEFAULT '',
    FEC_VIG_DESD            DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    FEC_VIG_HAST            DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    FEC_CRE_USU             CHAR(26)        NOT NULL    DEFAULT '',
    FEC_PRI_LOG             CHAR(26)        NOT NULL    DEFAULT '',
    FEC_ULT_LOG             CHAR(26)        NOT NULL    DEFAULT '',
    COD_FACTURACION         CHAR(8)         NOT NULL    DEFAULT '',
    FACTURACION             CHAR(1)         NOT NULL    DEFAULT '',
    DEMO_DIAS               DECIMAL(2)      NOT NULL    DEFAULT 0 ,
    DEMO_AUTO               CHAR(16)        NOT NULL    DEFAULT '',
    DEMO_FEC_INI            DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    DEMO_VECES              DECIMAL(2)      NOT NULL    DEFAULT 0 ,
    DEMO_DIAS_TOT           DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    SW_CERT_DIG             CHAR(1)         NOT NULL    DEFAULT '',
    USUARIOIM               CHAR(1)         NOT NULL    DEFAULT '',
    NICKNAME                CHAR(10)        NOT NULL    DEFAULT '',
    FEC_ERR_LOG             CHAR(26)        NOT NULL    DEFAULT '',
    ERROR_LOGIN             DECIMAL(1)      NOT NULL    DEFAULT 0 ,
    CONSTRAINT EcuACCUSU_PK PRIMARY KEY (USU_CODIGO),
    CONSTRAINT EcuACCUSU_F1 FOREIGN KEY (FAMILIA)
        REFERENCES EcuACCFAM (V_FAM_FAMILIA)
);

-- -----------------------------------------------------------------------------
-- EcuACCU2P -------------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS EcuACCU2P
(
    CODIGO_ADI              CHAR(40)        NOT NULL    DEFAULT '',
    CODIGO_ECU              DECIMAL(7)      NOT NULL    DEFAULT 0 ,
    CONSTRAINT EcuACCU2P_PK PRIMARY KEY
        (CODIGO_ADI,CODIGO_ECU),
    CONSTRAINT EcuACCU2P_F1 FOREIGN KEY (CODIGO_ADI)
        REFERENCES EcuACCUSU (USU_CODIGO),
    CONSTRAINT EcuACCU2P_F2 FOREIGN KEY (CODIGO_ECU)
        REFERENCES EcuACCPER (V_ACC_CODE_NUM)
);

-- -----------------------------------------------------------------------------
-- EcuACCCAP -------------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS EcuACCCAP
(
    CAP_CODIGO              CHAR(40)        NOT NULL    DEFAULT '',
    CAP_NOMBRE              CHAR(120)       NOT NULL    DEFAULT '',
    CAP_TIPO                DECIMAL(2)      NOT NULL    DEFAULT 0 ,
    CONSTRAINT EcuACCCAP_PK PRIMARY KEY (CAP_CODIGO)
);

-- -----------------------------------------------------------------------------
-- EcuACCC2U -------------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS EcuACCC2U
(
    CODIGO_ADI              CHAR(40)        NOT NULL    DEFAULT '',
    CAP_CODIGO              CHAR(40)        NOT NULL    DEFAULT '',
    CAP_VALOR               CHAR(200)       NOT NULL    DEFAULT '',
    CONSTRAINT EcuACCC2U_PK PRIMARY KEY
        (CODIGO_ADI,CAP_CODIGO),
    CONSTRAINT EcuACCC2U_F1 FOREIGN KEY (CODIGO_ADI)
        REFERENCES EcuACCUSU (USU_CODIGO),
    CONSTRAINT EcuACCC2U_F2 FOREIGN KEY (CAP_CODIGO)
        REFERENCES EcuACCCAP (CAP_CODIGO)
);

-- -----------------------------------------------------------------------------
-- EcuACCC2P -------------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS EcuACCC2P
(
    CODIGO_ECU              DECIMAL(7)      NOT NULL    DEFAULT 0 ,
    CAP_CODIGO              CHAR(40)        NOT NULL    DEFAULT '',
    CAP_VALOR               CHAR(200)       NOT NULL    DEFAULT '',
    CONSTRAINT EcuACCC2P_PK PRIMARY KEY
        (CODIGO_ECU,CAP_CODIGO),
    CONSTRAINT EcuACCC2P_F1 FOREIGN KEY (CODIGO_ECU)
        REFERENCES EcuACCPER (V_ACC_CODE_NUM),
    CONSTRAINT EcuACCC2P_F2 FOREIGN KEY (CAP_CODIGO)
        REFERENCES EcuACCCAP (CAP_CODIGO)
);

-- -----------------------------------------------------------------------------
-- EcuACCCON -------------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS EcuACCCON
(
    TIPO_REG                CHAR(1)         NOT NULL    DEFAULT '',
    ECL_NAME                CHAR(10)        NOT NULL    DEFAULT '',
    UNIQUE_ID               DECIMAL(16)     NOT NULL    DEFAULT 0 ,
    USUARIO                 CHAR(40)        NOT NULL    DEFAULT '',
    CORREL                  DECIMAL(3)      NOT NULL    DEFAULT 0 ,
    TERMINAL                CHAR(16)        NOT NULL    DEFAULT '',
    HORA_CONEX              CHAR(26)        NOT NULL    DEFAULT '',
    ECL_ULT_PING            CHAR(26)        NOT NULL    DEFAULT '',
    ECL_UPTIME              DECIMAL(12)     NOT NULL    DEFAULT 0 ,
    CONSTRAINT EcuACCCON_PK PRIMARY KEY (TIPO_REG,ECL_NAME,UNIQUE_ID),
    CONSTRAINT EcuACCCON_I1 UNIQUE (TIPO_REG,USUARIO,CORREL)
);

-- -----------------------------------------------------------------------------
-- EcuACCCTX -------------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS EcuACCCTX
(
    STATION                 CHAR(16)        NOT NULL    DEFAULT '',
    SUBDROP                 CHAR(1)         NOT NULL    DEFAULT '',
    SECUENCIA               DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    CODIGO_ADI              CHAR(40)        NOT NULL    DEFAULT '',
    CODIGO_ECU              DECIMAL(7)      NOT NULL    DEFAULT 0 ,
    DATA                    TEXT            NOT NULL,
    CONSTRAINT EcuACCCTX_PK PRIMARY KEY (STATION,SUBDROP,SECUENCIA)
);

-- -----------------------------------------------------------------------------
-- EcuACCLOG -------------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS EcuACCLOG
(
    V_ECULOG_HORA           CHAR(26)        NOT NULL    DEFAULT '',
    V_ECULOG_CODIGO_ADI     CHAR(40)        NOT NULL    DEFAULT '',
    V_ECULOG_CODIGO_ECU     DECIMAL(7)      NOT NULL    DEFAULT 0 ,
    V_ECULOG_TERMINAL       CHAR(16)        NOT NULL    DEFAULT '',
    V_ECULOG_CODIGO_MSG     DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    V_ECULOG_MENSAJE        CHAR(99)        NOT NULL    DEFAULT '',
    CONSTRAINT EcuACCLOG_PK PRIMARY KEY (V_ECULOG_HORA)
);

-- -----------------------------------------------------------------------------
-- EcuACCPRV -------------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS EcuACCPRV
(
    V_PRV_TIPO              CHAR(1)         NOT NULL    DEFAULT '',
    V_PRV_NUMERO            DECIMAL(2)      NOT NULL    DEFAULT 0 ,
    V_PRV_NOMBRE            CHAR(20)        NOT NULL    DEFAULT '',
    V_PRV_CONST             CHAR(20)        NOT NULL    DEFAULT '',
    V_PRV_SYSLOG            CHAR(2)         NOT NULL    DEFAULT '',
    CONSTRAINT EcuACCPRV_PK PRIMARY KEY (V_PRV_TIPO,V_PRV_NUMERO)
);

-- -----------------------------------------------------------------------------
