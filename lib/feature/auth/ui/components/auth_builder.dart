import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetwork_client/app/domain/error_entity/error_entity.dart';
import 'package:socialnetwork_client/app/ui/components/app_snackbar.dart';
import 'package:socialnetwork_client/feature/auth/domain/auth_state/auth_cubit.dart';

class AuthBuilder extends StatelessWidget {
  const AuthBuilder({
    super.key,
    required this.isNotAuthorized,
    required this.isWaiting,
    required this.isAuthorized,
  });

  final WidgetBuilder isNotAuthorized;
  final WidgetBuilder isWaiting;
  final ValueWidgetBuilder isAuthorized;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          return state.when(
              notAuthorized: () => isNotAuthorized(context),
              authorized: (userEntity) =>
                  isAuthorized(context, userEntity, this),
              waiting: () => isWaiting(context),
              error: (error) => isNotAuthorized(context));
        },
        listenWhen: (previous, current) =>
            previous.mapOrNull(error: (value) => value) !=
            current.mapOrNull(error: (value) => value),
        listener: (context, state) {
          state.whenOrNull(
              error: (error) => AppSnackbar.showSnackBarWithError(
                  context, ErrorEntity.fromException(error)));
        });
  }
}
