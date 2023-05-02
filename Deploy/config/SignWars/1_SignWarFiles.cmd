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

@set JAVA_HOME=C:\Java\jdk1.8.0_361
@for %%w in (imperial-*-web.war) do @call :signjars %%w
@goto :eof

@rem ---------------------------------------------------------------------------

:signjars
    @if exist expanded rmdir /s /q expanded
    @mkdir expanded & cd expanded

    @"%JAVA_HOME%\bin\jar.exe" -xf ..\%1
    @if %errorlevel% neq 0 goto errors

    @if not exist jnlp goto clear
    @echo Rebuilding %1

    @cd jnlp
    @set signcount=0
    @for %%j in (*.jar) do @call :signjar %%j
    @cd ..

    @if "%signcount%"=="0" goto clear
    @"%JAVA_HOME%\bin\jar.exe" -cMf ..\%1 .
    @if %errorlevel% neq 0 goto errors

:clear
    @cd .. & rmdir /s /q expanded
@goto :eof

@rem ---------------------------------------------------------------------------

:signjar
    @set filename=%1
    @if "%filename:~0,6%"=="obcom-" goto :eof

    @echo   Signing %1
    @"%JAVA_HOME%\bin\jarsigner.exe" ^
    -strict -storetype JKS -digestalg SHA-256 ^
    -keystore ..\..\..\certs\imperial.jks ^
    -storepass changeit -keypass changeit ^
    -tsa http://timestamp.digicert.com?alg=sha256 ^
    -sigfile IMPERIAL %1 IMPERIAL > nul
    @if %errorlevel% neq 0 goto errors

    @set /a signcount+=1
@goto :eof

@rem ---------------------------------------------------------------------------

:errors
@pause
@endlocal
