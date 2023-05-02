--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------

DROP TABLE IF EXISTS ecuaccprv CASCADE;
DROP TABLE IF EXISTS ecuacclog CASCADE;
DROP TABLE IF EXISTS ecuaccctx CASCADE;
DROP TABLE IF EXISTS ecuacccon CASCADE;
DROP TABLE IF EXISTS ecuaccc2p CASCADE;
DROP TABLE IF EXISTS ecuaccc2u CASCADE;
DROP TABLE IF EXISTS ecuacccap CASCADE;
DROP TABLE IF EXISTS ecuaccu2p CASCADE;
DROP TABLE IF EXISTS ecuaccusu CASCADE;
DROP TABLE IF EXISTS ecuaccper CASCADE;
DROP TABLE IF EXISTS ecuaccnet CASCADE;
DROP TABLE IF EXISTS ecuaccfam CASCADE;

--------------------------------------------------------------------------------
-- EcuACCFAM -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE ecuaccfam
(
    v_fam_familia           CHAR(10)        NOT NULL    DEFAULT '',
    v_fam_nombre_usuario    CHAR(40)        NOT NULL    DEFAULT '',
    v_fam_ubicacion         CHAR(40)        NOT NULL    DEFAULT '',
    v_fam_texto1            CHAR(40)        NOT NULL    DEFAULT '',
    v_fam_texto2            CHAR(40)        NOT NULL    DEFAULT '',
    v_fam_texto3            CHAR(40)        NOT NULL    DEFAULT '',
    v_fam_texto4            CHAR(40)        NOT NULL    DEFAULT '',
    CONSTRAINT ecuaccfam_pk PRIMARY KEY (v_fam_familia)
);

--------------------------------------------------------------------------------
-- EcuACCNET -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE ecuaccnet
(
    v_net_nombre            CHAR(16)        NOT NULL    DEFAULT '',
    v_net_familia           CHAR(10)        NOT NULL    DEFAULT '',
    v_net_tipo              CHAR(1)         NOT NULL    DEFAULT '',
    v_net_direccion_ip      CHAR(16)        NOT NULL    DEFAULT '',
    v_net_poll_primario     CHAR(10)        NOT NULL    DEFAULT '',
    v_net_poll_backup       CHAR(10)        NOT NULL    DEFAULT '',
    v_net_circuito          DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    v_net_masterkey1        CHAR(16)        NOT NULL    DEFAULT '',
    v_net_masterkey2        CHAR(16)        NOT NULL    DEFAULT '',
    v_net_hora_key1         CHAR(26)        NOT NULL    DEFAULT '',
    v_net_hora_key2         CHAR(26)        NOT NULL    DEFAULT '',
    v_net_grupo_dyn         CHAR(10)        NOT NULL    DEFAULT '',
    v_net_printer           CHAR(10)        NOT NULL    DEFAULT '',
    v_net_nombre_usuario    CHAR(40)        NOT NULL    DEFAULT '',
    v_net_ubicacion         CHAR(40)        NOT NULL    DEFAULT '',
    v_net_texto1            CHAR(40)        NOT NULL    DEFAULT '',
    v_net_texto2            CHAR(40)        NOT NULL    DEFAULT '',
    v_net_texto3            CHAR(40)        NOT NULL    DEFAULT '',
    v_net_texto4            CHAR(40)        NOT NULL    DEFAULT '',
    v_net_serieterm         CHAR(20)        NOT NULL    DEFAULT '',
    v_net_habilitado        CHAR(1)         NOT NULL    DEFAULT '',
    CONSTRAINT ecuaccnet_pk PRIMARY KEY (v_net_nombre),
    CONSTRAINT ecuaccnet_f1 FOREIGN KEY (v_net_familia)
        REFERENCES ecuaccfam (v_fam_familia)
);

