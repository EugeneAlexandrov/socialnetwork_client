// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_post_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DetailPostStateImpl _$$DetailPostStateImplFromJson(
        Map<String, dynamic> json) =>
    _$DetailPostStateImpl(
      post: json['post'] == null
          ? null
          : PostEntity.fromJson(json['post'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DetailPostStateImplToJson(
        _$DetailPostStateImpl instance) =>
    <String, dynamic>{
      'post': instance.post,
    };
