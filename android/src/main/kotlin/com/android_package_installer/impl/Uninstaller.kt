package com.android_package_installer.impl

import android.app.Activity
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.Uri
import io.flutter.plugin.common.MethodChannel


internal class Uninstaller(private val context: Context, private var activity: Activity?) {
    fun setActivity(activity: Activity?) {
        this.activity = activity
    }

    fun uninstallPackage(packageName: String, result: MethodChannel.Result) {
        val act = activity

        if (act != null) {
            try {
                val packageUri = Uri.parse("package:$packageName")
                val intent = Intent(Intent.ACTION_DELETE, packageUri)
                intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK

                registerPackageChangeReceiver(act, packageName, result)

                act.startActivity(intent)

                println(act.localClassName)
            } catch (e: Exception) {
                result.success(false)
                throw e
            }
        }
    }

    // TODO this currently does not detect if the user cancels the uninstall
    private fun registerPackageChangeReceiver(activity: Activity, packageName: String, result: MethodChannel.Result) {
        lateinit var packageChangeReceiver: BroadcastReceiver;
        packageChangeReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                if (Intent.ACTION_PACKAGE_REMOVED == intent.action) {
                    val data = intent.data
                    if (data != null && data.schemeSpecificPart == packageName) {
                        result.success(true)
                        activity.unregisterReceiver(packageChangeReceiver)
                    }
                }
            }
        }

        val filter = IntentFilter(Intent.ACTION_PACKAGE_REMOVED)
        filter.addDataScheme("package")
        activity.registerReceiver(packageChangeReceiver, filter)
    }
}
