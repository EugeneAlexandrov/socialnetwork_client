import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:socialnetwork_client/feature/auth/domain/entities/user_entity.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final dynamic id;
  final dynamic username;
  final dynamic email;
  final dynamic accessToken;
  final dynamic refreshToken;

  UserDto({
    this.id,
    this.username,
    this.email,
    this.accessToken,
    this.refreshToken,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserEntity toUserEntity() {
    return UserEntity(
        email: email.toString(),
        username: username.toString(),
        id: id.toString(),
        accessToken: accessToken.toString(),
        refreshToken: refreshToken.toString());
  }
}
