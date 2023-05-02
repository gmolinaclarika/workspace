--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------

DROP TABLE EcuACCPRV CASCADE CONSTRAINTS;
DROP TABLE EcuACCLOG CASCADE CONSTRAINTS;
DROP TABLE EcuACCCTX CASCADE CONSTRAINTS;
DROP TABLE EcuACCCON CASCADE CONSTRAINTS;
DROP TABLE EcuACCC2P CASCADE CONSTRAINTS;
DROP TABLE EcuACCC2U CASCADE CONSTRAINTS;
DROP TABLE EcuACCCAP CASCADE CONSTRAINTS;
DROP TABLE EcuACCU2P CASCADE CONSTRAINTS;
DROP TABLE EcuACCUSU CASCADE CONSTRAINTS;
DROP TABLE EcuACCPER CASCADE CONSTRAINTS;
DROP TABLE EcuACCNET CASCADE CONSTRAINTS;
DROP TABLE EcuACCFAM CASCADE CONSTRAINTS;

--------------------------------------------------------------------------------
-- EcuACCFAM -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCFAM
(
    V_FAM_FAMILIA           NCHAR(10)       DEFAULT ' '     NOT NULL,
    V_FAM_NOMBRE_USUARIO    NCHAR(40)       DEFAULT ' '     NOT NULL,
    V_FAM_UBICACION         NCHAR(40)       DEFAULT ' '     NOT NULL,
    V_FAM_TEXTO1            NCHAR(40)       DEFAULT ' '     NOT NULL,
    V_FAM_TEXTO2            NCHAR(40)       DEFAULT ' '     NOT NULL,
    V_FAM_TEXTO3            NCHAR(40)       DEFAULT ' '     NOT NULL,
    V_FAM_TEXTO4            NCHAR(40)       DEFAULT ' '     NOT NULL,
    CONSTRAINT EcuACCFAM_PK PRIMARY KEY (V_FAM_FAMILIA)
);

--------------------------------------------------------------------------------
-- EcuACCNET -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCNET
(
    V_NET_NOMBRE            NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_NET_FAMILIA           NCHAR(10)       DEFAULT ' '     NOT NULL,
    V_NET_TIPO              NCHAR(1)        DEFAULT ' '     NOT NULL,
    V_NET_DIRECCION_IP      NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_NET_POLL_PRIMARIO     NCHAR(10)       DEFAULT ' '     NOT NULL,
    V_NET_POLL_BACKUP       NCHAR(10)       DEFAULT ' '     NOT NULL,
    V_NET_CIRCUITO          DECIMAL(4)      DEFAULT  0      NOT NULL,
    V_NET_MASTERKEY1        NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_NET_MASTERKEY2        NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_NET_HORA_KEY1         NCHAR(26)       DEFAULT ' '     NOT NULL,
    V_NET_HORA_KEY2         NCHAR(26)       DEFAULT ' '     NOT NULL,
    V_NET_GRUPO_DYN         NCHAR(10)       DEFAULT ' '     NOT NULL,
    V_NET_PRINTER           NCHAR(10)       DEFAULT ' '     NOT NULL,
    V_NET_NOMBRE_USUARIO    NCHAR(40)       DEFAULT ' '     NOT NULL,
    V_NET_UBICACION         NCHAR(40)       DEFAULT ' '     NOT NULL,
    V_NET_TEXTO1            NCHAR(40)       DEFAULT ' '     NOT NULL,
    V_NET_TEXTO2            NCHAR(40)       DEFAULT ' '     NOT NULL,
    V_NET_TEXTO3            NCHAR(40)       DEFAULT ' '     NOT NULL,
    V_NET_TEXTO4            NCHAR(40)       DEFAULT ' '     NOT NULL,
    V_NET_SERIETERM         NCHAR(20)       DEFAULT ' '     NOT NULL,
    V_NET_HABILITADO        NCHAR(1)        DEFAULT ' '     NOT NULL,
    CONSTRAINT EcuACCNET_PK PRIMARY KEY (V_NET_NOMBRE),
    CONSTRAINT EcuACCNET_F1 FOREIGN KEY (V_NET_FAMILIA)
        REFERENCES EcuACCFAM (V_FAM_FAMILIA)
);

