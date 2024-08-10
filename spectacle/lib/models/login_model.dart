class LoginResponseModel {
 // final String token;
  final String error;
  final String role;
  final int id;

  LoginResponseModel({required this.error,required this.role, required this.id });
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      //token: json["token"] != null ? json["token"]: "",
       error: json["error"] ?? "",
       id: json["id"] !=null ? json["id"]: null,
       role: json['role'] ?? "",
       );
  }
}

class LoginRequestModel {
  String email;
  String password; 

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'login': email.trim(),
      'password': password.trim(),
    };
    return map;
  }
}