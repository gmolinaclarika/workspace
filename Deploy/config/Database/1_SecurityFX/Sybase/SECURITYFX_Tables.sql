--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------

IF EXISTS(SELECT * FROM sysobjects WHERE name = 'EcuACCPRV' AND type = 'U')
    DROP TABLE EcuACCPRV
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'EcuACCLOG' AND type = 'U')
    DROP TABLE EcuACCLOG
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'EcuACCCTX' AND type = 'U')
    DROP TABLE EcuACCCTX
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'EcuACCCON' AND type = 'U')
    DROP TABLE EcuACCCON
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'EcuACCC2P' AND type = 'U')
    DROP TABLE EcuACCC2P
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'EcuACCC2U' AND type = 'U')
    DROP TABLE EcuACCC2U
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'EcuACCCAP' AND type = 'U')
    DROP TABLE EcuACCCAP
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'EcuACCU2P' AND type = 'U')
    DROP TABLE EcuACCU2P
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'EcuACCUSU' AND type = 'U')
    DROP TABLE EcuACCUSU
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'EcuACCPER' AND type = 'U')
    DROP TABLE EcuACCPER
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'EcuACCNET' AND type = 'U')
    DROP TABLE EcuACCNET
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'EcuACCFAM' AND type = 'U')
    DROP TABLE EcuACCFAM
GO

--------------------------------------------------------------------------------
-- EcuACCFAM -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCFAM
(
    V_FAM_FAMILIA           NCHAR(10)       NOT NULL    DEFAULT '',
    V_FAM_NOMBRE_USUARIO    NCHAR(40)       NOT NULL    DEFAULT '',
    V_FAM_UBICACION         NCHAR(40)       NOT NULL    DEFAULT '',
    V_FAM_TEXTO1            NCHAR(40)       NOT NULL    DEFAULT '',
    V_FAM_TEXTO2            NCHAR(40)       NOT NULL    DEFAULT '',
    V_FAM_TEXTO3            NCHAR(40)       NOT NULL    DEFAULT '',
    V_FAM_TEXTO4            NCHAR(40)       NOT NULL    DEFAULT '',
    CONSTRAINT EcuACCFAM_PK PRIMARY KEY CLUSTERED (V_FAM_FAMILIA)
)
GO

--------------------------------------------------------------------------------
-- EcuACCNET -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCNET
(
    V_NET_NOMBRE            NCHAR(16)       NOT NULL    DEFAULT '',
    V_NET_FAMILIA           NCHAR(10)       NOT NULL    DEFAULT '',
    V_NET_TIPO              NCHAR(1)        NOT NULL    DEFAULT '',
    V_NET_DIRECCION_IP      NCHAR(16)       NOT NULL    DEFAULT '',
    V_NET_POLL_PRIMARIO     NCHAR(10)       NOT NULL    DEFAULT '',
    V_NET_POLL_BACKUP       NCHAR(10)       NOT NULL    DEFAULT '',
    V_NET_CIRCUITO          DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    V_NET_MASTERKEY1        NCHAR(16)       NOT NULL    DEFAULT '',
    V_NET_MASTERKEY2        NCHAR(16)       NOT NULL    DEFAULT '',
    V_NET_HORA_KEY1         NCHAR(26)       NOT NULL    DEFAULT '',
    V_NET_HORA_KEY2         NCHAR(26)       NOT NULL    DEFAULT '',
    V_NET_GRUPO_DYN         NCHAR(10)       NOT NULL    DEFAULT '',
    V_NET_PRINTER           NCHAR(10)       NOT NULL    DEFAULT '',
    V_NET_NOMBRE_USUARIO    NCHAR(40)       NOT NULL    DEFAULT '',
    V_NET_UBICACION         NCHAR(40)       NOT NULL    DEFAULT '',
    V_NET_TEXTO1            NCHAR(40)       NOT NULL    DEFAULT '',
    V_NET_TEXTO2            NCHAR(40)       NOT NULL    DEFAULT '',
    V_NET_TEXTO3            NCHAR(40)       NOT NULL    DEFAULT '',
    V_NET_TEXTO4            NCHAR(40)       NOT NULL    DEFAULT '',
    V_NET_SERIETERM         NCHAR(20)       NOT NULL    DEFAULT '',
    V_NET_HABILITADO        NCHAR(1)        NOT NULL    DEFAULT '',
    CONSTRAINT EcuACCNET_PK PRIMARY KEY CLUSTERED (V_NET_NOMBRE),
    CONSTRAINT EcuACCNET_F1 FOREIGN KEY (V_NET_FAMILIA)
        REFERENCES EcuACCFAM (V_FAM_FAMILIA)
)
GO

