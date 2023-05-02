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

@if not defined ORACON set ORACON=ECUBAS/ECUBAS@//localhost:1521/ORCL
@if not defined NLS_LANG set NLS_LANG=.AL32UTF8

@setlocal EnableDelayedExpansion
@for %%s in (MCASTNEWS$*.sql) do (
    sqlplus.exe -L -S "%ORACON%" @%%s
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
