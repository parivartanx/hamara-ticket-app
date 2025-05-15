# Flutter specific ProGuard rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase Auth
-keep class com.google.firebase.** { *; }

# Keep your model classes if using json_serializable
-keep class com.parivartanx.hamaraticket.models.** { *; }

# Common Android libraries
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception

# Keep Play-Core SplitCompat & SplitInstall APIs
-keep class com.google.android.play.core.splitcompat.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep interface com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }

# Keep all Play Core and Play Core Common classes
-keep class com.google.android.play.** { *; }
-keep class com.google.android.play.core.** { *; }