--------------------------------------------------------------------------------
-- EcuACCPER -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCPER
(
    V_ACC_CODE_NUM          DECIMAL(7)      NOT NULL    DEFAULT 0 ,
    V_ACC_PRIV_MEN          NCHAR(32)       NOT NULL    DEFAULT '',
    V_ACC_PRIV_VARL         NCHAR(32)       NOT NULL    DEFAULT '',
    V_ACC_PRIV_VARM         NCHAR(32)       NOT NULL    DEFAULT '',
    V_ACC_PRIV_REGL         NCHAR(32)       NOT NULL    DEFAULT '',
    V_ACC_PRIV_REGM         NCHAR(32)       NOT NULL    DEFAULT '',
    V_ACC_NAME              NCHAR(30)       NOT NULL    DEFAULT '',
    V_ACC_EXP               DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    V_ACC_INDICADORES       NCHAR(6)        NOT NULL    DEFAULT '',
    V_ACC_HORA_INIC         DECIMAL(4,2)    NOT NULL    DEFAULT 0 ,
    V_ACC_HORA_FIN          DECIMAL(4,2)    NOT NULL    DEFAULT 0 ,
    V_ACC_CLASE_PD          NCHAR(1)        NOT NULL    DEFAULT '',
    V_ACC_PROG_INI          NCHAR(12)       NOT NULL    DEFAULT '',
    V_ACC_FAMILIA           NCHAR(10)       NOT NULL    DEFAULT '',
    V_ACC_CANT_TERM         DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    V_ACC_TERM_001          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_TERM_002          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_TERM_003          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_TERM_004          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_TERM_005          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_TERM_006          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_TERM_007          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_TERM_008          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_TERM_009          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_TERM_010          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_TERM_011          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_TERM_012          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_TERM_013          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_TERM_014          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_TERM_015          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_TERM_016          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_DIAS_VIG_PASSW    DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    V_ACC_VIG_PASSW         DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    V_ACC_PASSWORD          DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    V_ACC_OTRAS_PASSW_001   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    V_ACC_OTRAS_PASSW_002   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    V_ACC_OTRAS_PASSW_003   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    V_ACC_OTRAS_PASSW_004   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    V_ACC_OTRAS_PASSW_005   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    V_ACC_OTRAS_PASSW_006   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    V_ACC_FAM_IMPR          NCHAR(10)       NOT NULL    DEFAULT '',
    V_ACC_IMPR_PRE          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_CANT_IMPR         DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    V_ACC_IMPR_001          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_IMPR_002          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_IMPR_003          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_IMPR_004          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_IMPR_005          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_IMPR_006          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_IMPR_007          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_IMPR_008          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_IMPR_009          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_IMPR_010          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_IMPR_011          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_IMPR_012          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_IMPR_013          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_IMPR_014          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_IMPR_015          NCHAR(16)       NOT NULL    DEFAULT '',
    V_ACC_IMPR_016          NCHAR(16)       NOT NULL    DEFAULT '',
    CONSTRAINT EcuACCPER_PK PRIMARY KEY CLUSTERED (V_ACC_CODE_NUM),
    CONSTRAINT EcuACCPER_F1 FOREIGN KEY (V_ACC_FAMILIA)
        REFERENCES EcuACCFAM (V_FAM_FAMILIA)
)
GO