--------------------------------------------------------------------------------
-- EcuACCPER -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE ecuaccper
(
    v_acc_code_num          DECIMAL(7)      NOT NULL    DEFAULT 0 ,
    v_acc_priv_men          CHAR(32)        NOT NULL    DEFAULT '',
    v_acc_priv_varl         CHAR(32)        NOT NULL    DEFAULT '',
    v_acc_priv_varm         CHAR(32)        NOT NULL    DEFAULT '',
    v_acc_priv_regl         CHAR(32)        NOT NULL    DEFAULT '',
    v_acc_priv_regm         CHAR(32)        NOT NULL    DEFAULT '',
    v_acc_name              CHAR(30)        NOT NULL    DEFAULT '',
    v_acc_exp               DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    v_acc_indicadores       CHAR(6)         NOT NULL    DEFAULT '',
    v_acc_hora_inic         DECIMAL(4,2)    NOT NULL    DEFAULT 0 ,
    v_acc_hora_fin          DECIMAL(4,2)    NOT NULL    DEFAULT 0 ,
    v_acc_clase_pd          CHAR(1)         NOT NULL    DEFAULT '',
    v_acc_prog_ini          CHAR(12)        NOT NULL    DEFAULT '',
    v_acc_familia           CHAR(10)        NOT NULL    DEFAULT '',
    v_acc_cant_term         DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    v_acc_term_001          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_term_002          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_term_003          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_term_004          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_term_005          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_term_006          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_term_007          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_term_008          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_term_009          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_term_010          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_term_011          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_term_012          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_term_013          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_term_014          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_term_015          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_term_016          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_dias_vig_passw    DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    v_acc_vig_passw         DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    v_acc_password          DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    v_acc_otras_passw_001   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    v_acc_otras_passw_002   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    v_acc_otras_passw_003   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    v_acc_otras_passw_004   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    v_acc_otras_passw_005   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    v_acc_otras_passw_006   DECIMAL(18)     NOT NULL    DEFAULT 0 ,
    v_acc_fam_impr          CHAR(10)        NOT NULL    DEFAULT '',
    v_acc_impr_pre          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_cant_impr         DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    v_acc_impr_001          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_impr_002          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_impr_003          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_impr_004          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_impr_005          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_impr_006          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_impr_007          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_impr_008          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_impr_009          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_impr_010          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_impr_011          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_impr_012          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_impr_013          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_impr_014          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_impr_015          CHAR(16)        NOT NULL    DEFAULT '',
    v_acc_impr_016          CHAR(16)        NOT NULL    DEFAULT '',
    CONSTRAINT ecuaccper_pk PRIMARY KEY (v_acc_code_num),
    CONSTRAINT ecuaccper_f1 FOREIGN KEY (v_acc_familia)
        REFERENCES ecuaccfam (v_fam_familia)
);

