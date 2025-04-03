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

internal class AppInfo(private val context: Context, private var activity: Activity?) {
    fun setActivity(activity: Activity?) {
        this.activity = activity
    }

    fun isAppInstalled(packageName: String): Boolean {
        val manager = activity?.packageManager ?: return false
        return try {
            manager.getPackageInfo(packageName, 0)
            true
        } catch (e: PackageManager.NameNotFoundException) {
            false
        }
    }

    fun getPackageNameFromApk(apkPath: String): String? {
        return activity
            ?.packageManager
            ?.getPackageArchiveInfo(apkPath, 0)
            ?.packageName
    }
}

