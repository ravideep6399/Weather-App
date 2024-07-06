import 'package:flutter/material.dart';
import 'package:weather_app/home_page.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/utils/routes/routes_name.dart';
import 'package:weather_app/weather_details_page.dart';

// Routes class to handle route generation
class Routes {
  // Method to generate routes based on route settings
  static MaterialPageRoute generateRoutes(RouteSettings settings) {
    // Switch statement to handle different routes based on their names
    switch (settings.name) {
      case RoutesName.home:
        // Route for HomePage
        return MaterialPageRoute(builder: ((context) => const HomePage()));
      case RoutesName.weatherDetails:
        // Route for WeatherDetailsPage
        return MaterialPageRoute(
            builder: ((context) => const WeatherDetailsPage()));
      case RoutesName.splash:
        // Route for SplashScreen
        return MaterialPageRoute(builder: ((context) => const SplashScreen()));
      default:
        // Default route for unknown route names
        return MaterialPageRoute(builder: ((_) {
          return const Scaffold(
            body: Text("Route Not Found"), // Displays "Route Not Found" message
          );
        }));
    }
  }
}
