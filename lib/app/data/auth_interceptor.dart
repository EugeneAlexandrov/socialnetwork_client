import 'package:dio/dio.dart';
import 'package:socialnetwork_client/app/di/init_di.dart';
import 'package:socialnetwork_client/feature/auth/domain/auth_state/auth_cubit.dart';

class BadRequestInterceptor extends Interceptor {
  final Dio dio;

  BadRequestInterceptor(this.dio);

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
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('badRequestInterceptor onResponse');
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    print('badRequestInterceptor onError call');
    if (err.response?.statusCode == 401) {
      print('OLD ACCESSTOKEN: ${err.requestOptions.headers['Authorization']}');
      await locator.get<AuthCubit>().refreshToken();
      print('badRequestInterceptor onError refreshtoken() finished');
      final accessToken = locator.get<AuthCubit>().state.whenOrNull(
            authorized: (userEntity) => userEntity.accessToken,
          );
      print('NEW ACCESSTOKEN: $accessToken');
      err.requestOptions.headers['Auhtorization'] = 'Barier $accessToken';
      try {
        handler.resolve(await _retry(err.requestOptions));
      } on DioException catch (e) {
        // If the request fails again, pass the error to the next interceptor in the chain.
        handler.next(e);
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
