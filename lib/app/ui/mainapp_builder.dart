import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetwork_client/app/di/init_di.dart';
import 'package:socialnetwork_client/app/domain/app_builder.dart';
import 'package:socialnetwork_client/app/ui/root_screen.dart';
import 'package:socialnetwork_client/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:socialnetwork_client/feature/posts/domain/post_repository.dart';
import 'package:socialnetwork_client/feature/posts/domain/post_state/bloc/post_bloc.dart';

class MainAppBuildert implements AppBuilder {
  @override
  Widget buildApp() {
    // TODO: implement buildApp
    return const _GlobalProviders(
      child: MaterialApp(
        home: RootScreen(),
      ),
    );
  }
}

class _GlobalProviders extends StatelessWidget {
  const _GlobalProviders({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (cointext) => locator.get<AuthCubit>(),
        ),
        BlocProvider(
          create: (cointext) =>
              PostBloc(locator.get<PostRepository>(), locator.get<AuthCubit>())
                ..add(PostEvent.getPosts()),
        ),
      ],
      child: child,
    );
  }
}
