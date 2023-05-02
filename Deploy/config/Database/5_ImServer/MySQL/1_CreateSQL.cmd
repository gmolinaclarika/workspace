@rem ---------------------------------------------------------------------------
@rem Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
@rem
@rem All  rights to this product are owned by OBCOM INGENIERIA S.A. and may only
@rem be used under the terms of its associated license  document.  You  may  NOT
@rem copy,  modify, sublicense, or distribute this source file or portions of it
@rem unless previously authorized in writing by OBCOM  INGENIERIA  S.A.  In  any
@rem event, this notice and the above copyright must always be included verbatim
@rem with this file.
@rem ---------------------------------------------------------------------------

@chcp 1252 > nul
@setlocal

@if not defined MYSCON set MYSCON=--defaults-extra-file=1_CreateSQL.cnf
@if not defined MYSGRA set MYSGRA='ecuacc'@'localhost'

@setlocal EnableDelayedExpansion
@for %%s in (IMSERVER$*.sql) do (
    mysql.exe %MYSCON% < %%s
    @if !errorlevel! neq 0 goto errors
    mysql.exe %MYSCON% -e "GRANT EXECUTE ON PROCEDURE  %%~ns TO %MYSGRA%"
    @if !errorlevel! neq 0 goto errors
)

@echo Scripts executed successfully
@endlocal
@pause
@exit /b 0

:errors
@echo Error executing script
@endlocal
@pause
@exit /b 1
