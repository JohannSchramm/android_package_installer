package com.android_package_installer.impl

import android.app.Activity
import android.content.Intent
import android.content.pm.PackageInstaller
import android.os.Bundle
import com.android_package_installer.packageInstalledAction
import io.flutter.plugin.common.PluginRegistry

internal class OnNewIntentListener(private var activity: Activity?) : PluginRegistry.NewIntentListener {
    override fun onNewIntent(intent: Intent): Boolean {
        if (intent.action == packageInstalledAction && intent.extras != null) {
            val extras: Bundle = intent.extras ?: return false
            when (val status = extras.getInt(PackageInstaller.EXTRA_STATUS)) {
                PackageInstaller.STATUS_PENDING_USER_ACTION -> {
                    var confirmIntent = (extras.get(Intent.EXTRA_INTENT) as Intent)
                    confirmIntent =
                        confirmIntent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_NEW_TASK)
                    activity?.startActivity(confirmIntent)
                }

                else -> {
                    val str = extras.getString(PackageInstaller.EXTRA_PACKAGE_NAME)
                    CustomMethodCallHandler.resultSuccessInstall(Pair(status, str))
                }
            }
        }
        return true
    }
}
