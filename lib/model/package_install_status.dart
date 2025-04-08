enum PackageInstallStatus {
  // TODO: maybe will use with event channel
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

  const PackageInstallStatus(this.code);

  final int code;

  ///Get enum type by status code
  static PackageInstallStatus byCode(int? code) =>
      PackageInstallStatus.values.firstWhere(
        (e) => e.code == code,
        orElse: () => PackageInstallStatus.unknown,
      );
}
