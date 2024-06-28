part of 'post_bloc.dart';

@freezed
class PostState with _$PostState {
  const PostState._();
  const factory PostState({
    @JsonKey(includeFromJson: false, includeToJson: false)
    AsyncSnapshot? asyncSnapshot,
    @Default([]) List<PostEntity> postList,
    @Default(15) int fetchLimit,
    @Default(0) int offset,
  }) = _PostState;
}
