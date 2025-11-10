import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'models/drawing.dart';
import 'models/settings.dart';
import 'models/unlocked_content.dart';
import 'services/database_service.dart';
import 'services/ads_service.dart';
import 'services/audio_service.dart';
import 'services/settings_service.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive Adapters
  Hive.registerAdapter(DrawingAdapter());
  Hive.registerAdapter(DrawingPointAdapter());
  Hive.registerAdapter(BrushTypeAdapter());
  Hive.registerAdapter(AppSettingsAdapter());
  Hive.registerAdapter(UnlockedContentAdapter());

  // Initialize Mobile Ads
  await MobileAds.instance.initialize();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const ArtJoyApp());
}

class ArtJoyApp extends StatelessWidget {
  const ArtJoyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatabaseService()),
        ChangeNotifierProvider(create: (_) => SettingsService()),
        ChangeNotifierProvider(create: (_) => AdsService()),
        Provider(create: (_) => AudioService()),
      ],
      child: Consumer<SettingsService>(
        builder: (context, settingsService, _) {
          return MaterialApp(
            title: 'ArtJoy - Free Drawing & Coloring',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
