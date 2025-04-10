import 'package:android_package_installer/model/package_app_info.dart';
import 'package:android_package_installer/model/package_install_result.dart';
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

  Future<PackageInstallResult> installApk(String path);

  Future<void> uninstallApk(String packageName);

  Future<String?> getPackageNameFromApk(String path);

  Future<PackageAppInfo?> getAppInfo(String packageName);

  Future<bool> launchApp(String packageName);
}
