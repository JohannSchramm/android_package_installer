enum PackageInstallerStatus {
  //TODO: maybe will use with event channel
  // pendingUserAction(-1),
  success(0),
  failure(1),
  failureBlocked(2),
  failureAborted(3),
  failureInvalid(4),
  failureConflict(5),
  failureStorage(6),
  failureIncompatible(7),
  unknown(-2);

  const PackageInstallerStatus(this.code);

  final int code;

  ///Get enum type by status code
  static PackageInstallerStatus byCode(int? code) =>
      PackageInstallerStatus.values.firstWhere(
        (e) => e.code == code,
        orElse: () => PackageInstallerStatus.unknown,
      );
}

class AppInstallResult {
  const AppInstallResult({
    required this.packageName,
    required this.status,
  });

  final String? packageName;
  final PackageInstallerStatus status;

  static AppInstallResult fromMap(Map<dynamic, dynamic> map) => 
      AppInstallResult(
        packageName: map['package'] as String?,
        status: PackageInstallerStatus.byCode(map['code'] as int),
      );
}
