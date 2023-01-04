class LoginResponse {
  String? accessToken;
  int? userId;

  LoginResponse({this.accessToken, this.userId});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['userId'] = this.userId;
    return data;
  }
}