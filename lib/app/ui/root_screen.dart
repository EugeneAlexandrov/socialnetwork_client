import 'package:flutter/widgets.dart';
import 'package:socialnetwork_client/app/ui/app_loader.dart';
import 'package:socialnetwork_client/app/ui/main_screen.dart';
import 'package:socialnetwork_client/feature/auth/ui/components/auth_builder.dart';
import 'package:socialnetwork_client/feature/auth/ui/login_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBuilder(
        isNotAuthorized: (context) => LoginScreen(),
        isWaiting: (context) => const AppLoader(),
        isAuthorized: (context, value, child) => MainScreen(user: value));
  }
}
