package ru.mironov.places

import androidx.annotation.NonNull
import com.yandex.mapkit.MapKitFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("3f1791bb-545f-4fea-80fd-1a389b4801c1")
        super.configureFlutterEngine(flutterEngine)
    }
}
