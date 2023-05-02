#-------------------------------------------------------------------------------
# Copyright (c) OBCOM INGENIERIA S.A. (Chile). All rights reserved.
#
# All  rights to this product are owned by OBCOM INGENIERIA S.A. and may only be
# used under the terms of its associated license document.  You  may  NOT  copy,
# modify,  sublicense,  or  distribute this source file or portions of it unless
# previously authorized in writing by OBCOM INGENIERIA S.A. In any  event,  this
# notice and above copyright must always be included verbatim with this file.
#-------------------------------------------------------------------------------

# Include Java Standard libraries
-libraryjars <java.home>/jmods/java.base.jmod(!**.jar;!module-info.class)
-libraryjars <java.home>/jmods/java.logging.jmod(!**.jar;!module-info.class)
-libraryjars <java.home>/jmods/java.xml.jmod(!**.jar;!module-info.class)

# Include JAXWS libraries
-libraryjars <deploy.xlibs>/jaxws/jakarta.jws-api-2.1.0.jar(!module-info.class)
-libraryjars <deploy.xlibs>/jaxws/jakarta.xml.bind-api-2.3.3.jar(!module-info.class)
-libraryjars <deploy.xlibs>/jaxws/jakarta.xml.ws-api-2.3.3.jar(!module-info.class)

# Include JavaFX libraries
-libraryjars <deploy.xlibs>/javafx/javafx-base-11-win.jar(!module-info.class)
-libraryjars <deploy.xlibs>/javafx/javafx-controls-11-win.jar(!module-info.class)
-libraryjars <deploy.xlibs>/javafx/javafx-fxml-11-win.jar(!module-info.class)
-libraryjars <deploy.xlibs>/javafx/javafx-graphics-11-win.jar(!module-info.class)
-libraryjars <deploy.xlibs>/javafx/javafx-media-11-win.jar(!module-info.class)
-libraryjars <deploy.xlibs>/javafx/javafx-web-11-win.jar(!module-info.class)

# Optimization options
-optimizationpasses 3

# Options so we can de-obfuscate stack traces
-renamesourcefileattribute SourceFile
-keepattributes Exceptions,InnerClasses,Signature,Deprecated,
                SourceFile,LineNumberTable,EnclosingMethod

# Preserve annotations and modules
-keepattributes *Annotation*,Module*

# Preserve all package-info classes
-keep class **.package-info

# Preserve internationalization classes
-keep public class **.i18n.*

# Preserve FXML fields
-keepclassmembers class * {
    @javafx.fxml.FXML *;
}

# Preserve all public classes
-keep public class * {
    public protected *;
}

# Preserve static methods required in enumeration
-keepclassmembers,allowoptimization enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Explicitly preserve serialization members
-keepnames public class * implements java.io.Serializable
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}
