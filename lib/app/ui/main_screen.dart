import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetwork_client/app/ui/profile_screen.dart';
import 'package:socialnetwork_client/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:socialnetwork_client/feature/auth/domain/entities/user_entity.dart';
import 'package:socialnetwork_client/feature/posts/ui/post_list.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.user});
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16);

    return SafeArea(
      child: Scaffold(
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
                  context.read<AuthCubit>().refreshToken();
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
        body: const PostList(),
      ), 
    );
  }
}
