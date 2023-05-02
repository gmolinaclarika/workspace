#!/bin/sh
#-------------------------------------------------------------------------------
# Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
#
# All  rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
# used under the terms of its associated license document.  You  may  NOT  copy,
# modify,  sublicense,  or  distribute this source file or portions of it unless
# previously authorized in writing by OBCOM INGENIERIA S.A. In any  event,  this
# notice and above copyright must always be included verbatim with this file.
#-------------------------------------------------------------------------------

PGCLIENTENCODING=utf8
PGPASSWORD=obcom_ecubas
PSQL="psql -v ON_ERROR_STOP=1 -h localhost -p 5432 -d obcom -U obcom_ecubas"

$PSQL -q -f EMP_Tables.sql
if [ $? -ne 0 ]; then echo "Error executing script"; exit 1; fi

$PSQL -q -f EMP_Data.sql
if [ $? -ne 0 ]; then echo "Error executing script"; exit 1; fi

for file in EMP\$*.sql; do
    $PSQL -q -f $file
    if [ $? -ne 0 ]; then echo "Error executing script"; exit 1; fi
done

echo "Scripts executed successfully"
