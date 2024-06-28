import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetwork_client/app/domain/error_entity/error_entity.dart';
import 'package:socialnetwork_client/app/ui/app_loader.dart';
import 'package:socialnetwork_client/app/ui/components/app_snackbar.dart';
import 'package:socialnetwork_client/feature/posts/domain/post_state/bloc/post_bloc.dart';
import 'package:socialnetwork_client/feature/posts/ui/post_item.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {
        if (state.asyncSnapshot?.hasError == true) {
          AppSnackbar.showSnackBarWithError(
              context, ErrorEntity.fromException(state.asyncSnapshot?.error));
        }
      },
      builder: (context, state) {
        if (state.postList.isNotEmpty) {
          return NotificationListener<ScrollEndNotification>(
            onNotification: (notification) {
              if (notification.metrics.maxScrollExtent ==
                  notification.metrics.pixels) {
                context.read<PostBloc>().add(PostEvent.getPosts());
                return true;
              }
              return false;
            },
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.postList.length,
                itemBuilder: (context, i) {
                  return PostItem(post: state.postList[i]);
                }),
          );
        }
        if (state.asyncSnapshot?.connectionState == ConnectionState.waiting) {
          return AppLoader();
        }
        return Center(child: Text('Нет постов'));
      },
    );
  }
}
