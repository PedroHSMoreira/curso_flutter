package com.example.native_code

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    private static final String CHANNEL = "floating_button";

    MethodChannel channel = new MethodChannel(getFlutterView(), CHANNEL);

    channel.setMethodCallHandler(
            (call, result) -> {
                switch(call.method){
                    case "create":
                        break;
                    case "show":
                        break;
                    case "hide":
                        break;
                }
            }
        );
}
