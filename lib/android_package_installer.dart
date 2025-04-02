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
}
