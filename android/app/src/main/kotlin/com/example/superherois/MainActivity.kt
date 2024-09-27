package com.example.superherois

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.google.firebase.analytics.FirebaseAnalytics

class MainActivity: FlutterActivity() {
    private lateinit var firebaseAnalytics: FirebaseAnalytics

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        firebaseAnalytics = FirebaseAnalytics.getInstance(this)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example.analytics").setMethodCallHandler { call, result ->
            if (call.method == "sendAnalyticsEvent") {
                val event = call.argument<String?>("event")
                val parameters = call.argument<Map<String, String>?>("parameters")
                sendAnalyticsEvent(event, parameters)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun sendAnalyticsEvent(event: String?, parameters: Map<String, String>?) {
        val bundle = Bundle()
        parameters?.forEach { (key, value) ->
            bundle.putString(key, value)
        }
        firebaseAnalytics.logEvent(event ?: "default_event", bundle)
    }
}