--------------------------------------------------------------------------------
-- EcuACCPER -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCPER
(
    V_ACC_CODE_NUM          DECIMAL(7)      DEFAULT  0      NOT NULL,
    V_ACC_PRIV_MEN          NCHAR(32)       DEFAULT ' '     NOT NULL,
    V_ACC_PRIV_VARL         NCHAR(32)       DEFAULT ' '     NOT NULL,
    V_ACC_PRIV_VARM         NCHAR(32)       DEFAULT ' '     NOT NULL,
    V_ACC_PRIV_REGL         NCHAR(32)       DEFAULT ' '     NOT NULL,
    V_ACC_PRIV_REGM         NCHAR(32)       DEFAULT ' '     NOT NULL,
    V_ACC_NAME              NCHAR(30)       DEFAULT ' '     NOT NULL,
    V_ACC_EXP               DECIMAL(8)      DEFAULT  0      NOT NULL,
    V_ACC_INDICADORES       NCHAR(6)        DEFAULT ' '     NOT NULL,
    V_ACC_HORA_INIC         DECIMAL(4,2)    DEFAULT  0      NOT NULL,
    V_ACC_HORA_FIN          DECIMAL(4,2)    DEFAULT  0      NOT NULL,
    V_ACC_CLASE_PD          NCHAR(1)        DEFAULT ' '     NOT NULL,
    V_ACC_PROG_INI          NCHAR(12)       DEFAULT ' '     NOT NULL,
    V_ACC_FAMILIA           NCHAR(10)       DEFAULT ' '     NOT NULL,
    V_ACC_CANT_TERM         DECIMAL(4)      DEFAULT  0      NOT NULL,
    V_ACC_TERM_001          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_TERM_002          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_TERM_003          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_TERM_004          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_TERM_005          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_TERM_006          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_TERM_007          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_TERM_008          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_TERM_009          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_TERM_010          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_TERM_011          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_TERM_012          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_TERM_013          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_TERM_014          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_TERM_015          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_TERM_016          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_DIAS_VIG_PASSW    DECIMAL(4)      DEFAULT  0      NOT NULL,
    V_ACC_VIG_PASSW         DECIMAL(8)      DEFAULT  0      NOT NULL,
    V_ACC_PASSWORD          DECIMAL(18)     DEFAULT  0      NOT NULL,
    V_ACC_OTRAS_PASSW_001   DECIMAL(18)     DEFAULT  0      NOT NULL,
    V_ACC_OTRAS_PASSW_002   DECIMAL(18)     DEFAULT  0      NOT NULL,
    V_ACC_OTRAS_PASSW_003   DECIMAL(18)     DEFAULT  0      NOT NULL,
    V_ACC_OTRAS_PASSW_004   DECIMAL(18)     DEFAULT  0      NOT NULL,
    V_ACC_OTRAS_PASSW_005   DECIMAL(18)     DEFAULT  0      NOT NULL,
    V_ACC_OTRAS_PASSW_006   DECIMAL(18)     DEFAULT  0      NOT NULL,
    V_ACC_FAM_IMPR          NCHAR(10)       DEFAULT ' '     NOT NULL,
    V_ACC_IMPR_PRE          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_CANT_IMPR         DECIMAL(4)      DEFAULT  0      NOT NULL,
    V_ACC_IMPR_001          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_IMPR_002          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_IMPR_003          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_IMPR_004          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_IMPR_005          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_IMPR_006          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_IMPR_007          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_IMPR_008          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_IMPR_009          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_IMPR_010          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_IMPR_011          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_IMPR_012          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_IMPR_013          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_IMPR_014          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_IMPR_015          NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ACC_IMPR_016          NCHAR(16)       DEFAULT ' '     NOT NULL,
    CONSTRAINT EcuACCPER_PK PRIMARY KEY (V_ACC_CODE_NUM),
    CONSTRAINT EcuACCPER_F1 FOREIGN KEY (V_ACC_FAMILIA)
        REFERENCES EcuACCFAM (V_FAM_FAMILIA)
);

