import 'package:json_annotation/json_annotation.dart';

part 'profile_response_model.g.dart';

@JsonSerializable()
class ProfileResponseModel {
  final bool success;
  final String email;

  ProfileResponseModel({
    required this.success,
    required this.email,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) => _$ProfileResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileResponseModelToJson(this);
}
