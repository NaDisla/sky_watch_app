import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sky_watch_app/models/models.dart';
import 'package:sky_watch_app/providers/providers.dart';

class SavedLocationsScreen extends StatefulWidget {
  const SavedLocationsScreen({super.key});

  @override
  State<SavedLocationsScreen> createState() => _SavedLocationsScreenState();
}

class _SavedLocationsScreenState extends State<SavedLocationsScreen> {
  List<WeatherInfo> foundLocations = [];

  @override
  void initState() {
    super.initState();
    foundLocations = Provider.of<WeatherProvider>(context, listen: false).locationsSaved;
  }

  void searchLocations(String query) {
    List<WeatherInfo> results = [];
    if (query.isEmpty) {
      results = Provider.of<WeatherProvider>(context, listen: false).locationsSaved;
    } else {
      results = Provider.of<WeatherProvider>(context, listen: false)
          .locationsSaved
          .where((w) => w.location!.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() => foundLocations = results);
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    double deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          forceMaterialTransparency: true,
          title: const Text(
            "Saved Locations",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
        backgroundColor: Colors.blueGrey,
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xff020024),
                Color(0xff095879),
                Color(0xff0092af),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(height: 100.0),
                TextField(
                  onChanged: (value) => searchLocations(value),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    hintText: "Search Location",
                    hintStyle: const TextStyle(color: Colors.white),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.4),
                    contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
                  ),
                ),
                foundLocations.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 80.0),
                        child: Text(
                          "No saved locations.",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: foundLocations.length,
                            itemBuilder: (_, idx) {
                              return Card(
                                color: Colors.white.withOpacity(0.4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${foundLocations[idx].current!.tempC!.round().toString()}\u00B0",
                                          style: const TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.water_drop_rounded),
                                            Text("${foundLocations[idx].current!.humidity}%"),
                                            const SizedBox(width: 10.0),
                                            const Icon(Icons.air_rounded),
                                            Text(
                                                "${foundLocations[idx].current!.windKph!.round().toString()}km/h"),
                                          ],
                                        ),
                                        Text(
                                          "${foundLocations[idx].location!.name}",
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 120,
                                      child: Lottie.asset(
                                        'assets/lottie_images/mist-weather.json',
                                        width: 100.0,
                                        height: 100.0,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => weatherProvider.setSavedLocations(
                                          weatherProvider.locationsSavedStr,
                                          weatherProvider.locationsSaved[idx],
                                          "remove"),
                                      icon: const Icon(Icons.remove, color: Colors.black),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
