import 'package:android_package_installer/src/install_result.dart';
import 'package:flutter/services.dart';

import 'installer_platform.dart';

class MethodChannelAndroidPackageInstaller extends AndroidPackageInstallerPlatform {
  final methodChannel = const MethodChannel('android_package_installer');

  @override
  Future<AppInstallResult> installApk(String path) async {
    final resMap = await methodChannel.invokeMethod<Map<dynamic, dynamic>>('installApk', path);
    if (resMap == null) {
      throw PlatformException(
        code: 'INSTALL_FAILED',
        message: 'Installation failed',
      );
    } else {
      return AppInstallResult.fromMap(resMap);
    }
  }

  @override
  Future<String?> getPackageNameFromApk(String path) async {
    return await methodChannel.invokeMethod<String?>('getApkPackageName', path);
  }

  @override
  Future<bool> isAppInstalled(String packageName) async {
    return await methodChannel.invokeMethod<bool>('isAppInstalled', packageName) ?? false;
  }
}
