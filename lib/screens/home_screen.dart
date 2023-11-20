import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_watch_app/providers/providers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String locationName = context.watch<WeatherProvider>().weatherInfo.location!.name;
    return Scaffold(
      body: Center(
        child: Text(locationName),
      ),
    );
  }
}
