part of 'detail_post_cubit.dart';

@freezed
class DetailPostState with _$DetailPostState {
  const DetailPostState._();
  const factory DetailPostState({
    @Default(AsyncSnapshot.nothing())
    @JsonKey(includeFromJson: false, includeToJson: false)
    AsyncSnapshot asyncSnapshot,
    PostEntity? post,
  }) = _DetailPostState;

  factory DetailPostState.fromJson(Map<String, dynamic> json) =>
      _$DetailPostStateFromJson(json);
}
