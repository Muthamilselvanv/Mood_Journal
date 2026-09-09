import java.util.Properties

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()

if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.inputStream().use(keystoreProperties::load)
}

val requiredSigningProperties = listOf(
    "keyAlias",
    "keyPassword",
    "storeFile",
    "storePassword",
)
val signingPropertiesComplete = keystorePropertiesFile.exists() &&
    requiredSigningProperties.all { !keystoreProperties.getProperty(it).isNullOrBlank() }
val releaseStoreFile = if (signingPropertiesComplete) {
    rootProject.file(keystoreProperties.getProperty("storeFile"))
} else {
    null
}
val releaseSigningConfigured = releaseStoreFile?.isFile == true

android {
    namespace = "com.muthamilselvan.nilora"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.muthamilselvan.nilora"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (releaseSigningConfigured) {
            create("release") {
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
                storeFile = releaseStoreFile
                storePassword = keystoreProperties.getProperty("storePassword")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.findByName("release")
        }
    }
}

gradle.taskGraph.whenReady {
    val includesReleaseTask = allTasks.any {
        it.name.contains("release", ignoreCase = true)
    }

    if (includesReleaseTask && !releaseSigningConfigured) {
        throw GradleException(
            "Release signing is incomplete. Copy android/key.properties.example " +
                "to android/key.properties, provide every private upload-key value, " +
                "and place the keystore at the configured storeFile path.",
        )
    }
}

flutter {
    source = "../.."
}
