import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/res/colors.dart';
import 'package:weather_app/res/components/loding_page.dart';
import 'package:weather_app/utils/routes/routes_name.dart';
import 'package:weather_app/viewModels/storing_data.dart';
import 'package:weather_app/viewModels/weather_details_view_model.dart';

// WeatherDetailsPage widget to display weather details
class WeatherDetailsPage extends StatefulWidget {
  const WeatherDetailsPage({super.key});

  @override
  State<WeatherDetailsPage> createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Width of the screen
    double height = MediaQuery.of(context).size.height; // Height of the screen
    final data =
        Provider.of<WeatherData>(context); // Access WeatherData instance
    Orientation orientation =
        MediaQuery.of(context).orientation; // Device orientation

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.png"), // Background image
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            AppColors.baseColor,
            BlendMode.softLight,
          ),
        ),
      ),
      child: Consumer<WeatherDetailsViewModel>(
        builder: (context, value, child) {
          if (value.loading) {
            // Show loader while loading weather data
            return const LoaderPage();
          } else if (value.weather == null) {
            // Display when no weather data is available
            return Scaffold(
              backgroundColor: AppColors.transparent,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.15,
                        child: Align(
                          alignment: AlignmentDirectional.bottomStart,
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to home screen on tap
                              Navigator.pushReplacementNamed(
                                  context, RoutesName.home);
                            },
                            child: const Icon(
                              Icons.home,
                              size: 45,
                              color: AppColors.shadow,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.8,
                        child: const Center(
                          child: Text(
                            "No data Available", // Message when no data is available
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            // Display weather details based on orientation
            if (orientation == Orientation.portrait) {
              return portrait(
                  value, height, width, data, context); // Portrait layout
            } else {
              return landscape(
                  value, height, width, data, context); // Landscape layout
            }
          }
        },
      ),
    );
  }
}

// Widget for portrait orientation layout
Widget portrait(dynamic value, double height, double width, final data,
    BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.transparent,
    body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          SizedBox(
            height: height * 0.1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: IconButton(
                      onPressed: () {
                        // Remove city data and reset weather details
                        data.removeCity();
                        value.reset();
                        Navigator.pushReplacementNamed(
                            context, RoutesName.home);
                      },
                      icon: const Icon(
                        Icons.home,
                        size: 35,
                        color: AppColors.shadow,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: IconButton(
                      onPressed: () {
                        // Refresh weather data for the current city
                        value.fetchWeather(
                          value.weather!.areaName.toString(),
                        );
                      },
                      icon: const Icon(
                        Icons.replay_outlined,
                        size: 35,
                        color: AppColors.shadow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SizedBox(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value.weather!.areaName.toString(), // Display area name
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: SizedBox(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value.weather!.country.toString(), // Display country name
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.25,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "${value.weather!.temperature!.celsius!.toStringAsFixed(1)}\u2103", // Display temperature
                style: const TextStyle(
                  fontSize: 120,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CircleAvatar(
                radius: height * 0.05,
                backgroundColor: AppColors.circleback,
                backgroundImage: NetworkImage(
                    "https://openweathermap.org/img/wn/${value.weather!.weatherIcon}@4x.png"), // Weather icon
              ),
            ),
          ),
          SizedBox(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                value.weather!.weatherMain
                    .toString(), // Display weather main description
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
            child: Text(
              value.weather!.weatherDescription
                  .toString(), // Display weather description
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.06,
          ),
          Container(
            width: width * 0.85,
            height: height * 0.15,
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: AppColors.baseColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Humidity : ${value.weather!.humidity}%", // Display humidity
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Wind : ${value.weather!.windSpeed}m/s", // Display wind speed
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "minTemp : ${value.weather!.tempMin!.celsius!.toStringAsFixed(1)}\u2103", // Display minimum temperature
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "maxTemp : ${value.weather!.tempMax!.celsius!.toStringAsFixed(1)}\u2103", // Display maximum temperature
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

// Widget for landscape orientation layout
Widget landscape(dynamic value, double height, double width, final data,
    BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.transparent,
    body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          SizedBox(
            height: height * 0.1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: IconButton(
                      onPressed: () {
                        // Remove city data and reset weather details
                        data.removeCity();
                        value.reset();
                        Navigator.pushReplacementNamed(
                            context, RoutesName.home);
                      },
                      icon: const Icon(
                        Icons.home,
                        size: 25,
                        color: AppColors.shadow,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: IconButton(
                      onPressed: () {
                        // Refresh weather data for the current city
                        value.fetchWeather(
                          value.weather!.areaName.toString(),
                        );
                      },
                      icon: const Icon(
                        Icons.replay_outlined,
                        size: 25,
                        color: AppColors.shadow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, top: 8),
            child: SizedBox(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value.weather!.areaName.toString(), // Display area name
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: SizedBox(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value.weather!.country.toString(), // Display country name
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.20,
            child: Align(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "${value.weather!.temperature!.celsius!.toStringAsFixed(1)}\u2103", // Display temperature
                  style: const TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(),
              child: CircleAvatar(
                radius: height * 0.055,
                backgroundColor: AppColors.circleback,
                backgroundImage: NetworkImage(
                    "https://openweathermap.org/img/wn/${value.weather!.weatherIcon}@4x.png"), // Weather icon
              ),
            ),
          ),
          SizedBox(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                value.weather!.weatherMain
                    .toString(), // Display weather main description
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.06,
            child: Text(
              value.weather!.weatherDescription
                  .toString(), // Display weather description
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.045,
          ),
          SizedBox(
            width: width * 0.85,
            height: height * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width * 0.15,
                  decoration: BoxDecoration(
                    color: AppColors.baseColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Humidity : ${value.weather!.humidity}%", // Display humidity
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Wind : ${value.weather!.windSpeed}m/s", // Display wind speed
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: width * 0.15,
                  decoration: BoxDecoration(
                    color: AppColors.baseColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "minTemp : ${value.weather!.tempMin!.celsius!.toStringAsFixed(1)}\u2103", // Display minimum temperature
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "maxTemp : ${value.weather!.tempMax!.celsius!.toStringAsFixed(1)}\u2103", // Display maximum temperature
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
