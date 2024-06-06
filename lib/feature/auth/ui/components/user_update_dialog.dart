import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetwork_client/app/ui/components/app_text_field.dart';
import 'package:socialnetwork_client/feature/auth/domain/auth_state/auth_cubit.dart';

class UserUpdateDialog extends StatefulWidget {
  const UserUpdateDialog({super.key});

  @override
  State<UserUpdateDialog> createState() => _UserUpdateDialogState();
}

class _UserUpdateDialogState extends State<UserUpdateDialog> {
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
