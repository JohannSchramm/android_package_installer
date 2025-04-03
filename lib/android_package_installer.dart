import 'package:android_package_installer/src/install_result.dart';
import 'package:android_package_installer/src/installer_platform.dart';

export 'src/install_result.dart';

class AndroidPackageInstaller {
  /// Installs apk file using Android Package Manager.
  /// Creates Package Installer session, then displays a dialog to confirm the installation.
  /// After installation process is completed, the session is closed.
  /// [apkFilePath] - the path to the apk package file. Example: /sdcard/Download/app.apk
  /// Returns a [AppInstallResult].
  static Future<AppInstallResult> installApk({required String apkFilePath}) async {
    final installer = AndroidPackageInstallerPlatform.instance;
    return await installer.installApk(apkFilePath);
  }

  /// Uninstalls an app
  /// [packageName] - the package name of the app. Example: com.example.app
  static Future<void> uninstallApp(String packageName) async {
    final installer = AndroidPackageInstallerPlatform.instance;
    await installer.uninstallApk(packageName);
  }

  /// Returns the package name of the apk file.
  /// [apkFilePath] - the path to the apk package file. Example: /sdcard/Download/app.apk
  /// Returns the package name of the apk file.
  static Future<String?> getPackageNameFromApk(String apkFilePath) async {
    final installer = AndroidPackageInstallerPlatform.instance;
    return await installer.getPackageNameFromApk(apkFilePath);
  }

  /// Checks if the app is installed on the device.
  /// [packageName] - the package name of the app. Example: com.example.app
  /// Returns true if the app is installed, false otherwise.
  static Future<bool> isAppInstalled(String packageName) async {
    final installer = AndroidPackageInstallerPlatform.instance;
    return await installer.isAppInstalled(packageName);
  }

  /// Checks if the apk file is installed on the device.
  /// [apkFilePath] - the path to the apk package file. Example: /sdcard/Download/app.apk
  /// Returns true if the apk file is installed, false otherwise.
  static Future<bool> isApkInstalled(String apkFilePath) async {
    final name = await getPackageNameFromApk(apkFilePath);
    if (name == null) {
      return false;
    } else {
      return await isAppInstalled(name);
    }
  }

  /// Launches an installed app.
  /// [packageName] - the package name of the app. Example: com.example.app
  /// Returns true if the app was launched successfully, false otherwise.
  static Future<bool> launchApp(String packageName) async {
    final installer = AndroidPackageInstallerPlatform.instance;
    return await installer.launchApp(packageName);
  }
}
