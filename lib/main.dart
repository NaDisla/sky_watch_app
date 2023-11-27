import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_watch_app/providers/providers.dart';
import 'package:sky_watch_app/screens/screens.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BackgroundImageProvider(),
        ),
      ],
      child: const SkyWatchApp(),
    ),
  );
}

class SkyWatchApp extends StatelessWidget {
  const SkyWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins', primaryColor: Colors.blueGrey),
      home: const HomeScreen(),
    );
  }
}
