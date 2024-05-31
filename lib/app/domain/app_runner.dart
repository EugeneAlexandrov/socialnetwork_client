import 'package:socialnetwork_client/app/domain/app_builder.dart';

abstract class AppRunner {
  Future<void> preloaddata();
  Future<void> run(AppBuilder appBuilder);
}
