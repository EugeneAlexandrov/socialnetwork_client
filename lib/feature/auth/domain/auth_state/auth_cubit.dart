import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:socialnetwork_client/feature/auth/domain/auth_repository.dart';
import 'package:socialnetwork_client/feature/auth/domain/entities/user_entity.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';
part 'auth_cubit.g.dart';

@Singleton()
class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState.notAuthorized());

  final AuthRepository authRepository;

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    emit(AuthState.waiting());
    try {
      final UserEntity user =
          await authRepository.signIn(password: password, username: username);
      emit(AuthState.authorized(user));
    } catch (error, stackTrace) {
      print('Cubit signIn catch exception');
      addError(error, stackTrace);
      //rethrow;
    }
  }

  Future<void> signUp({
    required String username,
    required String password,
    required String email,
  }) async {
    emit(AuthState.waiting());
    try {
      final UserEntity user = await authRepository.signUp(
          password: password, username: username, email: email);
      emit(AuthState.authorized(user));
    } catch (error, stackTrace) {
      print('Cubit SignUp catch exception');
      addError(error, stackTrace);
    }
  }

  Future<void> getProfile() async {
    try {
      _updateUserState(const AsyncSnapshot.waiting());
      final UserEntity user = await authRepository.getProfile();
      emit(
        state.maybeWhen(
          orElse: () => state,
          authorized: (userEntity) => AuthState.authorized(
            userEntity.copyWith(email: user.email, username: user.username),
          ),
        ),
      );
      _updateUserState(const AsyncSnapshot.withData(
          ConnectionState.done, 'успешное получение данных'));
    } catch (error) {
      print('Cubit getProfile catch exception');
      _updateUserState(AsyncSnapshot.withError(ConnectionState.done, error));
    }
  }

  void logOut() => emit(AuthState.notAuthorized());

  Future<void> refreshToken() async {
    final refreshToken = state.whenOrNull(
      authorized: (userEntity) => userEntity.refreshToken,
    );
    try {
      final UserEntity updatedUserEntity =
          await authRepository.refreshToken(refreshToken: refreshToken);
      //emit(AuthState.authorized(userEntity));
      emit(state.maybeWhen(
          orElse: () => state,
          authorized: (userEntity) => AuthState.authorized(userEntity.copyWith(
              refreshToken: updatedUserEntity.refreshToken,
              accessToken: updatedUserEntity.accessToken))));
      print('Cubit refreshToken finished');
    } catch (error, stackTrace) {
      print('Cubit refreshToken catch exception');
      addError(error, stackTrace);
    }
  }

  Future<void> updateProfile({String? username, String? email}) async {
    try {
      _updateUserState(const AsyncSnapshot.waiting());
      final UserEntity user =
          await authRepository.updateProfile(username: username, email: email);
      emit(
        state.maybeWhen(
          orElse: () => state,
          authorized: (userEntity) => AuthState.authorized(
            userEntity.copyWith(email: user.email, username: user.username),
          ),
        ),
      );
      _updateUserState(const AsyncSnapshot.withData(
          ConnectionState.done, 'успешное изменение профиля'));
    } catch (error) {
      print('Cubit ApdateProfile catch exception');
      _updateUserState(AsyncSnapshot.withError(ConnectionState.done, error));
    }
  }

  void _updateUserState(AsyncSnapshot userState) {
    emit(state.maybeWhen(
      orElse: () => state,
      authorized: (userEntity) {
        return AuthState.authorized(
          userEntity.copyWith(userState: userState),
        );
      },
    ));
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    final state = AuthState.fromJson(json);
    return state.whenOrNull(
      authorized: (userEntity) => AuthState.authorized(userEntity),
    );
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state
            .whenOrNull(
              authorized: (userEntity) => AuthState.authorized(userEntity),
            )
            ?.toJson() ??
        AuthState.notAuthorized().toJson();
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    emit(AuthState.error(error));
    super.addError(error, stackTrace);
  }
}
