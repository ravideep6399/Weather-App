import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/res/colors.dart';

// Utils class containing utility methods for showing messages
class Utils {
  // Method to show a toast message
  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message, // Message to display
        backgroundColor: AppColors.error, // Background color of the toast
        textColor: AppColors.baseColor); // Text color of the toast
  }

  // Method to show a Flushbar error message
  static void flushbarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context, // BuildContext to show the Flushbar
        flushbar: Flushbar(
          backgroundColor: AppColors.error, // Background color of the Flushbar
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), // Margin around the Flushbar
          padding: const EdgeInsets.all(10), // Padding inside the Flushbar
          duration: const Duration(seconds: 3), // Duration for which the Flushbar is displayed
          message: message, // Message to display
          flushbarPosition: FlushbarPosition.TOP, // Position of the Flushbar
          borderRadius: const BorderRadius.all(Radius.circular(5)), // Border radius for rounded corners
          icon: const Icon(
            Icons.error, // Icon to display
            size: 28, // Size of the icon
            color: AppColors.baseColor, // Color of the icon
          ),
        )..show(context)); // Show the Flushbar
  }
}
