import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:weather_app/res/colors.dart';
import 'package:weather_app/res/components/loding_page.dart';
import 'package:weather_app/utils/routes/routes.dart';
import 'package:weather_app/utils/routes/routes_name.dart';
import 'package:weather_app/viewModels/service/splash_service.dart';
import 'package:weather_app/viewModels/storing_data.dart';
import 'package:weather_app/viewModels/weather_details_view_model.dart';

// Entry point of the application
Future<void> main() async {
  runApp(const MyApp());
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Providing necessary view models using ChangeNotifierProvider
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => WeatherData()),
        ChangeNotifierProvider(create: (_) => SplashServices())
      ],
      builder: (context, child) {
        // Preload the background image to improve performance
        precacheImage(const AssetImage("assets/background.png"), context);
        return MaterialApp(
          // Using ResponsiveWrapper to handle responsiveness
          builder: (context, child) => ResponsiveWrapper.builder(child,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(480, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              ],
              background: Container(color: AppColors.baseColor)),
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.black),
            useMaterial3: true,
          ),
          initialRoute: RoutesName.splash,
          onGenerateRoute: Routes.generateRoutes,
        );
      },
    );
  }
}

// SplashScreen widget to display the splash screen(Loader Page) initially on starting.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Check for previous search data when the splash screen is initialized
    SplashServices().checkForPreviousSearch(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // Sets the background image for the splash screen
          image: DecorationImage(
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover,
              colorFilter:
                  ColorFilter.mode(AppColors.baseColor, BlendMode.softLight))),
      child: const LoaderPage(), // Displays a loading page
    );
  }
}