--------------------------------------------------------------------------------
-- EcuACCUSU -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCUSU
(
    USU_CODIGO              NCHAR(40)       NOT NULL    DEFAULT '',
    APELLIDO_PAT            NCHAR(20)       NOT NULL    DEFAULT '',
    APELLIDO_MAT            NCHAR(20)       NOT NULL    DEFAULT '',
    NOMBRES                 NCHAR(30)       NOT NULL    DEFAULT '',
    RUT                     NCHAR(11)       NOT NULL    DEFAULT '',
    USU_ESTADO              NCHAR(2)        NOT NULL    DEFAULT '',
    CERTIF_ID               NCHAR(26)       NOT NULL    DEFAULT '',
    PSW_TIPO                NCHAR(3)        NOT NULL    DEFAULT '',
    PASSWORD                NCHAR(51)       NOT NULL    DEFAULT '',
    PSW_VIG_DESD            DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    PSW_ULTIMAS_001         NCHAR(51)       NOT NULL    DEFAULT '',
    PSW_ULTIMAS_002         NCHAR(51)       NOT NULL    DEFAULT '',
    PSW_ULTIMAS_003         NCHAR(51)       NOT NULL    DEFAULT '',
    PSW_ULTIMAS_004         NCHAR(51)       NOT NULL    DEFAULT '',
    PSW_ULTIMAS_005         NCHAR(51)       NOT NULL    DEFAULT '',
    PSW_ULTIMAS_006         NCHAR(51)       NOT NULL    DEFAULT '',
    PSW_DIAS_CADUC          DECIMAL(6)      NOT NULL    DEFAULT 0 ,
    PSW_ESTADO              NCHAR(3)        NOT NULL    DEFAULT '',
    RUT_INST                NCHAR(11)       NOT NULL    DEFAULT '',
    FAMILIA                 NCHAR(10)       NOT NULL    DEFAULT '',
    CARGO                   NCHAR(40)       NOT NULL    DEFAULT '',
    DIRECCION               NCHAR(40)       NOT NULL    DEFAULT '',
    COMUNA                  NCHAR(20)       NOT NULL    DEFAULT '',
    CIUDAD                  NCHAR(20)       NOT NULL    DEFAULT '',
    ESTADO                  NCHAR(20)       NOT NULL    DEFAULT '',
    PAIS                    NCHAR(20)       NOT NULL    DEFAULT '',
    FONO1                   NCHAR(20)       NOT NULL    DEFAULT '',
    FONO2                   NCHAR(20)       NOT NULL    DEFAULT '',
    FAX                     NCHAR(20)       NOT NULL    DEFAULT '',
    EMAIL                   NCHAR(40)       NOT NULL    DEFAULT '',
    FEC_REGISTRO            DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    COD_CONTRATO            NCHAR(20)       NOT NULL    DEFAULT '',
    ANEXO_CONTRATO          NCHAR(10)       NOT NULL    DEFAULT '',
    FEC_VIG_DESD            DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    FEC_VIG_HAST            DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    FEC_CRE_USU             NCHAR(26)       NOT NULL    DEFAULT '',
    FEC_PRI_LOG             NCHAR(26)       NOT NULL    DEFAULT '',
    FEC_ULT_LOG             NCHAR(26)       NOT NULL    DEFAULT '',
    COD_FACTURACION         NCHAR(8)        NOT NULL    DEFAULT '',
    FACTURACION             NCHAR(1)        NOT NULL    DEFAULT '',
    DEMO_DIAS               DECIMAL(2)      NOT NULL    DEFAULT 0 ,
    DEMO_AUTO               NCHAR(16)       NOT NULL    DEFAULT '',
    DEMO_FEC_INI            DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    DEMO_VECES              DECIMAL(2)      NOT NULL    DEFAULT 0 ,
    DEMO_DIAS_TOT           DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    SW_CERT_DIG             NCHAR(1)        NOT NULL    DEFAULT '',
    USUARIOIM               NCHAR(1)        NOT NULL    DEFAULT '',
    NICKNAME                NCHAR(10)       NOT NULL    DEFAULT '',
    FEC_ERR_LOG             NCHAR(26)       NOT NULL    DEFAULT '',
    ERROR_LOGIN             DECIMAL(1)      NOT NULL    DEFAULT 0 ,
    CONSTRAINT EcuACCUSU_PK PRIMARY KEY CLUSTERED (USU_CODIGO),
    CONSTRAINT EcuACCUSU_F1 FOREIGN KEY (FAMILIA)
        REFERENCES EcuACCFAM (V_FAM_FAMILIA)
)
GO

--------------------------------------------------------------------------------
-- EcuACCU2P -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCU2P
(
    CODIGO_ADI              NCHAR(40)       NOT NULL    DEFAULT '',
    CODIGO_ECU              DECIMAL(7)      NOT NULL    DEFAULT 0 ,
    CONSTRAINT EcuACCU2P_PK PRIMARY KEY
        CLUSTERED (CODIGO_ADI,CODIGO_ECU),
    CONSTRAINT EcuACCU2P_F1 FOREIGN KEY (CODIGO_ADI)
        REFERENCES EcuACCUSU (USU_CODIGO),
    CONSTRAINT EcuACCU2P_F2 FOREIGN KEY (CODIGO_ECU)
        REFERENCES EcuACCPER (V_ACC_CODE_NUM)
)
GO

--------------------------------------------------------------------------------
-- EcuACCCAP -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCCAP
(
    CAP_CODIGO              NCHAR(40)       NOT NULL    DEFAULT '',
    CAP_NOMBRE              NCHAR(120)      NOT NULL    DEFAULT '',
    CAP_TIPO                DECIMAL(2)      NOT NULL    DEFAULT 0 ,
    CONSTRAINT EcuACCCAP_PK PRIMARY KEY CLUSTERED (CAP_CODIGO)
)
GO

--------------------------------------------------------------------------------
-- EcuACCC2U -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCC2U
(
    CODIGO_ADI              NCHAR(40)       NOT NULL    DEFAULT '',
    CAP_CODIGO              NCHAR(40)       NOT NULL    DEFAULT '',
    CAP_VALOR               NCHAR(200)      NOT NULL    DEFAULT '',
    CONSTRAINT EcuACCC2U_PK PRIMARY KEY
        CLUSTERED (CODIGO_ADI,CAP_CODIGO),
    CONSTRAINT EcuACCC2U_F1 FOREIGN KEY (CODIGO_ADI)
        REFERENCES EcuACCUSU (USU_CODIGO),
    CONSTRAINT EcuACCC2U_F2 FOREIGN KEY (CAP_CODIGO)
        REFERENCES EcuACCCAP (CAP_CODIGO)
)
GO

