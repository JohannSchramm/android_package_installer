package com.android_package_installer.impl

import com.android_package_installer.installStatusUnknown
import com.android_package_installer.packageName
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

internal class CustomMethodCallHandler(private val installer: Installer, private val appinfo: AppInfo) : MethodChannel.MethodCallHandler {
    companion object {
        lateinit var callResult: MethodChannel.Result
        fun resultSuccess(data: Pair<Int, String?>) {
            callResult.success(mapOf("code" to data.first, "package" to data.second))
        }

        fun nothing() {
            callResult.notImplemented()
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "installApk" -> {
                callResult = result
                try {
                    val apkFilePath = call.arguments.toString()
                    installer.installPackage(apkFilePath)
                } catch (e: Exception) {
                    resultSuccess(Pair(installStatusUnknown, null))
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
            else -> {
                nothing()
            }
        }
    }
}
