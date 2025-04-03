package com.android_package_installer.impl

import com.android_package_installer.installStatusUnknown
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

internal class CustomMethodCallHandler(private val installer: Installer) : MethodChannel.MethodCallHandler {
    companion object {
        lateinit var callResult: MethodChannel.Result
        fun resultSuccess(data: Pair<Int, String?>) {
            callResult.success(mapOf("code" to data.first, "package" to data.second))
        }

        fun nothing() {
            callResult.notImplemented()
        }

        /*
        fun resultError(s0: String, s1: String, o: Any) {
            callResult.error(s0, s1, o)
        }
        */
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        callResult = result
        when (call.method) {
            "installApk" -> {
                try {
                    val apkFilePath = call.arguments.toString()
                    installer.installPackage(apkFilePath)
                } catch (e: Exception) {
                    resultSuccess(Pair(installStatusUnknown, null))
                }
            }
            else -> {
                nothing()
            }
        }
    }
}