--------------------------------------------------------------------------------
-- EcuACCUSU -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCUSU
(
    USU_CODIGO              NCHAR(40)       DEFAULT ' '     NOT NULL,
    APELLIDO_PAT            NCHAR(20)       DEFAULT ' '     NOT NULL,
    APELLIDO_MAT            NCHAR(20)       DEFAULT ' '     NOT NULL,
    NOMBRES                 NCHAR(30)       DEFAULT ' '     NOT NULL,
    RUT                     NCHAR(11)       DEFAULT ' '     NOT NULL,
    USU_ESTADO              NCHAR(2)        DEFAULT ' '     NOT NULL,
    CERTIF_ID               NCHAR(26)       DEFAULT ' '     NOT NULL,
    PSW_TIPO                NCHAR(3)        DEFAULT ' '     NOT NULL,
    PASSWORD                NCHAR(51)       DEFAULT ' '     NOT NULL,
    PSW_VIG_DESD            DECIMAL(8)      DEFAULT  0      NOT NULL,
    PSW_ULTIMAS_001         NCHAR(51)       DEFAULT ' '     NOT NULL,
    PSW_ULTIMAS_002         NCHAR(51)       DEFAULT ' '     NOT NULL,
    PSW_ULTIMAS_003         NCHAR(51)       DEFAULT ' '     NOT NULL,
    PSW_ULTIMAS_004         NCHAR(51)       DEFAULT ' '     NOT NULL,
    PSW_ULTIMAS_005         NCHAR(51)       DEFAULT ' '     NOT NULL,
    PSW_ULTIMAS_006         NCHAR(51)       DEFAULT ' '     NOT NULL,
    PSW_DIAS_CADUC          DECIMAL(6)      DEFAULT  0      NOT NULL,
    PSW_ESTADO              NCHAR(3)        DEFAULT ' '     NOT NULL,
    RUT_INST                NCHAR(11)       DEFAULT ' '     NOT NULL,
    FAMILIA                 NCHAR(10)       DEFAULT ' '     NOT NULL,
    CARGO                   NCHAR(40)       DEFAULT ' '     NOT NULL,
    DIRECCION               NCHAR(40)       DEFAULT ' '     NOT NULL,
    COMUNA                  NCHAR(20)       DEFAULT ' '     NOT NULL,
    CIUDAD                  NCHAR(20)       DEFAULT ' '     NOT NULL,
    ESTADO                  NCHAR(20)       DEFAULT ' '     NOT NULL,
    PAIS                    NCHAR(20)       DEFAULT ' '     NOT NULL,
    FONO1                   NCHAR(20)       DEFAULT ' '     NOT NULL,
    FONO2                   NCHAR(20)       DEFAULT ' '     NOT NULL,
    FAX                     NCHAR(20)       DEFAULT ' '     NOT NULL,
    EMAIL                   NCHAR(40)       DEFAULT ' '     NOT NULL,
    FEC_REGISTRO            DECIMAL(8)      DEFAULT  0      NOT NULL,
    COD_CONTRATO            NCHAR(20)       DEFAULT ' '     NOT NULL,
    ANEXO_CONTRATO          NCHAR(10)       DEFAULT ' '     NOT NULL,
    FEC_VIG_DESD            DECIMAL(8)      DEFAULT  0      NOT NULL,
    FEC_VIG_HAST            DECIMAL(8)      DEFAULT  0      NOT NULL,
    FEC_CRE_USU             NCHAR(26)       DEFAULT ' '     NOT NULL,
    FEC_PRI_LOG             NCHAR(26)       DEFAULT ' '     NOT NULL,
    FEC_ULT_LOG             NCHAR(26)       DEFAULT ' '     NOT NULL,
    COD_FACTURACION         NCHAR(8)        DEFAULT ' '     NOT NULL,
    FACTURACION             NCHAR(1)        DEFAULT ' '     NOT NULL,
    DEMO_DIAS               DECIMAL(2)      DEFAULT  0      NOT NULL,
    DEMO_AUTO               NCHAR(16)       DEFAULT ' '     NOT NULL,
    DEMO_FEC_INI            DECIMAL(8)      DEFAULT  0      NOT NULL,
    DEMO_VECES              DECIMAL(2)      DEFAULT  0      NOT NULL,
    DEMO_DIAS_TOT           DECIMAL(4)      DEFAULT  0      NOT NULL,
    SW_CERT_DIG             NCHAR(1)        DEFAULT ' '     NOT NULL,
    USUARIOIM               NCHAR(1)        DEFAULT ' '     NOT NULL,
    NICKNAME                NCHAR(10)       DEFAULT ' '     NOT NULL,
    FEC_ERR_LOG             NCHAR(26)       DEFAULT ' '     NOT NULL,
    ERROR_LOGIN             DECIMAL(1)      DEFAULT  0      NOT NULL,
    CONSTRAINT EcuACCUSU_PK PRIMARY KEY (USU_CODIGO),
    CONSTRAINT EcuACCUSU_F1 FOREIGN KEY (FAMILIA)
        REFERENCES EcuACCFAM (V_FAM_FAMILIA)
);

