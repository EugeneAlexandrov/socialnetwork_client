import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socialnetwork_client/app/di/init_di.dart';
import 'package:socialnetwork_client/app/domain/app_builder.dart';
import 'package:socialnetwork_client/app/domain/app_runner.dart';

class MainAppRunner implements AppRunner {
  final String env;

  MainAppRunner(this.env);

  @override
  Future<void> preloaddata() async {
    //init app
    initDi(env);
    //init config
  }

  @override
  Future<void> run(AppBuilder appBuilder) async {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    );
    await preloaddata();
    runApp(appBuilder.buildApp());
  }
}
