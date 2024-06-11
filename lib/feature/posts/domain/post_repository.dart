abstract class PostRepository {
  Future<dynamic> getPosts();
  Future<dynamic> createPost(Map arqs);
  Future<dynamic> getPost({required String id});
}
