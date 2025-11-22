import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:malath/core/theme/app_theme.dart';
import 'package:malath/controllers/main_controller.dart';
import 'package:malath/controllers/home_controller.dart';
import 'package:malath/controllers/chat_controller.dart';
import 'package:malath/controllers/notifications_controller.dart';
import 'package:malath/controllers/profile_controller.dart';
import 'package:malath/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => ChatController()),
        ChangeNotifierProvider(create: (_) => NotificationsController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
      ],
      child: MaterialApp(
        title: 'Nafas',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}