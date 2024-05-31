import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetwork_client/app/domain/error_entity/error_entity.dart';
import 'package:socialnetwork_client/app/ui/app_loader.dart';
import 'package:socialnetwork_client/app/ui/components/app_snackbar.dart';
import 'package:socialnetwork_client/app/ui/components/app_text_field.dart';
import 'package:socialnetwork_client/feature/auth/domain/auth_state/auth_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16);
    return Scaffold(
      appBar: AppBar(title: const Text('Личный кабинет'), actions: [
        IconButton.outlined(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthCubit>().logOut();
            },
            icon: const Icon(Icons.logout_outlined))
      ]),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (BuildContext context, AuthState state) {
          state.whenOrNull(
            authorized: (userEntity) {
              if (userEntity.userState?.hasData == true) {
                AppSnackbar.showSnackBarWithMessage(
                    context, userEntity.userState?.data);
              }
              if (userEntity.userState?.hasError == true) {
                AppSnackbar.showSnackBarWithError(context,
                    ErrorEntity.fromException(userEntity.userState?.error));
              }
            },
          );
        },
        builder: (context, state) {
          final user = state.whenOrNull(authorized: (userEntity) => userEntity);
          if (user?.userState?.connectionState == ConnectionState.waiting) {
            return const AppLoader();
          }
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        radius: 45,
                        child: Text(
                          user?.username.split('').first.toUpperCase() ?? 'N/A',
                          style: TextStyle(fontSize: 50),
                        )),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('username: ${user?.username}', style: textStyle),
                        const SizedBox(height: 8),
                        Text('email: ${user?.email}', style: textStyle),
                        const SizedBox(height: 8),
                        Text('id: ${user?.id}', style: textStyle),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 16),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('обновить пароль'),
                      ),
                      TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => _UserUpdateDialog());
                        },
                        child: Text('обновить данные'),
                      ),
                    ]),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _UserUpdateDialog extends StatefulWidget {
  const _UserUpdateDialog({super.key});

  @override
  State<_UserUpdateDialog> createState() => __UserUpdateDialogState();
}

class __UserUpdateDialogState extends State<_UserUpdateDialog> {
  var emailController = TextEditingController();
  final usernameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    usernameController.text = context
            .read<AuthCubit>()
            .state
            .whenOrNull(authorized: (userEntity) => userEntity.username) ??
        '';
    emailController.text = context
            .read<AuthCubit>()
            .state
            .whenOrNull(authorized: (userEntity) => userEntity.email) ??
        '';
    return Form(
      key: formKey,
      child: AlertDialog(
        title: const Text('Изменение профиля'),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Отмена")),
          TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  context.read<AuthCubit>().updateProfile(
                      username: usernameController.text,
                      email: emailController.text);
                }
              },
              child: Text("Изменить")),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(controller: usernameController, label: 'username'),
            const SizedBox(
              height: 16,
            ),
            AppTextField(controller: emailController, label: 'email')
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    usernameController.dispose();
    super.dispose();
  }
}
