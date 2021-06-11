// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) {
  return Client(
    json['id'] as int,
  )
    ..name = json['name'] as String?
    ..username = json['username'] as String?
    ..email = json['email'] as String?
    ..phone = json['phone'] as String?
    ..website = json['website'] as String?;
}

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'website': instance.website,
    };
