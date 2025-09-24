import 'package:json_annotation/json_annotation.dart';
import 'package:smart_todo/features/auth/domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String uid, email, displayName;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  // Convert UserModel to Entity
  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      email: email,
      displayName: displayName,
    );
  }
}