--------------------------------------------------------------------------------
-- EcuACCUSU -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE ecuaccusu
(
    usu_codigo              CHAR(40)        NOT NULL    DEFAULT '',
    apellido_pat            CHAR(20)        NOT NULL    DEFAULT '',
    apellido_mat            CHAR(20)        NOT NULL    DEFAULT '',
    nombres                 CHAR(30)        NOT NULL    DEFAULT '',
    rut                     CHAR(11)        NOT NULL    DEFAULT '',
    usu_estado              CHAR(2)         NOT NULL    DEFAULT '',
    certif_id               CHAR(26)        NOT NULL    DEFAULT '',
    psw_tipo                CHAR(3)         NOT NULL    DEFAULT '',
    password                CHAR(51)        NOT NULL    DEFAULT '',
    psw_vig_desd            DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    psw_ultimas_001         CHAR(51)        NOT NULL    DEFAULT '',
    psw_ultimas_002         CHAR(51)        NOT NULL    DEFAULT '',
    psw_ultimas_003         CHAR(51)        NOT NULL    DEFAULT '',
    psw_ultimas_004         CHAR(51)        NOT NULL    DEFAULT '',
    psw_ultimas_005         CHAR(51)        NOT NULL    DEFAULT '',
    psw_ultimas_006         CHAR(51)        NOT NULL    DEFAULT '',
    psw_dias_caduc          DECIMAL(6)      NOT NULL    DEFAULT 0 ,
    psw_estado              CHAR(3)         NOT NULL    DEFAULT '',
    rut_inst                CHAR(11)        NOT NULL    DEFAULT '',
    familia                 CHAR(10)        NOT NULL    DEFAULT '',
    cargo                   CHAR(40)        NOT NULL    DEFAULT '',
    direccion               CHAR(40)        NOT NULL    DEFAULT '',
    comuna                  CHAR(20)        NOT NULL    DEFAULT '',
    ciudad                  CHAR(20)        NOT NULL    DEFAULT '',
    estado                  CHAR(20)        NOT NULL    DEFAULT '',
    pais                    CHAR(20)        NOT NULL    DEFAULT '',
    fono1                   CHAR(20)        NOT NULL    DEFAULT '',
    fono2                   CHAR(20)        NOT NULL    DEFAULT '',
    fax                     CHAR(20)        NOT NULL    DEFAULT '',
    email                   CHAR(40)        NOT NULL    DEFAULT '',
    fec_registro            DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    cod_contrato            CHAR(20)        NOT NULL    DEFAULT '',
    anexo_contrato          CHAR(10)        NOT NULL    DEFAULT '',
    fec_vig_desd            DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    fec_vig_hast            DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    fec_cre_usu             CHAR(26)        NOT NULL    DEFAULT '',
    fec_pri_log             CHAR(26)        NOT NULL    DEFAULT '',
    fec_ult_log             CHAR(26)        NOT NULL    DEFAULT '',
    cod_facturacion         CHAR(8)         NOT NULL    DEFAULT '',
    facturacion             CHAR(1)         NOT NULL    DEFAULT '',
    demo_dias               DECIMAL(2)      NOT NULL    DEFAULT 0 ,
    demo_auto               CHAR(16)        NOT NULL    DEFAULT '',
    demo_fec_ini            DECIMAL(8)      NOT NULL    DEFAULT 0 ,
    demo_veces              DECIMAL(2)      NOT NULL    DEFAULT 0 ,
    demo_dias_tot           DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    sw_cert_dig             CHAR(1)         NOT NULL    DEFAULT '',
    usuarioim               CHAR(1)         NOT NULL    DEFAULT '',
    nickname                CHAR(10)        NOT NULL    DEFAULT '',
    fec_err_log             CHAR(26)        NOT NULL    DEFAULT '',
    error_login             DECIMAL(1)      NOT NULL    DEFAULT 0 ,
    CONSTRAINT ecuaccusu_pk PRIMARY KEY (usu_codigo),
    CONSTRAINT ecuaccusu_f1 FOREIGN KEY (familia)
        REFERENCES ecuaccfam (v_fam_familia)
);

--------------------------------------------------------------------------------
-- EcuACCU2P -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE ecuaccu2p
(
    codigo_adi              CHAR(40)        NOT NULL    DEFAULT '',
    codigo_ecu              DECIMAL(7)      NOT NULL    DEFAULT 0 ,
    CONSTRAINT ecuaccu2p_pk PRIMARY KEY
        (codigo_adi,codigo_ecu),
    CONSTRAINT ecuaccu2p_f1 FOREIGN KEY (codigo_adi)
        REFERENCES ecuaccusu (usu_codigo),
    CONSTRAINT ecuaccu2p_f2 FOREIGN KEY (codigo_ecu)
        REFERENCES ecuaccper (v_acc_code_num)
);

--------------------------------------------------------------------------------
-- EcuACCCAP -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE ecuacccap
(
    cap_codigo              CHAR(40)        NOT NULL    DEFAULT '',
    cap_nombre              CHAR(120)       NOT NULL    DEFAULT '',
    cap_tipo                DECIMAL(2)      NOT NULL    DEFAULT 0 ,
    CONSTRAINT ecuacccap_pk PRIMARY KEY (cap_codigo)
);

--------------------------------------------------------------------------------
-- EcuACCC2U -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE ecuaccc2u
(
    codigo_adi              CHAR(40)        NOT NULL    DEFAULT '',
    cap_codigo              CHAR(40)        NOT NULL    DEFAULT '',
    cap_valor               CHAR(200)       NOT NULL    DEFAULT '',
    CONSTRAINT ecuaccc2u_pk PRIMARY KEY
        (codigo_adi,cap_codigo),
    CONSTRAINT ecuaccc2u_f1 FOREIGN KEY (codigo_adi)
        REFERENCES ecuaccusu (usu_codigo),
    CONSTRAINT ecuaccc2u_f2 FOREIGN KEY (cap_codigo)
        REFERENCES ecuacccap (cap_codigo)
);

