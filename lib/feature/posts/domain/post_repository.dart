abstract class PostRepository {
  Future<dynamic> getPosts({required int offset, required int fetchLimit});
  Future<dynamic> createPost(Map arqs);
  Future<dynamic> getPost(String id);
  Future<dynamic> deletePost(String id);
}
