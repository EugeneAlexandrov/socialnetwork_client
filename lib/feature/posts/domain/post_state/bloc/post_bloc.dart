import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:socialnetwork_client/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:socialnetwork_client/feature/posts/domain/entity/post/post_entity.dart';
import 'package:socialnetwork_client/feature/posts/domain/post_repository.dart';

part 'post_state.dart';
part 'post_event.dart';
part 'post_bloc.freezed.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this.repository, this.authCubit)
      : super(const PostState(asyncSnapshot: AsyncSnapshot.nothing())) {
    authSubscription = authCubit.stream.listen(
      (state) {
        state.mapOrNull(
          authorized: (value) => add(PostEvent.getPosts()),
          notAuthorized: (value) => add(PostEvent.logout()),
        );
      },
    );
    on<_PostEventGetPosts>(getPosts);
    on<_PostEventCreatePost>(createPost);
    on<_PostEventLogout>(logout);
  }

  final PostRepository repository;
  final AuthCubit authCubit;
  late StreamSubscription authSubscription;

  Future<void> getPosts(PostEvent event, Emitter emitter) async {
    if (state.asyncSnapshot?.connectionState == ConnectionState.waiting) return;

    emitter(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await repository
        .getPosts(offset: state.offset, fetchLimit: state.fetchLimit)
        .then((value) {
      final Iterable iterable = value;
      final fetchedList = iterable.map((e) => PostEntity.fromJson(e)).toList();
      final mergedList = [...state.postList, ...fetchedList];
      emitter(
        state.copyWith(
          offset: state.offset + fetchedList.length,
          asyncSnapshot:
              const AsyncSnapshot.withData(ConnectionState.done, true),
          postList: mergedList,
        ),
      );
    }).catchError((error) {
      stateError(error, emitter);
    });
  }

  void logout(PostEvent event, Emitter emitter) {
    emitter(
        state.copyWith(asyncSnapshot: AsyncSnapshot.nothing(), postList: []));
  }

  void createPost(PostEvent event, Emitter emitter) async {
    // emit(state.copyWith(asyncSnapshot: AsyncSnapshot.waiting()));
    await repository
        .createPost((event as _PostEventCreatePost).args)
        .then((value) {
      add(PostEvent.getPosts());
    }).catchError((error) {
      stateError(error, emitter);
    });
  }

  void stateError(Object error, Emitter emitter) {
    emitter(state.copyWith(
        asyncSnapshot: AsyncSnapshot.withError(ConnectionState.done, error)));
    addError(error);
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}
