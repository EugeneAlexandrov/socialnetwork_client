import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetwork_client/app/di/init_di.dart';
import 'package:socialnetwork_client/app/domain/error_entity/error_entity.dart';
import 'package:socialnetwork_client/app/ui/app_loader.dart';
import 'package:socialnetwork_client/app/ui/components/app_snackbar.dart';
import 'package:socialnetwork_client/feature/posts/domain/post_repository.dart';
import 'package:socialnetwork_client/feature/posts/domain/post_state/bloc/post_bloc.dart';
import 'package:socialnetwork_client/feature/posts/domain/post_state/detail_post/cubit/detail_post_cubit.dart';
import 'package:socialnetwork_client/feature/posts/ui/post_detail_view.dart';

class DetailPostScreen extends StatelessWidget {
  const DetailPostScreen(this.id, {super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailPostCubit(locator.get<PostRepository>(), id.toString())
            ..getPost(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Пост $id'),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<DetailPostCubit>().deletePost().then((_) {
                    context.read<PostBloc>().add(PostEvent.getPosts());
                    Navigator.of(context).pop();
                  });
                },
                icon: const Icon(Icons.delete),
              )
            ],
          ),
          body: BlocConsumer<DetailPostCubit, DetailPostState>(
            listener: (context, state) {
              if (state.asyncSnapshot.hasData) {
                AppSnackbar.showSnackBarWithMessage(
                    context, state.asyncSnapshot.data.toString());
              }
              if (state.asyncSnapshot.hasError) {
                AppSnackbar.showSnackBarWithError(context,
                    ErrorEntity.fromException(state.asyncSnapshot.error));
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              if (state.asyncSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const AppLoader();
              }
              if (state.post != null) {
                return PostDetailView(state.post!);
              }

              return Text("Ошибка");
            },
          ),
        );
      }),
    );
  }
}
