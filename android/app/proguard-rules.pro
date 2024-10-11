# Keep TensorFlow Lite GPU delegate classes
-keep class org.tensorflow.lite.gpu.** { *; }

# Keep TensorFlow Lite Interpreter class
-keep class org.tensorflow.lite.Interpreter { *; }

# Keep TensorFlow Lite Delegate classes
-keep class org.tensorflow.lite.gpu.GpuDelegate { *; }
-keep class org.tensorflow.lite.gpu.GpuDelegateV2 { *; }

# Keep TensorFlow Lite Delegate Options classes
-keep class org.tensorflow.lite.gpu.GpuDelegateOptions { *; }
-keep class org.tensorflow.lite.gpu.GpuDelegateOptionsV2 { *; }

# Ensure these classes are not minified
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}
-dontwarn org.tensorflow.lite.gpu.GpuDelegateFactory$Options