import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/utils/consts.dart'; // Assuming OPEN_WEATHER_MAP_api_KEY is defined here
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/viewModels/storing_data.dart';

// WeatherDetailsViewModel class to handle weather details and data loading logic
class WeatherDetailsViewModel with ChangeNotifier {
  final WeatherFactory wF = WeatherFactory(OPEN_WEATHER_MAP_api_KEY); // WeatherFactory instance
  final data = WeatherData(); // WeatherData instance for storing city name
  bool _loading = false; // Flag to track loading state
  Weather? _weather; // Weather object to hold current weather data

  // Getters for loading state and weather data
  bool get loading => _loading;
  Weather? get weather => _weather;

  // Setters to update loading state and weather data
  setloading(bool value) {
    _loading = value;
    notifyListeners(); // Notify listeners of state change
  }

  setweather(Weather? value) {
    _weather = value;
    notifyListeners(); // Notify listeners of state change
  }

  // Constructor to load weather data when instantiated
  WeatherDetailsViewModel() {
    loadWeather();
  }

  // Method to load weather data
  Future<void> loadWeather() async {
    setloading(true); // Set loading state to true
    SharedPreferences prefs = await SharedPreferences.getInstance(); // Get SharedPreferences instance
    String? cityName = prefs.getString('cityName'); // Retrieve city name from SharedPreferences

    if (cityName != null) {
      fetchWeather(cityName); // Fetch weather data for the stored city name
      setloading(false); // Set loading state to false after data is fetched
    } else {
      setloading(false); // Set loading state to false
      // Utils.toastMessage("Some Error Occured"); // Uncomment if you want to show a toast message for error
    }
  }

  // Method to fetch weather data for a given city name
  Future<void> fetchWeather(String cityName) async {
    try {
      setloading(true); // Set loading state to true
      Weather weather = await wF.currentWeatherByCityName(cityName); // Fetch current weather data
      setweather(weather); // Set weather data in the state
      data.setCity(cityName); // Save the city name using WeatherData instance
      setloading(false); // Set loading state to false after data is fetched
    } catch (error) {
      setloading(false); // Set loading state to false
      // Handle different types of errors
      if (error.runtimeType.toString() == "_ClientSocketException") {
        Utils.toastMessage("No Internet Connection"); // Show toast message for no internet connection
      } else {
        // Extract meaningful error message
        int length = error.toString().length;
        String message = error.toString().substring(78, length - 2);
        Utils.toastMessage(message); // Show toast message for other errors
      }
    }
  }

  // Method to reset weather data and loading state
  void reset() async {
    setweather(null); // Reset weather data
    setloading(false); // Reset loading state
  }
}
