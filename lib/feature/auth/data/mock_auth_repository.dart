import 'package:injectable/injectable.dart';
import 'package:socialnetwork_client/feature/auth/domain/auth_repository.dart';
import 'package:socialnetwork_client/feature/auth/domain/entities/user_entity.dart';

@Singleton(as: AuthRepository)
@dev
class MockAuthRepository implements AuthRepository {
  @override
  Future getProfile() {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  @override
  Future refreshToken({String? refreshToken}) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future signIn({
    required String password,
    required String username,
  }) {
    return Future.delayed(
      const Duration(seconds: 5),
      () {
        return UserEntity(email: 'testEmail', username: username, id: 'signIn');
      },
    );
  }

  @override
  Future signUp({
    required String password,
    required String username,
    required String email,
  }) {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        return UserEntity(email: email, username: username, id: 'signUp');
      },
    );
  }

  @override
  Future<String> updatePassword(
      {required String oldPassword, required String newPassword}) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }

  @override
  Future updateProfile({String? username, String? email}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