--------------------------------------------------------------------------------
-- EcuACCC2P -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE ecuaccc2p
(
    codigo_ecu              DECIMAL(7)      NOT NULL    DEFAULT 0 ,
    cap_codigo              CHAR(40)        NOT NULL    DEFAULT '',
    cap_valor               CHAR(200)       NOT NULL    DEFAULT '',
    CONSTRAINT ecuaccc2p_pk PRIMARY KEY
        (codigo_ecu,cap_codigo),
    CONSTRAINT ecuaccc2p_f1 FOREIGN KEY (codigo_ecu)
        REFERENCES ecuaccper (v_acc_code_num),
    CONSTRAINT ecuaccc2p_f2 FOREIGN KEY (cap_codigo)
        REFERENCES ecuacccap (cap_codigo)
);

--------------------------------------------------------------------------------
-- EcuACCCON -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE ecuacccon
(
    tipo_reg                CHAR(1)         NOT NULL    DEFAULT '',
    ecl_name                CHAR(10)        NOT NULL    DEFAULT '',
    unique_id               DECIMAL(16)     NOT NULL    DEFAULT 0 ,
    usuario                 CHAR(40)        NOT NULL    DEFAULT '',
    correl                  DECIMAL(3)      NOT NULL    DEFAULT 0 ,
    terminal                CHAR(16)        NOT NULL    DEFAULT '',
    hora_conex              CHAR(26)        NOT NULL    DEFAULT '',
    ecl_ult_ping            CHAR(26)        NOT NULL    DEFAULT '',
    ecl_uptime              DECIMAL(12,0)   NOT NULL    DEFAULT 0 ,
    CONSTRAINT ecuacccon_pk PRIMARY KEY (tipo_reg,ecl_name,unique_id),
    CONSTRAINT ecuacccon_i1 UNIQUE (tipo_reg,usuario,correl)
);

--------------------------------------------------------------------------------
-- EcuACCCTX -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE ecuaccctx
(
    station                 CHAR(16)        NOT NULL    DEFAULT '',
    subdrop                 CHAR(1)         NOT NULL    DEFAULT '',
    secuencia               DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    codigo_adi              CHAR(40)        NOT NULL    DEFAULT '',
    codigo_ecu              DECIMAL(7)      NOT NULL    DEFAULT 0 ,
    data                    TEXT            NOT NULL    DEFAULT '',
    CONSTRAINT ecuaccctx_pk PRIMARY KEY (station,subdrop,secuencia)
);

--------------------------------------------------------------------------------
-- EcuACCLOG -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE ecuacclog
(
    v_eculog_hora           CHAR(26)        NOT NULL    DEFAULT '',
    v_eculog_codigo_adi     CHAR(40)        NOT NULL    DEFAULT '',
    v_eculog_codigo_ecu     DECIMAL(7)      NOT NULL    DEFAULT 0 ,
    v_eculog_terminal       CHAR(16)        NOT NULL    DEFAULT '',
    v_eculog_codigo_msg     DECIMAL(4)      NOT NULL    DEFAULT 0 ,
    v_eculog_mensaje        CHAR(99)        NOT NULL    DEFAULT '',
    CONSTRAINT ecuacclog_pk PRIMARY KEY (v_eculog_hora)
);

--------------------------------------------------------------------------------
-- EcuACCPRV -------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE ecuaccprv
(
    v_prv_tipo              CHAR(1)         NOT NULL    DEFAULT '',
    v_prv_numero            DECIMAL(2)      NOT NULL    DEFAULT 0 ,
    v_prv_nombre            CHAR(20)        NOT NULL    DEFAULT '',
    v_prv_const             CHAR(20)        NOT NULL    DEFAULT '',
    v_prv_syslog            CHAR(2)         NOT NULL    DEFAULT '',
    CONSTRAINT ecuaccprv_pk PRIMARY KEY (v_prv_tipo,v_prv_numero)
);

--------------------------------------------------------------------------------
