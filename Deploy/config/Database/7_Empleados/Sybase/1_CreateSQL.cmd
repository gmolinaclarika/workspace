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

@if not defined SQLCON set SQLCON=-SOSTERTAG4700 -DECUBAS -UEcuAdmin -PEcuAdmin --retserverror
@if not defined SQLGRA set SQLGRA=EcuWebUser

@rem isql.exe %SQLCON% -i EMP_Tables.sql
@rem @if %errorlevel% neq 0 goto errors

@rem isql.exe %SQLCON% -i EMP_Data.sql
@rem @if %errorlevel% neq 0 goto errors

@setlocal EnableDelayedExpansion
@for %%s in (EMP$*.sql) do (
    isql.exe %SQLCON% -i %%s
    @if !errorlevel! neq 0 goto errors
    isql.exe %SQLCON% -b -Q "GRANT EXECUTE ON %%~ns TO %SQLGRA%"
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
