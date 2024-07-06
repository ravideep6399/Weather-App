import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/res/colors.dart';

// LoaderPage widget to show a loading spinner
class LoaderPage extends StatefulWidget {
  const LoaderPage({super.key});

  @override
  State<LoaderPage> createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Sets the background color of the loading screen
      color: AppColors.fade,
      child: const Center(
        // Displays a spinning grid animation in the center of the screen
        child: SpinKitFadingGrid(
          color: Colors.orange,// Sets the color of the spinner
        ),
      ),
    );
  }
}
