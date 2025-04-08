class PackageAppInfo {
  const PackageAppInfo({
    required this.packageName,
    required this.versionName,
    required this.installTime,
  });

  final String packageName;
  final String? versionName;
  final int installTime;

  static PackageAppInfo fromMap(Map<dynamic, dynamic> map) => 
      PackageAppInfo(
        packageName: map['packageName'] as String,
        versionName: map['versionName'] as String?,
        installTime: map['installTime'] as int,
      );
}
