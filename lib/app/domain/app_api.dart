import 'package:dio/dio.dart';

abstract class AppApi {
  Future<dynamic> signUp({
    required String password,
    required String username,
    required String email,
  });
  Future<dynamic> signIn({
    required String password,
    required String username,
  });

  Future<dynamic> getProfile();

  Future<dynamic> updateProfile({
    String? username,
    String? email,
  });

  Future<dynamic> updatePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<dynamic> refreshToken({String? refreshToken});

  Future<dynamic> request(String path);

  Future<dynamic> fetch(RequestOptions requestOptions);
}
