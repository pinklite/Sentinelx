package com.invertedx.sentinelx.channel

import android.content.Context
import com.invertedx.sentinelx.utils.SentinalPrefs
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class SystemChannel(private val applicationContext: Context) : MethodChannel.MethodCallHandler {


    override fun onMethodCall(methodCall: MethodCall?, result: MethodChannel.Result?) {
        if (methodCall == null || result == null) {
            return
        }
        when (methodCall.method) {
            "documentPath" -> {
                val dir = applicationContext.getDir("sentinelx", Context.MODE_PRIVATE);
                if (!dir.exists()) {
                    dir.mkdir()
                }
                return result.success(dir.path)
            }
            "setNetwork" -> {
                val isTestNet = methodCall.argument<Boolean>("mode")
                val pref = SentinalPrefs(applicationContext)
                if (isTestNet != null)
                    pref.isTestNet = isTestNet
                result.success("Success")
            }

        }
    }

}