import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetwork_client/app/ui/components/app_button.dart';
import 'package:socialnetwork_client/app/ui/components/app_confirmpass_textfield.dart';
import 'package:socialnetwork_client/app/ui/components/app_text_field.dart';
import 'package:socialnetwork_client/feature/auth/domain/auth_state/auth_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final loginController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Screen'),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField(
                  controller: loginController,
                  label: 'login',
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: emailController,
                  label: 'email',
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: passwordController,
                  label: 'password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                AppConfirmPasswordTextField(
                  controller: repeatPasswordController,
                  confirmedController: passwordController,
                  label: 'repeat password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(height: 16),
                AppButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {
                      _onTapSignUp(context.read<AuthCubit>());
                      Navigator.pop(context);
                    }
                  },
                  title: 'register',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignUp(AuthCubit cubit) {
    cubit.signUp(
        username: loginController.text,
        password: passwordController.text,
        email: emailController.text);
  }
}
