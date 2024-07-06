import 'package:flutter/material.dart';
import 'package:weather_app/utils/routes/routes_name.dart';
import 'package:weather_app/viewModels/storing_data.dart';

// SplashServices class to handle splash screen logic
class SplashServices with ChangeNotifier {
  // Method to get the city name from stored data
  Future<String?> getCityName() async {
    return await WeatherData().getCity(); // Retrieve the city name from WeatherData
  }

  // Method to check for previous search and navigate accordingly
  void checkForPreviousSearch(BuildContext context) {
    getCityName().then((value) async {
      if (value == null || value == "") {
        // If no city name is found, navigate to the home page after a delay
        await Future.delayed(const Duration(seconds: 2));

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, RoutesName.home);
      } else {
        // If a city name is found, navigate to the weather details page after a delay
        await Future.delayed(const Duration(seconds: 2));

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, RoutesName.weatherDetails);
      }
    }).onError((error, stackTrace) => null); // Handle errors silently
  }
}
