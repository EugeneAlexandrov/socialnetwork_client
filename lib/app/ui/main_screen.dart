import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetwork_client/app/ui/profile_screen.dart';
import 'package:socialnetwork_client/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:socialnetwork_client/feature/auth/domain/entities/user_entity.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.user});
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton.outlined(
              onPressed: () {
                context.read<AuthCubit>().getProfile();
                showDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    content: Column(
                      children: [
                        Text(user.username),
                        Text(user.email),
                      ],
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.face)),
          IconButton.outlined(
              onPressed: () {
                context.read<AuthCubit>().refershToken();
              },
              icon: const Icon(Icons.refresh_outlined)),
          IconButton.outlined(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.account_box_outlined)),
        ],
        title: const Text('Main Screen'),
      ),
      body: Column(children: [
        const SizedBox(height: 8),
        Text('accessToken: ${user?.accessToken}', style: textStyle),
        const SizedBox(height: 8),
        Text('refreshToken: ${user?.refreshToken}', style: textStyle),
      ]),
    );
  }
}
