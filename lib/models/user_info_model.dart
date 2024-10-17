
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_info_model.freezed.dart';
part 'user_info_model.g.dart';
@unfreezed
class UserInfoModel with _$UserInfoModel{
  factory UserInfoModel({
    required String userName,
    required String password,
    required String role,
    required String customerName,
    required String email,
    required String mobile
}) = _UserInfoModel;
  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);
}
