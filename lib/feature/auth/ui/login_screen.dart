import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetwork_client/app/ui/components/app_button.dart';
import 'package:socialnetwork_client/app/ui/components/app_text_field.dart';
import 'package:socialnetwork_client/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:socialnetwork_client/feature/auth/ui/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField(controller: loginController, label: 'login'),
                const SizedBox(height: 16),
                AppTextField(
                  controller: passwordController,
                  label: 'password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                AppButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _onTapSignIn(context.read<AuthCubit>());
                    }
                  },
                  title: 'sign in',
                ),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterScreen()));
                  },
                  child: Text('sign up'.toUpperCase()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignIn(AuthCubit cubit) {
    cubit.signIn(
        username: loginController.text, password: passwordController.text);
  }
}
