import 'package:android_package_installer/src/install_result.dart';
import 'package:android_package_installer/src/method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class AndroidPackageInstallerPlatform extends PlatformInterface {
  AndroidPackageInstallerPlatform() : super(token: _token);

  static final Object _token = Object();

  static AndroidPackageInstallerPlatform _instance =
      MethodChannelAndroidPackageInstaller();

  static AndroidPackageInstallerPlatform get instance => _instance;

  static set instance(AndroidPackageInstallerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<AppInstallResult> installApk(String path);

  Future<void> uninstallApk(String packageName);

  Future<String?> getPackageNameFromApk(String path);

  Future<bool> isAppInstalled(String packageName);
}
