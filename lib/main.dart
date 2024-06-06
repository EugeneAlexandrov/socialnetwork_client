import 'package:flutter/material.dart';
import 'package:socialnetwork_client/app/ui/mainapp_builder.dart';
import 'package:socialnetwork_client/app/ui/mainapp_runner.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  String env = const String.fromEnvironment('env', defaultValue: 'prod');
  final MainAppRunner runner = MainAppRunner(env);
  final MainAppBuildert builder = MainAppBuildert();
  runner.run(builder);
}