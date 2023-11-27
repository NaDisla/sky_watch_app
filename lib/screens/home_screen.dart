import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_watch_app/providers/providers.dart';
import 'package:sky_watch_app/screens/screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int randomImage = Random().nextInt(10);
  bool isHourlyForecast = true;
  Map<int, String> days = {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday"
  };
  TextEditingController cityController = TextEditingController();
  final GlobalKey<FormState> cityKey = GlobalKey<FormState>();

  String setDayTime(String date) {
    int hour = int.parse(date.split(" ")[1].split(":")[0]);
    return hour <= 11 ? "$hour AM" : "$hour PM";
  }

  String setWeekDay(DateTime date) {
    return "${days[date.weekday]} ${date.day}";
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final backgroundImageProvider = Provider.of<BackgroundImageProvider>(context);
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    const textShadows = [
      Shadow(
        color: Colors.black,
        blurRadius: 35.0,
        offset: Offset(2.0, 2.0),
      ),
    ];
    const fewDetailsStyle = TextStyle(color: Colors.white, fontSize: 15.0, shadows: textShadows);

    return Scaffold(
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
                          child: SingleChildScrollView(
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
                                  weatherProvider.currentLocation.currentStrDate!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    shadows: textShadows,
                                  ),
                                ),
                                Text(
                                  "Updated ${weatherProvider.currentWeatherInfo.currentStrUpdatedDate}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.0,
                                    color: Colors.white,
                                    shadows: textShadows,
                                  ),
                                ),
                                //SizedBox(height: deviceHeight * 0.05),
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
                                            .round()
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
                                //SizedBox(height: deviceHeight * 0.05),
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
                                          "${weatherProvider.currentWeatherInfo.windKph!.round()}km/h",
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
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: TextButton(
                                                  onPressed: () {
                                                    setState(() => isHourlyForecast = true);
                                                  },
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: isHourlyForecast
                                                        ? Colors.blueGrey.shade900
                                                        : Colors.white,
                                                    foregroundColor: isHourlyForecast
                                                        ? Colors.white
                                                        : Colors.blueGrey.shade900,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(10.0), // <-- Radius
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "Hourly",
                                                    style: TextStyle(fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10.0),
                                              Expanded(
                                                child: TextButton(
                                                  onPressed: () {
                                                    setState(() => isHourlyForecast = false);
                                                  },
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: isHourlyForecast
                                                        ? Colors.white
                                                        : Colors.blueGrey.shade900,
                                                    foregroundColor: isHourlyForecast
                                                        ? Colors.blueGrey.shade900
                                                        : Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(10.0), // <-- Radius
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "Daily",
                                                    style: TextStyle(fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 160.0,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: isHourlyForecast
                                                  ? weatherProvider.forecastDay[0].hour.length
                                                  : weatherProvider.forecastDay.length,
                                              itemBuilder: (_, idx) {
                                                return SizedBox(
                                                  child: Card(
                                                    color: Colors.blueGrey.shade100,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(5.0), // <-- Radius
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Column(
                                                        children: [
                                                          Image(
                                                            image: NetworkImage(
                                                              "https:${weatherProvider.currentWeatherInfo.condition!.icon}",
                                                            ),
                                                          ),
                                                          Text(
                                                            isHourlyForecast
                                                                ? setDayTime(weatherProvider
                                                                    .forecastDay[0].hour[idx].time)
                                                                : setWeekDay(weatherProvider
                                                                    .forecastDay[idx].date),
                                                          ),
                                                          Text(
                                                            isHourlyForecast
                                                                ? "${weatherProvider.forecastDay[0].hour[idx].tempC.round()}\u00B0"
                                                                : "${weatherProvider.forecastDay[idx].day.avgtempC.round()}\u00B0",
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Icon(Icons.water_drop_rounded),
                                                              Text(
                                                                isHourlyForecast
                                                                    ? "${weatherProvider.forecastDay[0].hour[idx].humidity.round()}%"
                                                                    : "${weatherProvider.forecastDay[idx].day.avghumidity.round()}%",
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: deviceWidth - 30,
                                  child: TextButton(
                                    onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const SavedLocationsScreen(),
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blueGrey,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: const Text(
                                      "Saved Locations",
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: deviceWidth - 80,
                                      child: TextFormField(
                                        textCapitalization: TextCapitalization.words,
                                        key: cityKey,
                                        controller: cityController,
                                        decoration: InputDecoration(
                                          hintText: "Search City",
                                          hintStyle: const TextStyle(color: Colors.white),
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white.withOpacity(0.4),
                                          contentPadding: const EdgeInsets.symmetric(
                                              vertical: 2.0, horizontal: 20.0),
                                        ),
                                        validator: (value) {
                                          if (value == null) return 'City name is required.';
                                          return "";
                                        },
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.search_rounded,
                                        size: 30.0,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        weatherProvider.getWeatherInfo(city: cityController.text);
                                        weatherProvider.getForecastInfo(city: cityController.text);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
    );
  }
}
