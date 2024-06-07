import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetwork_client/app/ui/components/app_text_field.dart';
import 'package:socialnetwork_client/feature/auth/domain/auth_state/auth_cubit.dart';

class PasswordUpdateDialog extends StatefulWidget {
  const PasswordUpdateDialog({super.key});

  @override
  State<PasswordUpdateDialog> createState() => _PasswordUpdateDialogState();
}

class _PasswordUpdateDialogState extends State<PasswordUpdateDialog> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AlertDialog(
        title: const Text('Изменение пароля'),
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
                  context.read<AuthCubit>().updatePassword(
                      oldPassword: oldPasswordController.text,
                      newPassword: newPasswordController.text);
                }
              },
              child: Text("Изменить")),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
                controller: oldPasswordController,
                label: 'old password',
                obscureText: true),
            const SizedBox(
              height: 16,
            ),
            AppTextField(
              controller: newPasswordController,
              label: 'new password',
              obscureText: true,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }
}
