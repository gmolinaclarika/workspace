--------------------------------------------------------------------------------
-- Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
--
-- All rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
-- used  under  the  terms of its associated license document. You may NOT copy,
-- modify, sublicense, or distribute this source file or portions of  it  unless
-- previously  authorized in writing by OBCOM INGENIERIA S.A. In any event, this
-- notice and above copyright must always be included verbatim with this file.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- EcuACCFAM -------------------------------------------------------------------
--------------------------------------------------------------------------------

INSERT INTO ecuaccfam 
    (v_fam_familia, v_fam_nombre_usuario, v_fam_ubicacion) 
VALUES 
    ('GENERAL', 'Todos los usuarios del sistema', 'Todos los terminales del sistema');

--------------------------------------------------------------------------------
-- EcuACCPER -------------------------------------------------------------------
--------------------------------------------------------------------------------

INSERT INTO ecuaccper 
    (v_acc_code_num,
    v_acc_priv_men,
    v_acc_priv_varl,
    v_acc_priv_varm,
    v_acc_priv_regl,
    v_acc_priv_regm,
    v_acc_name,
    v_acc_exp,
    v_acc_indicadores,
    v_acc_hora_fin,
    v_acc_prog_ini,
    v_acc_familia,
    v_acc_vig_passw,
    v_acc_password) 
VALUES 
    (0000000,
    '11111111111111111111111111111111',
    '11111111111111111111111111111111',
    '11111111111111111111111111111111',
    '11111111111111111111111111111111',
    '11111111111111111111111111111111',
    'Administrador global',
    29991231,
    'NAN',
    24,
    'DEFAULT',
    'GENERAL',
    20010101,
    71757147231059);

--------------------------------------------------------------------------------
-- EcuACCUSU -------------------------------------------------------------------
--------------------------------------------------------------------------------

INSERT INTO ecuaccusu 
    (usu_codigo,
    nombres,
    usu_estado,
    psw_tipo,
    password,
    psw_vig_desd,
    psw_estado,
    familia,
    fec_vig_desd,
    fec_vig_hast,
    fec_cre_usu,
    fec_pri_log,
    fec_ult_log,
    fec_err_log,
    facturacion,
    usuarioim) 
VALUES 
    ('ADMIN',
    'Administrador',
    'HA',
    'NCA',
    '274134938239713600904252160475958409042521604759584',
    20010101,
    'VIG',
    'GENERAL',
    20010101,
    29991231,
    '0001-01-01:00:00:00.000000',
    '0001-01-01:00:00:00.000000',
    '0001-01-01:00:00:00.000000',
    '0001-01-01:00:00:00.000000',
    'B',
    'S');

--------------------------------------------------------------------------------
-- EcuACCU2P -------------------------------------------------------------------
--------------------------------------------------------------------------------

INSERT INTO ecuaccu2p 
    (codigo_adi, codigo_ecu) 
VALUES 
    ('ADMIN', 0000000);

--------------------------------------------------------------------------------
-- EcuACCPRV -------------------------------------------------------------------
--------------------------------------------------------------------------------

INSERT INTO ecuaccprv 
    (v_prv_tipo, v_prv_numero, v_prv_nombre, v_prv_const, v_prv_syslog) 
VALUES 
    ('C', 1, 'Administrar', 'ADMINISTRAR', 'AD'),
    ('C', 3, 'Operar', 'OPERAR', 'OP'),
    ('C', 4, 'Desarrollar', 'DESARROLLAR', 'DE'),
    ('C', 5, 'Firmar Documentos', 'FIRMAR', 'FI'),
    ('C', 2, 'Supervisar', 'SUPERVISAR', 'SU'),
    ('C', 6, 'Ver paginas globales', 'VERPAGGLO', 'VP');

--------------------------------------------------------------------------------
