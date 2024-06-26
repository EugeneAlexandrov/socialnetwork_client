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
  late final Dio dioTokens;

  DioAppApi(AppConfig appConfig) {
    final options = BaseOptions(
      baseUrl: appConfig.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );
    dio = Dio(options);
    dioTokens = Dio(options);

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger());
      dioTokens.interceptors.add(PrettyDioLogger());
    }
    dio.interceptors.add(AuthInterceptor(dio));
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
      return dioTokens.post('/auth/token/$refreshToken');
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
    try {
      return dio.put('/auth/user', data: {
        'actualPassword': oldPassword,
        'newPassword': newPassword,
      });
    } catch (e) {
      rethrow;
    }
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
    try {
      return dioTokens.fetch(requestOptions);
    } catch (e) {
      print('fetch');
      rethrow;
    }
  }

  @override
  Future getPosts({required int offset, required int fetchLimit}) {
    try {
      return dio.get("/data/posts", queryParameters: {
        'fetchLimit': fetchLimit,
        'offset': offset,
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future createPost(Map arqs) {
    try {
      return dio.post(
        '/data/posts',
        data: {"name": arqs["name"], "content": arqs["content"]},
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getPost(String id) {
    try {
      return dio.get("/data/posts/$id");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future deletePost(String id) {
    try {
      return dio.delete('/data/posts/$id');
    } catch (e) {
      rethrow;
    }
  }
}
