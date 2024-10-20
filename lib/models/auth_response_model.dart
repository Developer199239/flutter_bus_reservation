class AuthResponseModel {
  int statusCode;
  String message;
  String accessToken;
  int loginTime;
  int expirationDuration;
  String role;
  String userId;
  String mobile;

  AuthResponseModel({
    required this.statusCode,
    required this.message,
    required this.accessToken,
    required this.loginTime,
    required this.expirationDuration,
    required this.role,
    required this.userId,
    required this.mobile,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) => AuthResponseModel(
    statusCode: json['statusCode'],
    message: json['message'],
    accessToken: json['accessToken'],
    loginTime: json['loginTime'],
    expirationDuration: json['expirationDuration'],
    role: json['role'],
    userId: json['userId'],
    mobile: json['mobile'],
  );
}
