package com.android_package_installer.impl

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri

internal class Uninstaller(private val context: Context, private var activity: Activity?) {
    fun setActivity(activity: Activity?) {
        this.activity = activity
    }

    fun uninstallPackage(packageName: String) {
        val act = activity
        if (act != null) {
            try {
                val packageUri = Uri.parse("package:$packageName")
                val intent = Intent(Intent.ACTION_DELETE, packageUri)
                intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                act.startActivity(intent)
            } catch (e: Exception) {
                throw e
            }
        }
    }
}
