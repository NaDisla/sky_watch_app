import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_watch_app/providers/providers.dart';
import 'package:sky_watch_app/screens/screens.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: const SkyWatchApp(),
    ),
  );
}

class SkyWatchApp extends StatelessWidget {
  const SkyWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
