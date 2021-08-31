package com.example.poppy

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import cielo.sdk.info.InfoManager




class MainActivity: FlutterActivity() {
    private val CHANNEL = "poppy_lio_channel"
    private val infomanager = InfoManager()


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
                    if(call.method == "poppy_device_id"){
                        val deviceSettings = infomanager.getSettings(this)

                        if (deviceSettings != null) {
                            print(deviceSettings.merchantCode)
                            print(deviceSettings.logicNumber)
                            result.success(deviceSettings.merchantCode)

                        }




                        result.success("Emulador")
                    } else {
                        result.notImplemented()
                    }

        }
    }
}
