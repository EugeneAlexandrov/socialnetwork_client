import 'package:dio/dio.dart';
import 'package:socialnetwork_client/app/di/init_di.dart';
import 'package:socialnetwork_client/app/domain/app_api.dart';
import 'package:socialnetwork_client/feature/auth/domain/auth_state/auth_cubit.dart';

class AuthInterceptor extends QueuedInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('');
    print('interceptor onRequst call ${options.method} ${options.path}\n');
    print('');
    final accessToken = locator.get<AuthCubit>().state.whenOrNull(
          authorized: (userEntity) => userEntity.accessToken,
        );
    if (accessToken == null) {
      super.onRequest(options, handler);
    } else {
      options.headers['Authorization'] = 'Bearer $accessToken';
      try {
        handler.next(options);
      } catch (e) {
        print('ERROR!!!!');
      }
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('onResponse ${response.statusCode}');
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    print('interceptor onError call');
    if (err.response?.statusCode == 401) {
      try {
        await locator.get<AuthCubit>().refershToken();
        print('interceptor onError refresh token finished');
        final accessToken = locator.get<AuthCubit>().state.whenOrNull(
              authorized: (userEntity) => userEntity.accessToken,
            );
        err.requestOptions.headers['Auhtorization'] = 'Barier $accessToken';
        final request = await locator.get<AppApi>().fetch(err.requestOptions);
        handler.next(request);
      } on DioError catch (e) {
        super.onError(err, handler);
      }
    } else {
      print('onError not 401');
      handler.next(err);
    }
  }
}