--------------------------------------------------------------------------------
-- EcuACCC2P -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCC2P
(
    CODIGO_ECU              DECIMAL(7)      NOT NULL    DEFAULT 0 ,
    CAP_CODIGO              NCHAR(40)       NOT NULL    DEFAULT '',
    CAP_VALOR               NCHAR(200)      NOT NULL    DEFAULT '',
    CONSTRAINT EcuACCC2P_PK PRIMARY KEY
        CLUSTERED (CODIGO_ECU,CAP_CODIGO),
    CONSTRAINT EcuACCC2P_F1 FOREIGN KEY (CODIGO_ECU)
        REFERENCES EcuACCPER (V_ACC_CODE_NUM),
    CONSTRAINT EcuACCC2P_F2 FOREIGN KEY (CAP_CODIGO)
        REFERENCES EcuACCCAP (CAP_CODIGO)
)
GO

--------------------------------------------------------------------------------
-- EcuACCCON -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCCON
(
    TIPO_REG                NCHAR(1)        NOT NULL    DEFAULT '',
    ECL_NAME                NCHAR(10)       NOT NULL    DEFAULT '',
    UNIQUE_ID               DECIMAL(16)     NOT NULL    DEFAULT 0 ,
    USUARIO                 NCHAR(40)       NOT NULL    DEFAULT '',
    CORREL                  DECIMAL(3)      NOT NULL    DEFAULT 0 ,
    TERMINAL                NCHAR(16)       NOT NULL    DEFAULT '',
    HORA_CONEX              NCHAR(26)       NOT NULL    DEFAULT '',
    ECL_ULT_PING            NCHAR(26)       NOT NULL    DEFAULT '',
    ECL_UPTIME              DECIMAL(12)     NOT NULL    DEFAULT 0 ,
    CONSTRAINT EcuACCCON_PK PRIMARY KEY CLUSTERED (TIPO_REG,ECL_NAME,UNIQUE_ID),
    CONSTRAINT EcuACCCON_I1 UNIQUE (TIPO_REG,USUARIO,CORREL)
)
GO

--------------------------------------------------------------------------------
-- EcuACCCTX -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCCTX
(
    STATION                 NCHAR(16)       NOT NULL    DEFAULT '',
    SUBDROP                 NCHAR(1)        NOT NULL    DEFAULT '',
    SECUENCIA               DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    CODIGO_ADI              NCHAR(40)       NOT NULL    DEFAULT '',
    CODIGO_ECU              DECIMAL(7)      NOT NULL    DEFAULT 0 ,
    DATA                    NTEXT           NOT NULL    DEFAULT '',
    CONSTRAINT EcuACCCTX_PK PRIMARY KEY CLUSTERED (STATION,SUBDROP,SECUENCIA)
)
GO

--------------------------------------------------------------------------------
-- EcuACCLOG -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCLOG
(
    V_ECULOG_HORA           NCHAR(26)       NOT NULL    DEFAULT '',
    V_ECULOG_CODIGO_ADI     NCHAR(40)       NOT NULL    DEFAULT '',
    V_ECULOG_CODIGO_ECU     DECIMAL(7)      NOT NULL    DEFAULT 0 ,
    V_ECULOG_TERMINAL       NCHAR(16)       NOT NULL    DEFAULT '',
    V_ECULOG_CODIGO_MSG     DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    V_ECULOG_MENSAJE        NCHAR(99)       NOT NULL    DEFAULT '',
    CONSTRAINT EcuACCLOG_PK PRIMARY KEY CLUSTERED (V_ECULOG_HORA)
)
GO

--------------------------------------------------------------------------------
-- EcuACCPRV -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE EcuACCPRV
(
    V_PRV_TIPO              NCHAR(1)        NOT NULL    DEFAULT '',
    V_PRV_NUMERO            DECIMAL(2)      NOT NULL    DEFAULT 0 ,
    V_PRV_NOMBRE            NCHAR(20)       NOT NULL    DEFAULT '',
    V_PRV_CONST             NCHAR(20)       NOT NULL    DEFAULT '',
    V_PRV_SYSLOG            NCHAR(2)        NOT NULL    DEFAULT '',
    CONSTRAINT EcuACCPRV_PK PRIMARY KEY CLUSTERED (V_PRV_TIPO,V_PRV_NUMERO)
)
GO

--------------------------------------------------------------------------------
