part of 'post_bloc.dart';

@freezed
class PostEvent with _$PostEvent {
  const PostEvent._();
  factory PostEvent.getPosts() = _PostEventGetPosts;
  factory PostEvent.createPost(Map<String, dynamic> args) =
      _PostEventCreatePost;
  factory PostEvent.logout() =
      _PostEventLogout;
}
