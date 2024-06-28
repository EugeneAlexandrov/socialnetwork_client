import 'package:injectable/injectable.dart';
import 'package:socialnetwork_client/app/domain/app_api.dart';
import 'package:socialnetwork_client/feature/posts/domain/entity/post/post_entity.dart';
import 'package:socialnetwork_client/feature/posts/domain/post_repository.dart';

@Injectable(as: PostRepository)
@prod
class NetworkPostRepository implements PostRepository {
  final AppApi api;

  NetworkPostRepository({required this.api});

  @override
  Future<String> createPost(Map arqs) async {
    try {
      final response = await api.createPost(arqs);
      return response.data["message"];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PostEntity> getPost(String id) async {
    try {
      final response = await api.getPost(id);
      return PostEntity.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Iterable> getPosts(
      {required int offset, required int fetchLimit}) async {
    try {
      final response =
          await api.getPosts(offset: offset, fetchLimit: fetchLimit);
      if (response.data['data'].isEmpty) {
        return const Iterable.empty();
      } else {
        return response.data['data'];
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future deletePost(String id) async {
    try {
      await api.deletePost(id);
    } catch (e) {
      rethrow;
    }
  }
}
