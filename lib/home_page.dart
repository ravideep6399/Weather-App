import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/res/colors.dart';
import 'package:weather_app/res/components/loding_page.dart';
import 'package:weather_app/utils/routes/routes_name.dart';
import 'package:weather_app/viewModels/weather_details_view_model.dart';

// HomePage widget for the main screen of the weather app
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController cityName =
      TextEditingController(); // Controller for the city name input field
  final formkey = GlobalKey<FormState>(); // GlobalKey for the form validation

  @override
  void dispose() {
    cityName.dispose(); // Dispose the city name controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherDetailsViewModel>(
        context); // Access WeatherDetailsViewModel instance
    bool loading = weather.loading; // Get loading state from the view model

    return Stack(
      children: [
        Container(
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
          child: Scaffold(
            backgroundColor: AppColors.transparent,
            appBar: AppBar(
              backgroundColor: AppColors.transparent,
              centerTitle: true,
              title: const Text(
                "Home", // Title of the app bar
              ),
              titleTextStyle: const TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Container(
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 500),
                        child: Form(
                          key: formkey, // Form key for validation
                          child: TextFormField(
                            controller: cityName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a city name"; // Validation error message
                              }
                              return null;
                            },
                            cursorColor: AppColors.black,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              labelText: "Search",
                              prefixIcon: const Icon(Icons.location_on),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    // Validate input and fetch weather data
                                    weather
                                        .fetchWeather(cityName.text.toString());
                                    Navigator.pushReplacementNamed(
                                        context, RoutesName.weatherDetails);
                                  }
                                },
                              ),
                              focusedBorder: const UnderlineInputBorder(),
                              floatingLabelStyle: const TextStyle(
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        loading
            ? const LoaderPage()
            : Container(), // Show loader if loading is true
      ],
    );
  }
}
