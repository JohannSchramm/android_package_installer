package com.android_package_installer.impl

import com.android_package_installer.installStatusUnknown
import com.android_package_installer.packageName
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

internal class CustomMethodCallHandler(private val installer: Installer, private val appinfo: AppInfo, private val uninstaller: Uninstaller) : MethodChannel.MethodCallHandler {
    companion object {
        lateinit var installcallResult: MethodChannel.Result

        fun resultSuccessInstall(data: Pair<Int, String?>) {
            installcallResult.success(mapOf("code" to data.first, "package" to data.second))
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "installApk" -> {
                installcallResult = result
                try {
                    val apkFilePath = call.arguments.toString()
                    installer.installPackage(apkFilePath)
                } catch (e: Exception) {
                    resultSuccessInstall(Pair(installStatusUnknown, null))
                }
            }
            "isAppInstalled" -> {
                val packageName = call.arguments.toString()
                val res = appinfo.isAppInstalled(packageName)
                result.success(res)
            }
            "getApkPackageName" -> {
                val apkFilePath = call.arguments.toString()
                val name = appinfo.getPackageNameFromApk(apkFilePath)
                result.success(name)
            }
            "uninstallApp" -> {
                val packageName = call.arguments.toString()
                uninstaller.uninstallPackage(packageName, result)
            }
            "launchApp" -> {
                val packageName = call.arguments.toString()
                val launched = appinfo.launchApp(packageName)
                result.success(launched)
            }
            else -> {
                result.notImplemented()
            }
        }
    }
}
