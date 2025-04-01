import 'package:android_package_installer/src/enums.dart';
import 'package:android_package_installer/src/installer_platform.dart';

export 'package:android_package_installer/src/enums.dart';

class AndroidPackageInstaller {
  /// Installs apk file using Android Package Manager.
  /// Creates Package Installer session, then displays a dialog to confirm the installation.
  /// After installation process is completed, the session is closed.
  /// [apkFilePath] - the path to the apk package file. Example: /sdcard/Download/app.apk
  /// Returns a [PackageInstallerStatus].
  static Future<PackageInstallerStatus> installApk({required String apkFilePath}) async {
    final installer = AndroidPackageInstallerPlatform.instance;
    final code = await installer.installApk(apkFilePath);
    return PackageInstallerStatus.byCode(code);
  }
}
