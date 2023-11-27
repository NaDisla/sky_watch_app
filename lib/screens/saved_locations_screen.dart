import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SavedLocationsScreen extends StatelessWidget {
  const SavedLocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Expanded(
                child: ListView.builder(
                    itemCount: 5,
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
                                  "19\u00B0",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.water_drop_rounded),
                                    Text("60%"),
                                    SizedBox(width: 10.0),
                                    Icon(Icons.air_rounded),
                                    Text("12km/h"),
                                  ],
                                ),
                                Text(
                                  "Santo Domingo",
                                  style: TextStyle(
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
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
