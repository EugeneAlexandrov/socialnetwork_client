import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:socialnetwork_client/app/data/auth_interceptor.dart';
import 'package:socialnetwork_client/app/domain/app_api.dart';
import 'package:socialnetwork_client/app/domain/app_config.dart';

@Singleton(as: AppApi)
class DioAppApi implements AppApi {
  late final Dio dio;

  DioAppApi(AppConfig appConfig) {
    final options =
        BaseOptions(baseUrl: appConfig.baseUrl, connectTimeout: 15000);
    dio = Dio(options);
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
      ));
    }
    dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<Response> getProfile() {
    try {
      return dio.get('/auth/user');
    } catch (e) {
      print('Api getProfile catch exception');
      rethrow;
    }
  }

  @override
  Future<Response> refreshToken({String? refreshToken}) {
    try {
      return dio.post('/auth/token/$refreshToken');
    } catch (e) {
      print('Api refreshToken catch exception');
      rethrow;
    }
  }

  @override
  Future<Response> signIn(
      {required String password, required String username}) {
    try {
      return dio.post(
        '/auth/token',
        data: {
          'username': username,
          'password': password,
        },
      );
    } catch (e) {
      print('Api signIn catch exception');
      rethrow;
    }
  }

  @override
  Future<Response> signUp(
      {required String password,
      required String username,
      required String email}) {
    try {
      return dio.put(
        '/auth/token',
        data: {
          'username': username,
          'email': email,
          'password': password,
        },
      );
    } catch (e) {
      print('Api signUp catch exception');
      rethrow;
    }
  }

  @override
  Future<Response> updatePassword(
      {required String oldPassword, required String newPassword}) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }

  @override
  Future<Response> updateProfile({String? username, String? email}) {
    try {
      return dio.post(
        '/auth/user',
        data: {
          'username': username,
          'password': email,
        },
      );
    } catch (e) {
      print('Api updateProfile catch exception');
      rethrow;
    }
  }

  @override
  Future request(String path) {
    try {
      return dio.request(path);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> fetch(RequestOptions requestOptions) {
    return dio.fetch(requestOptions);
  }
}