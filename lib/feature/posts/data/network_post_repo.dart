import 'package:injectable/injectable.dart';
import 'package:socialnetwork_client/app/domain/app_api.dart';
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
  Future getPost({required String id}) {
    // TODO: implement getPost
    throw UnimplementedError();
  }

  @override
  Future<Iterable> getPosts() async {
    try {
      final response = await api.getPosts();
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
