import 'package:injectable/injectable.dart';
import 'package:socialnetwork_client/app/domain/app_api.dart';
import 'package:socialnetwork_client/feature/auth/data/dto/user_dto.dart';
import 'package:socialnetwork_client/feature/auth/domain/auth_repository.dart';
import 'package:socialnetwork_client/feature/auth/domain/entities/user_entity.dart';

@Injectable(as: AuthRepository)
@prod
class NetworkAuthRepository implements AuthRepository {
  final AppApi api;

  NetworkAuthRepository({required this.api});

  @override
  Future<UserEntity> getProfile() async {
    try {
      final response = await api.getProfile();
      return UserDto.fromJson(response.data['data']).toUserEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future refreshToken({String? refreshToken}) async {
    try {
      final response = await api.refreshToken(refreshToken: refreshToken);
      print('Repository refresh token  finished');
      return UserDto.fromJson(response.data['data']).toUserEntity();
    } catch (e) {
      print('Repository refresh token catch exception');
      rethrow;
    }
  }

  @override
  Future<UserEntity> signIn(
      {required String password, required String username}) async {
    try {
      final response = await api.signIn(password: password, username: username);
      return UserDto.fromJson(response.data['data']).toUserEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future signUp(
      {required String password,
      required String username,
      required String email}) async {
    try {
      final response = await api.signUp(
          password: password, username: username, email: email);
      return UserDto.fromJson(response.data['data']).toUserEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future updatePassword(
      {required String oldPassword, required String newPassword}) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }

  @override
  Future updateProfile({String? username, String? email}) async {
    try {
      final response =
          await api.updateProfile(username: username, email: email);
      print('Repository Update profile finished');
      return UserDto.fromJson(response.data['data']).toUserEntity();
    } catch (e) {
      print('Repository Update profile сatch exception');
      rethrow;
    }
  }
}
