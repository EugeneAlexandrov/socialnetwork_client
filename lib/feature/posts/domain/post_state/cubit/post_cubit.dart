import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:socialnetwork_client/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:socialnetwork_client/feature/posts/domain/entity/post/post_entity.dart';
import 'package:socialnetwork_client/feature/posts/domain/post_repository.dart';

part 'post_state.dart';
part 'post_cubit.freezed.dart';
part 'post_cubit.g.dart';

class PostCubit extends HydratedCubit<PostState> {
  PostCubit(this.repository, this.authCubit)
      : super(const PostState(asyncSnapshot: AsyncSnapshot.nothing())) {
    authSubscreption = authCubit.stream.listen(
      (state) {
        state.mapOrNull(
          authorized: (value) => getPosts(),
          notAuthorized: (value) => logout(),
        );
      },
    );
  }

  final PostRepository repository;
  final AuthCubit authCubit;
  late StreamSubscription authSubscreption;

  Future<void> getPosts() async {
    emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
    await repository.getPosts().then((value) {
      final Iterable iterable = value;
      emit(
        state.copyWith(
          asyncSnapshot:
              const AsyncSnapshot.withData(ConnectionState.done, true),
          postList: iterable.map((e) => PostEntity.fromJson(e)).toList(),
        ),
      );
    }).catchError((error) {
      addError(error);
    });
  }

  void logout() {
    emit(state.copyWith(asyncSnapshot: AsyncSnapshot.nothing(), postList: []));
  }

  void createPost(Map arqs) async {
    // emit(state.copyWith(asyncSnapshot: AsyncSnapshot.waiting()));
    await repository.createPost(arqs).then((value) {
      getPosts();
    }).catchError((error) {
      addError(error);
    });
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    emit(state.copyWith(
        asyncSnapshot: AsyncSnapshot.withError(ConnectionState.done, error)));
    super.addError(error, stackTrace);
  }

  @override
  PostState? fromJson(Map<String, dynamic> json) {
    return PostState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PostState state) {
    return state.toJson();
  }

  @override
  Future<void> close() {
    authSubscreption.cancel();
    return super.close();
  }
}
