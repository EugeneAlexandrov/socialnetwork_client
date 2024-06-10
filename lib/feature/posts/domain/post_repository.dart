abstract class PostRepository {
  Future<dynamic> getPosts();
  Future<dynamic> createPost();
  Future<dynamic> getPost({required String id});
}
