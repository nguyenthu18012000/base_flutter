class RegisterRequest {
  String? username;
  String? password;
  String? confirmPassword;
  String? name;
  String? gender;
  String? dateOfBirth;

  RegisterRequest(
      {this.username,
        this.password,
        this.confirmPassword,
        this.name,
        this.gender,
        this.dateOfBirth});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    return data;
  }
}