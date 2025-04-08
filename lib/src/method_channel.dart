import 'package:android_package_installer/model/package_app_info.dart';
import 'package:android_package_installer/model/package_install_result.dart';
import 'package:flutter/services.dart';

import 'installer_platform.dart';

class MethodChannelAndroidPackageInstaller extends AndroidPackageInstallerPlatform {
  final methodChannel = const MethodChannel('android_package_installer');

  @override
  Future<PackageInstallResult> installApk(String path) async {
    final resMap = await methodChannel.invokeMethod<Map<dynamic, dynamic>>('installApk', path);
    if (resMap == null) {
      throw PlatformException(
        code: 'INSTALL_FAILED',
        message: 'Installation failed',
      );
    } else {
      return PackageInstallResult.fromMap(resMap);
    }
  }

  @override
  Future<void> uninstallApk(String packageName) async {
    await methodChannel.invokeMethod<bool>('uninstallApp', packageName);
  }

  @override
  Future<String?> getPackageNameFromApk(String path) async {
    return await methodChannel.invokeMethod<String?>('getApkPackageName', path);
  }

  @override
  Future<PackageAppInfo?> getAppInfo(String packageName) async {
    final resMap =  await methodChannel.invokeMethod<Map<dynamic, dynamic>>('getAppInfo', packageName);
    if (resMap != null) {
      return PackageAppInfo.fromMap(resMap);
    } else {
      return null;
    }
  }

  @override
  Future<bool> launchApp(String packageName) async {
    return await methodChannel.invokeMethod<bool>('launchApp', packageName) ?? false;
  }
}
