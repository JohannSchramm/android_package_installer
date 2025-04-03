package com.android_package_installer

import com.android_package_installer.impl.AppInfo
import com.android_package_installer.impl.CustomMethodCallHandler
import com.android_package_installer.impl.Installer
import com.android_package_installer.impl.OnNewIntentListener
import com.android_package_installer.impl.Uninstaller
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel

const val packageName = "com.android_package_installer"
const val installStatusUnknown = -2
var packageInstalledAction = "${packageName}.content.SESSION_API_PACKAGE_INSTALLED"

/** PkginstallerPlugin */
class PkginstallerPlugin : FlutterPlugin, ActivityAware {
    private lateinit var installer: Installer
    private lateinit var uninstaller: Uninstaller
    private lateinit var appInfo: AppInfo
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "android_package_installer")
        installer = Installer(flutterPluginBinding.applicationContext, null)
        uninstaller = Uninstaller(flutterPluginBinding.applicationContext, null)
        appInfo = AppInfo(flutterPluginBinding.applicationContext, null)
        val handler = CustomMethodCallHandler(installer, appInfo, uninstaller)
        channel.setMethodCallHandler(handler)
    }

    override fun onDetachedFromEngine(flutterPluginBinding: FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(activityPluginBinding: ActivityPluginBinding) {
        installer.setActivity(activityPluginBinding.activity)
        uninstaller.setActivity(activityPluginBinding.activity)
        appInfo.setActivity(activityPluginBinding.activity)
        activityPluginBinding.addOnNewIntentListener(OnNewIntentListener(activityPluginBinding.activity))
    }

    override fun onDetachedFromActivity() {
        installer.setActivity(null)
        uninstaller.setActivity(null)
        appInfo.setActivity(null)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        channel.setMethodCallHandler(null)
    }

    override fun onReattachedToActivityForConfigChanges(activityPluginBinding: ActivityPluginBinding) {
    }
}
