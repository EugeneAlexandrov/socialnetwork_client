import 'package:flutter/material.dart';
import 'package:socialnetwork_client/app/domain/error_entity/error_entity.dart';

abstract class AppSnackbar {
  static void showSnackBarWithError(BuildContext context, ErrorEntity error) {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: SingleChildScrollView(
          child: Text(
            maxLines: 5,
            'Error: ${error.errorMessage}, Message: ${error.message}',
          ),
        ),
      ),
    );
  }

  static void showSnackBarWithMessage(BuildContext context, String message) {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: SingleChildScrollView(
          child: Text(maxLines: 5, message),
        ),
      ),
    );
  }

  static void clearSnackBar(BuildContext context) {
    ScaffoldMessenger.maybeOf(context)?.clearSnackBars();
  }
}
