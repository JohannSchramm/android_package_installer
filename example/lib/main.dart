import 'package:android_package_installer/android_package_installer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _installationStatus = '';
  String _installationName = '';
  bool? _appInstalled;
  final TextEditingController _filePathFieldController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example'),
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          child: TextField(
                              controller: _filePathFieldController,
                              decoration: const InputDecoration(labelText: "APK file path", hintText: "Enter path"))),
                      _button('Select file', () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['apk']);
                        if (result != null) {
                          setState(() {
                            _filePathFieldController.text = result.files.single.path!;
                            _installationStatus = '';
                          });
                        }
                      }),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('PackageManager installation status: $_installationStatus'),
                  const SizedBox(height: 10),
                  Text('PackageManager installation name: $_installationName'),
                  const SizedBox(height: 30),
                  _button('Install apk file', () async {
                    if (_filePathFieldController.text.isNotEmpty) {
                      setState(() {
                        _installationStatus = '';
                        _installationName = '';
                      });
                      try {
                        final result = await AndroidPackageInstaller.installApk(apkFilePath: _filePathFieldController.text);
                          setState(() {
                            _installationStatus = result.status.name;
                            _installationName = result.packageName ?? '';
                          });
                      } on PlatformException {
                        print('Error at Platform. Failed to install apk file.');
                      }
                    }
                  }),
                  const SizedBox(height: 10),
                  _button("Get APK Package Name", () async {
                    if (_filePathFieldController.text.isNotEmpty) {
                      setState(() {
                        _installationName = '';
                      });
                      try {
                        final name = await AndroidPackageInstaller.getPackageNameFromApk(_filePathFieldController.text);
                          setState(() {
                            _installationName = name ?? '';
                          });
                      } on PlatformException {
                        print('Error at Platform. Failed to get apk file name.');
                      }
                    }
                  }),
                  const SizedBox(height: 10),
                  _button("Check App installed", () async {
                    if (_filePathFieldController.text.isNotEmpty) {
                      setState(() {
                        _appInstalled = null;
                      });
                      try {
                        final installed = await AndroidPackageInstaller.isApkInstalled(_filePathFieldController.text);
                        setState(() => _appInstalled = installed);
                      } on PlatformException {
                        print('Error at Platform. Failed to get apk file name.');
                      }
                    }
                  }),
                  const SizedBox(height: 10),
                  Text('Is app already installed: $_appInstalled'),
                  const SizedBox(height: 10),
                  _button("Uninstall app", () async {
                    if (_filePathFieldController.text.isNotEmpty) {
                      try {
                        final packageName = await AndroidPackageInstaller.getPackageNameFromApk(_filePathFieldController.text);
                        if (packageName != null) {
                          print("uninstalling app");
                          await AndroidPackageInstaller.uninstallApp(packageName);
                          print("uninstalled app");
                        }
                      } catch(e) {
                        print('Error while uninstalling');
                      }
                    }
                  }),
                  const SizedBox(height: 10),
                  _button("Launch app", () async {
                    if (_filePathFieldController.text.isNotEmpty) {
                      try {
                        final packageName = await AndroidPackageInstaller.getPackageNameFromApk(_filePathFieldController.text);
                        if (packageName != null) {
                          await AndroidPackageInstaller.launchApp(packageName);
                        }
                      } catch(e) {
                        print('Error while launching');
                      }
                    }
                  }),
                  const Spacer(),
                  SizedBox(
                    child: Column(children: [
                      const Text('Permissions:'),
                      _button('External Storage', () => _requestPermission(Permission.storage)),
                      _button('Request Install Packages', () => _requestPermission(Permission.requestInstallPackages)),
                      _button(
                          'Manage External Storage\n(for Android 11+ target)', () => _requestPermission(Permission.manageExternalStorage)),
                    ]),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  ElevatedButton _button(String text, VoidCallback? onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

  void _requestPermission(Permission permission) async {
    var status = await permission.status;
    if (status.isDenied) {
      await permission.request();
    }
  }
}
