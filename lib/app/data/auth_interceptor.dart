import 'package:dio/dio.dart';
import 'package:socialnetwork_client/app/di/init_di.dart';
import 'package:socialnetwork_client/feature/auth/domain/auth_state/auth_cubit.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('badRequestInterceptor onRequest');
    final accessToken = locator.get<AuthCubit>().state.whenOrNull(
          authorized: (userEntity) => userEntity.accessToken,
        );
    if (accessToken == null) {
      //super.onRequest(options, handler);
      super.onRequest(options, handler);
    } else {
      options.headers['Authorization'] = 'Bearer $accessToken';
      handler.next(options);
    }
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    print('badRequestInterceptor onError call');

    if (err.response?.statusCode == 401) {
      try {
        await locator.get<AuthCubit>().refreshToken().then((token) async {
          if (token == null) {
            super.onError(err, handler);
          } else {
            err.requestOptions.headers["Authorization"] = 'Bearer $token';
            return handler.resolve(await _retry(err.requestOptions));
          }
        });
      } on DioException catch (error) {
        super.onError(error, handler);
      }
    } else {
      super.onError(err, handler);
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    // Create a new `RequestOptions` object with the same method, path, data, and query parameters as the original request.
    final options = Options(
      method: requestOptions.method,
    );

    // Retry the request with the new `RequestOptions` object.
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