--------------------------------------------------------------------------------
-- EcuACCU2P -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCU2P
(
    CODIGO_ADI              NCHAR(40)       DEFAULT ' '     NOT NULL,
    CODIGO_ECU              DECIMAL(7)      DEFAULT  0      NOT NULL,
    CONSTRAINT EcuACCU2P_PK PRIMARY KEY
        (CODIGO_ADI,CODIGO_ECU),
    CONSTRAINT EcuACCU2P_F1 FOREIGN KEY (CODIGO_ADI)
        REFERENCES EcuACCUSU (USU_CODIGO),
    CONSTRAINT EcuACCU2P_F2 FOREIGN KEY (CODIGO_ECU)
        REFERENCES EcuACCPER (V_ACC_CODE_NUM)
);

--------------------------------------------------------------------------------
-- EcuACCCAP -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCCAP
(
    CAP_CODIGO              NCHAR(40)       DEFAULT ' '     NOT NULL,
    CAP_NOMBRE              NCHAR(120)      DEFAULT ' '     NOT NULL,
    CAP_TIPO                DECIMAL(2)      DEFAULT  0      NOT NULL,
    CONSTRAINT EcuACCCAP_PK PRIMARY KEY (CAP_CODIGO)
);

--------------------------------------------------------------------------------
-- EcuACCC2U -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCC2U
(
    CODIGO_ADI              NCHAR(40)       DEFAULT ' '     NOT NULL,
    CAP_CODIGO              NCHAR(40)       DEFAULT ' '     NOT NULL,
    CAP_VALOR               NCHAR(200)      DEFAULT ' '     NOT NULL,
    CONSTRAINT EcuACCC2U_PK PRIMARY KEY
        (CODIGO_ADI,CAP_CODIGO),
    CONSTRAINT EcuACCC2U_F1 FOREIGN KEY (CODIGO_ADI)
        REFERENCES EcuACCUSU (USU_CODIGO),
    CONSTRAINT EcuACCC2U_F2 FOREIGN KEY (CAP_CODIGO)
        REFERENCES EcuACCCAP (CAP_CODIGO)
);

--------------------------------------------------------------------------------
-- EcuACCC2P -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCC2P
(
    CODIGO_ECU              DECIMAL(7)      DEFAULT  0      NOT NULL,
    CAP_CODIGO              NCHAR(40)       DEFAULT ' '     NOT NULL,
    CAP_VALOR               NCHAR(200)      DEFAULT ' '     NOT NULL,
    CONSTRAINT EcuACCC2P_PK PRIMARY KEY
        (CODIGO_ECU,CAP_CODIGO),
    CONSTRAINT EcuACCC2P_F1 FOREIGN KEY (CODIGO_ECU)
        REFERENCES EcuACCPER (V_ACC_CODE_NUM),
    CONSTRAINT EcuACCC2P_F2 FOREIGN KEY (CAP_CODIGO)
        REFERENCES EcuACCCAP (CAP_CODIGO)
);

