
import 'package:freezed_annotation/freezed_annotation.dart';
part 'sign_up_model.freezed.dart';
part 'sign_up_model.g.dart';
@unfreezed
class SignUpModel with _$SignUpModel{
  factory SignUpModel({
    required String userName,
    required String password,
    required String role,
    required String customerName,
    required String email,
    required String mobile
}) = _SignUpModel;
  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);
}
