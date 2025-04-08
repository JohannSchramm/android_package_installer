import 'package:android_package_installer/model/package_install_status.dart';

class PackageInstallResult {
  const PackageInstallResult({
    required this.packageName,
    required this.status,
  });

  final String? packageName;
  final PackageInstallStatus status;

  static PackageInstallResult fromMap(Map<dynamic, dynamic> map) => 
      PackageInstallResult(
        packageName: map['package'] as String?,
        status: PackageInstallStatus.byCode(map['code'] as int),
      );
}
