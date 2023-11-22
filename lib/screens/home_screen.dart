import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_watch_app/providers/providers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final backgroundImageProvider = Provider.of<BackgroundImageProvider>(context);
    final double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    int randomImage = Random().nextInt(10);
    const textShadows = [
      Shadow(
        color: Colors.black,
        blurRadius: 35.0,
        offset: Offset(2.0, 2.0),
      ),
    ];
    const fewDetailsStyle = TextStyle(color: Colors.white, fontSize: 15.0, shadows: textShadows);

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
      extendBodyBehindAppBar: true,
      body: weatherProvider.isLoading || backgroundImageProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : weatherProvider.error.isNotEmpty
              ? Center(child: Text(weatherProvider.error))
              : backgroundImageProvider.error.isNotEmpty
                  ? Center(child: Text(backgroundImageProvider.error))
                  : CachedNetworkImage(
                      imageUrl:
                          backgroundImageProvider.backgroundImage.photos![randomImage].src.original,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter:
                                ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.srcOver),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                weatherProvider.currentLocation.name!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.0,
                                  color: Colors.white,
                                  shadows: textShadows,
                                ),
                              ),
                              Text(
                                "Wednesday, November 22, 2023",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  shadows: textShadows,
                                ),
                              ),
                              Text(
                                "Updated 11/22/2023 03:05 PM",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.0,
                                  color: Colors.white,
                                  shadows: textShadows,
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
                                  fontWeight: FontWeight.w600,
                                  fontSize: 40.0,
                                  color: Colors.white,
                                  shadows: textShadows,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: weatherProvider.currentWeatherInfo.tempC!
                                          .toInt()
                                          .toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 40.0,
                                        color: Colors.white,
                                        shadows: textShadows,
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
                                            shadows: textShadows,
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
                                      const Icon(Icons.water_drop_rounded,
                                          color: Colors.white, size: 30.0),
                                      const Text("Humidity", style: fewDetailsStyle),
                                      Text(
                                        "${weatherProvider.currentWeatherInfo.humidity}%",
                                        style: fewDetailsStyle,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Icon(Icons.air_rounded,
                                          color: Colors.white, size: 30.0),
                                      const Text("Wind", style: fewDetailsStyle),
                                      Text(
                                        "${weatherProvider.currentWeatherInfo.windKph!.toInt().toString()}km/h",
                                        style: fewDetailsStyle,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Icon(
                                        Icons.thermostat_rounded,
                                        color: Colors.white,
                                        size: 30.0,
                                      ),
                                      const Text("Feels Like", style: fewDetailsStyle),
                                      Text(
                                        "${weatherProvider.currentWeatherInfo.feelslikeC}\u00B0",
                                        style: fewDetailsStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Card(
                                  color: Colors.white.withOpacity(0.5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Wed 16",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                              Image(
                                                image: NetworkImage(
                                                  "https:${weatherProvider.currentWeatherInfo.condition!.icon}",
                                                ),
                                              ),
                                              Text(
                                                "${weatherProvider.currentWeatherInfo.tempC!.toInt().toString()}\u00B0",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                              Text(
                                                "${weatherProvider.currentWeatherInfo.windKph!.toInt().toString()}km/h",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Wed 16",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                              Image(
                                                image: NetworkImage(
                                                  "https:${weatherProvider.currentWeatherInfo.condition!.icon}",
                                                ),
                                              ),
                                              Text(
                                                "${weatherProvider.currentWeatherInfo.tempC!.toInt().toString()}\u00B0",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                              Text(
                                                "${weatherProvider.currentWeatherInfo.windKph!.toInt().toString()}km/h",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Wed 16",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                              Image(
                                                image: NetworkImage(
                                                  "https:${weatherProvider.currentWeatherInfo.condition!.icon}",
                                                ),
                                              ),
                                              Text(
                                                "${weatherProvider.currentWeatherInfo.tempC!.toInt().toString()}\u00B0",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                              Text(
                                                "${weatherProvider.currentWeatherInfo.windKph!.toInt().toString()}km/h",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Wed 16",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                              Image(
                                                image: NetworkImage(
                                                  "https:${weatherProvider.currentWeatherInfo.condition!.icon}",
                                                ),
                                              ),
                                              Text(
                                                "${weatherProvider.currentWeatherInfo.tempC!.toInt().toString()}\u00B0",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                              Text(
                                                "${weatherProvider.currentWeatherInfo.windKph!.toInt().toString()}km/h",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Wed 16",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                              Image(
                                                image: NetworkImage(
                                                  "https:${weatherProvider.currentWeatherInfo.condition!.icon}",
                                                ),
                                              ),
                                              Text(
                                                "${weatherProvider.currentWeatherInfo.tempC!.toInt().toString()}\u00B0",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                              Text(
                                                "${weatherProvider.currentWeatherInfo.windKph!.toInt().toString()}km/h",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Wed 16",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                              Image(
                                                image: NetworkImage(
                                                  "https:${weatherProvider.currentWeatherInfo.condition!.icon}",
                                                ),
                                              ),
                                              Text(
                                                "${weatherProvider.currentWeatherInfo.tempC!.toInt().toString()}\u00B0",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                              Text(
                                                "${weatherProvider.currentWeatherInfo.windKph!.toInt().toString()}km/h",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Wed 16",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                              Image(
                                                image: NetworkImage(
                                                  "https:${weatherProvider.currentWeatherInfo.condition!.icon}",
                                                ),
                                              ),
                                              Text(
                                                "${weatherProvider.currentWeatherInfo.tempC!.toInt().toString()}\u00B0",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                              Text(
                                                "${weatherProvider.currentWeatherInfo.windKph!.toInt().toString()}km/h",
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
    );
  }
}
