import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// WeatherData class to handle storing and retrieving city name using SharedPreferences
class WeatherData with ChangeNotifier {
  // Method to save the city name to SharedPreferences
  Future<void> setCity(String cityName) async {
    SharedPreferences pref = await SharedPreferences.getInstance(); // Get SharedPreferences instance
    pref.setString("cityName", cityName); // Save the city name
  }

  // Method to get the city name from SharedPreferences
  Future<String?> getCity() async {
    SharedPreferences pref = await SharedPreferences.getInstance(); // Get SharedPreferences instance
    String? cityName = pref.getString("cityName"); // Retrieve the city name
    return cityName; // Return the city name
  }

  // Method to remove the city name from SharedPreferences
  Future<bool> removeCity() async {
    SharedPreferences pref = await SharedPreferences.getInstance(); // Get SharedPreferences instance
    return pref.clear(); // Clear all data from SharedPreferences
  }
}
