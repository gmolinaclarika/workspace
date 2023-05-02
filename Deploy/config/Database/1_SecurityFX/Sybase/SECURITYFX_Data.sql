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

INSERT INTO EcuACCFAM (
    V_FAM_FAMILIA,
    V_FAM_NOMBRE_USUARIO,
    V_FAM_UBICACION
) VALUES (
    'GENERAL',
    'Todos los usuarios del sistema',
    'Todos los terminales del sistema'
)
GO

--------------------------------------------------------------------------------
-- EcuACCPER -------------------------------------------------------------------
--------------------------------------------------------------------------------

INSERT INTO EcuACCPER (
    V_ACC_CODE_NUM,
    V_ACC_PRIV_MEN,
    V_ACC_PRIV_VARL,
    V_ACC_PRIV_VARM,
    V_ACC_PRIV_REGL,
    V_ACC_PRIV_REGM,
    V_ACC_NAME,
    V_ACC_EXP,
    V_ACC_INDICADORES,
    V_ACC_HORA_FIN,
    V_ACC_PROG_INI,
    V_ACC_FAMILIA,
    V_ACC_VIG_PASSW,
    V_ACC_PASSWORD
) VALUES (
    0000000,
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
    71757147231059
)
GO

--------------------------------------------------------------------------------
-- EcuACCUSU -------------------------------------------------------------------
--------------------------------------------------------------------------------

INSERT INTO EcuACCUSU (
    USU_CODIGO,
    NOMBRES,
    USU_ESTADO,
    PSW_TIPO,
    PASSWORD,
    PSW_VIG_DESD,
    PSW_ESTADO,
    FAMILIA,
    FEC_VIG_DESD,
    FEC_VIG_HAST,
    FEC_CRE_USU,
    FEC_PRI_LOG,
    FEC_ULT_LOG,
    FEC_ERR_LOG,
    FACTURACION,
    USUARIOIM
) VALUES (
    'ADMIN',
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
    'S'
)
GO

--------------------------------------------------------------------------------
-- EcuACCU2P -------------------------------------------------------------------
--------------------------------------------------------------------------------

INSERT INTO EcuACCU2P (
    CODIGO_ADI, CODIGO_ECU
) VALUES (
    'ADMIN', 0000000
)
GO

--------------------------------------------------------------------------------
-- EcuACCPRV -------------------------------------------------------------------
--------------------------------------------------------------------------------

INSERT INTO EcuACCPRV (
    V_PRV_TIPO, V_PRV_NUMERO, V_PRV_NOMBRE, V_PRV_CONST, V_PRV_SYSLOG
) VALUES (
    'C', 1, 'Administrar', 'ADMINISTRAR', 'AD'
)
GO

INSERT INTO EcuACCPRV (
    V_PRV_TIPO, V_PRV_NUMERO, V_PRV_NOMBRE, V_PRV_CONST, V_PRV_SYSLOG
) VALUES (
    'C', 2, 'Supervisar', 'SUPERVISAR', 'SU'
)
GO

INSERT INTO EcuACCPRV (
    V_PRV_TIPO, V_PRV_NUMERO, V_PRV_NOMBRE, V_PRV_CONST, V_PRV_SYSLOG
) VALUES (
    'C', 3, 'Operar', 'OPERAR', 'OP'
)
GO

INSERT INTO EcuACCPRV (
    V_PRV_TIPO, V_PRV_NUMERO, V_PRV_NOMBRE, V_PRV_CONST, V_PRV_SYSLOG
) VALUES (
    'C', 4, 'Desarrollar', 'DESARROLLAR', 'DE'
)
GO

INSERT INTO EcuACCPRV (
    V_PRV_TIPO, V_PRV_NUMERO, V_PRV_NOMBRE, V_PRV_CONST, V_PRV_SYSLOG
) VALUES (
    'C', 5, 'Firmar Documentos', 'FIRMAR', 'FI'
)
GO

INSERT INTO EcuACCPRV (
    V_PRV_TIPO, V_PRV_NUMERO, V_PRV_NOMBRE, V_PRV_CONST, V_PRV_SYSLOG
) VALUES (
    'C', 6, 'Ver paginas globales', 'VERPAGGLO', 'VP'
)
GO

--------------------------------------------------------------------------------
