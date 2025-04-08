import 'package:android_package_installer/model/package_app_info.dart';
import 'package:android_package_installer/model/package_install_result.dart';
import 'package:android_package_installer/src/installer_platform.dart';

export 'model/models.dart';

class AndroidPackageInstaller {
  /// Installs apk file using Android Package Manager.
  /// Creates Package Installer session, then displays a dialog to confirm the installation.
  /// After installation process is completed, the session is closed.
  /// [apkFilePath] - the path to the apk package file. Example: /sdcard/Download/app.apk
  /// Returns a [PackageInstallResult].
  static Future<PackageInstallResult> installApk({required String apkFilePath}) async {
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

  /// Fetches some [PackageAppInfo] about the app.
  /// [packageName] - the package name of the app. Example: com.example.app
  /// Returns the [PackageAppInfo] if the app is installed, null otherwise.
  static Future<PackageAppInfo?> getAppInfo(String packageName) async {
    final installer = AndroidPackageInstallerPlatform.instance;
    return await installer.getAppInfo(packageName);
  }

  /// Checks if the app is installed on the device.
  /// [packageName] - the package name of the app. Example: com.example.app
  /// Returns true if the app is installed, false otherwise.
  static Future<bool> isAppInstalled(String packageName) async {
    final info = await getAppInfo(packageName);
    return info != null;
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
