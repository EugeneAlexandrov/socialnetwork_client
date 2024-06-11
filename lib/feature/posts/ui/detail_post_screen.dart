import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetwork_client/app/di/init_di.dart';
import 'package:socialnetwork_client/app/ui/app_loader.dart';
import 'package:socialnetwork_client/feature/posts/domain/post_repository.dart';
import 'package:socialnetwork_client/feature/posts/domain/post_state/detail_post/cubit/detail_post_cubit.dart';
import 'package:socialnetwork_client/feature/posts/ui/post_detail_view.dart';

class DetailPostScreen extends StatelessWidget {
  const DetailPostScreen(this.id, {super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Пост $id'),
      ),
      body: BlocProvider(
        create: (context) =>
            DetailPostCubit(locator.get<PostRepository>(), id.toString())
              ..getPost(),
        child: BlocConsumer<DetailPostCubit, DetailPostState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.post != null) {
              return PostDetailView(state.post!);
            }
            if (state.asyncSnapshot.connectionState ==
                ConnectionState.waiting) {
              return AppLoader();
            }
            return Text("Ошибка");
          },
        ),
      ),
    );
  }
}
