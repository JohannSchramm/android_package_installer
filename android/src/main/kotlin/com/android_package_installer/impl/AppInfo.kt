package com.android_package_installer.impl

import android.app.Activity
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageInstaller
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import com.android_package_installer.packageInstalledAction
import java.io.FileInputStream
import java.io.IOException

data class AppInfoData(val packageName: String, val versionName: String?, val installTime: Long)

internal class AppInfo(private val context: Context, private var activity: Activity?) {
    fun setActivity(activity: Activity?) {
        this.activity = activity
    }

    fun getAppInfo(packageName: String): AppInfoData? {
        val manager = activity?.packageManager ?: return null
        return try {
            val appInfo = manager.getPackageInfo(packageName, 0)
            return AppInfoData(
                appInfo.packageName,
                appInfo.versionName,
                appInfo.firstInstallTime,
            )
        } catch (e: PackageManager.NameNotFoundException) {
            null
        }
    }

    fun getPackageNameFromApk(apkPath: String): String? {
        return activity
            ?.packageManager
            ?.getPackageArchiveInfo(apkPath, 0)
            ?.packageName
    }

    fun launchApp(packageName: String): Boolean {
        val act = activity
        if (act != null) {
            try {
                val manager = act.packageManager
                val intent = manager.getLaunchIntentForPackage(packageName)
                if (intent != null) {
                    act.startActivity(intent)
                    return true
                }
            } catch (e: Exception) {
                return false
            }
        }
        return false
    }
}

