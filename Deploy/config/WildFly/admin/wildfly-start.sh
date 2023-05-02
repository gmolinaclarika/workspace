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

JBOSS_HOME=/opt/wildfly-27.0.1.Final
SERVER_HOME=/home/wildfly/standalone

# -b=0.0.0.0 => WildFly escucha por todas las interfaces
# -bmanagement=0.0.0.0 => consola WildFly en todas las interfaces
# -Djboss.socket.binding.port-offset=100 cambia todos los puertos WildFly

if [ $EUID -eq 0 ]; then
    su -l wildfly -c \
    "$JBOSS_HOME/bin/standalone.sh -Djboss.home.dir=$JBOSS_HOME \
    -b=0.0.0.0 -bmanagement=0.0.0.0 $* > $SERVER_HOME/log/start.out 2>&1 &"
else
    $JBOSS_HOME/bin/standalone.sh -Djboss.home.dir=$JBOSS_HOME  \
    -b=0.0.0.0 -bmanagement=0.0.0.0 $* > $SERVER_HOME/log/start.out 2>&1 &
fi

#-------------------------------------------------------------------------------