--------------------------------------------------------------------------------
-- EcuACCCON -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCCON
(
    TIPO_REG                NCHAR(1)        DEFAULT ' '     NOT NULL,
    ECL_NAME                NCHAR(10)       DEFAULT ' '     NOT NULL,
    UNIQUE_ID               DECIMAL(16)     DEFAULT  0      NOT NULL,
    USUARIO                 NCHAR(40)       DEFAULT ' '     NOT NULL,
    CORREL                  DECIMAL(3)      DEFAULT  0      NOT NULL,
    TERMINAL                NCHAR(16)       DEFAULT ' '     NOT NULL,
    HORA_CONEX              NCHAR(26)       DEFAULT ' '     NOT NULL,
    ECL_ULT_PING            NCHAR(26)       DEFAULT ' '     NOT NULL,
    ECL_UPTIME              DECIMAL(12)     DEFAULT  0      NOT NULL,
    CONSTRAINT EcuACCCON_PK PRIMARY KEY (TIPO_REG,ECL_NAME,UNIQUE_ID),
    CONSTRAINT EcuACCCON_I1 UNIQUE (TIPO_REG,USUARIO,CORREL)
);

--------------------------------------------------------------------------------
-- EcuACCCTX -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCCTX
(
    STATION                 NCHAR(16)       DEFAULT ' '     NOT NULL,
    SUBDROP                 NCHAR(1)        DEFAULT ' '     NOT NULL,
    SECUENCIA               DECIMAL(4)      DEFAULT  0      NOT NULL,
    CODIGO_ADI              NCHAR(40)       DEFAULT ' '     NOT NULL,
    CODIGO_ECU              DECIMAL(7)      DEFAULT  0      NOT NULL,
    DATA                    NCLOB           DEFAULT ' '     NOT NULL,
    CONSTRAINT EcuACCCTX_PK PRIMARY KEY (STATION,SUBDROP,SECUENCIA)
);

--------------------------------------------------------------------------------
-- EcuACCLOG -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCLOG
(
    V_ECULOG_HORA           NCHAR(26)       DEFAULT ' '     NOT NULL,
    V_ECULOG_CODIGO_ADI     NCHAR(40)       DEFAULT ' '     NOT NULL,
    V_ECULOG_CODIGO_ECU     DECIMAL(7)      DEFAULT  0      NOT NULL,
    V_ECULOG_TERMINAL       NCHAR(16)       DEFAULT ' '     NOT NULL,
    V_ECULOG_CODIGO_MSG     DECIMAL(4)      DEFAULT  0      NOT NULL,
    V_ECULOG_MENSAJE        NCHAR(99)       DEFAULT ' '     NOT NULL,
    CONSTRAINT EcuACCLOG_PK PRIMARY KEY (V_ECULOG_HORA)
);

--------------------------------------------------------------------------------
-- EcuACCPRV -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCPRV
(
    V_PRV_TIPO              NCHAR(1)        DEFAULT ' '     NOT NULL,
    V_PRV_NUMERO            DECIMAL(2)      DEFAULT  0      NOT NULL,
    V_PRV_NOMBRE            NCHAR(20)       DEFAULT ' '     NOT NULL,
    V_PRV_CONST             NCHAR(20)       DEFAULT ' '     NOT NULL,
    V_PRV_SYSLOG            NCHAR(2)        DEFAULT ' '     NOT NULL,
    CONSTRAINT EcuACCPRV_PK PRIMARY KEY (V_PRV_TIPO,V_PRV_NUMERO)
);

--------------------------------------------------------------------------------

COMMIT;
QUIT;
