part of 'post_cubit.dart';

@freezed
class PostState with _$PostState {
  const PostState._();
  const factory PostState({
    @JsonKey(includeFromJson: false, includeToJson: false)
    AsyncSnapshot? asyncSnapshot,
    @Default([]) List<PostEntity> postList,
  }) = _PostState;

  factory PostState.fromJson(Map<String, dynamic> json) =>
      _$PostStateFromJson(json);
}
