class AuthResponseModel {
  int statusCode;
  String message;
  String accessToken;
  int loginTime;
  int expirationDuration;
  String role;

  AuthResponseModel({
    required this.statusCode,
    required this.message,
    required this.accessToken,
    required this.loginTime,
    required this.expirationDuration,
    required this.role
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) => AuthResponseModel(
    statusCode: json['statusCode'],
    message: json['message'],
    accessToken: json['accessToken'],
    loginTime: json['loginTime'],
    expirationDuration: json['expirationDuration'],
    role: json['role'],
  );
}
