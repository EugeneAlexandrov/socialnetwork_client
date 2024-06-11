import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:socialnetwork_client/feature/posts/domain/entity/post/post_entity.dart';
import 'package:socialnetwork_client/feature/posts/domain/post_repository.dart';

part 'detail_post_state.dart';
part 'detail_post_cubit.freezed.dart';
part 'detail_post_cubit.g.dart';

class DetailPostCubit extends HydratedCubit<DetailPostState> {
  DetailPostCubit(this.repository, this.id) : super(const DetailPostState());

  final PostRepository repository;
  final String id;

  Future<void> getPost() async {
    emit(state.copyWith(asyncSnapshot: AsyncSnapshot.waiting()));
    await repository.getPost(id).then((value) {
      emit(
        state.copyWith(
          asyncSnapshot:
              const AsyncSnapshot.withData(ConnectionState.done, true),
          post: value,
        ),
      );
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
  DetailPostState? fromJson(Map<String, dynamic> json) {
    DetailPostState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(DetailPostState state) {
    state.toJson();
  }
}
