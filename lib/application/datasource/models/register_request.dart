class RegisterRequest {
  String? username;
  String? password;
  String? confirmPassword;
  String? name;
  String? gender;
  String? dateOfBirth;
  String? deviceToken;

  RegisterRequest(
      {this.username,
        this.password,
        this.confirmPassword,
        this.name,
        this.gender,
        this.deviceToken,
        this.dateOfBirth});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    name = json['name'];
    gender = json['gender'];
    deviceToken = json['deviceToken'];
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = username;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    data['name'] = name;
    data['gender'] = gender;
    data['dateOfBirth'] = dateOfBirth;
    data['deviceToken'] = deviceToken;
    return data;
  }
}