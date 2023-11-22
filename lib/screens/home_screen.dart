import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_watch_app/providers/providers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu_rounded,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search_rounded,
              size: 30.0,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.blue.shade900,
      body: weatherProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : weatherProvider.error.isNotEmpty
              ? Center(child: Text(weatherProvider.error))
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weatherProvider.currentLocation.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Wednesday, November 22, 2023",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Updated 11/22/2023 03:05 PM",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: deviceHeight * 0.10),
                      Image(
                        image: NetworkImage(
                          "https:${weatherProvider.currentWeatherInfo.condition!.icon}",
                        ),
                      ),
                      Text(
                        weatherProvider.currentWeatherInfo.condition!.text,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                          color: Colors.white,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: weatherProvider.currentWeatherInfo.tempC!.toInt().toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40.0,
                                color: Colors.white,
                              ),
                            ),
                            WidgetSpan(
                              child: Transform.translate(
                                offset: const Offset(0, -12),
                                child: const Text(
                                  '\u2103',
                                  textScaler: TextScaler.linear(0.9),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: deviceHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Icon(Icons.water_drop_rounded, color: Colors.white, size: 30.0),
                              const Text("HUMIDITY", style: TextStyle(color: Colors.white)),
                              Text(
                                "${weatherProvider.currentWeatherInfo.humidity}%",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(Icons.air_rounded, color: Colors.white, size: 30.0),
                              const Text("WIND", style: TextStyle(color: Colors.white)),
                              Text(
                                "${weatherProvider.currentWeatherInfo.windKph!.toInt().toString()}km/h",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(Icons.thermostat_rounded, color: Colors.white, size: 30.0),
                              const Text("FEELS LIKE", style: TextStyle(color: Colors.white)),
                              Text(
                                "${weatherProvider.currentWeatherInfo.feelslikeC}\u00B0",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
    );
  }
}
