import 'package:flutter/cupertino.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:base_bloc_flutter/utils/extensions/datetime_extension.dart';

import '../../bloc/user_infor_register/user_infor_register_bloc.dart';


class User extends Equatable {
  int? id;
  String? username;
  String? password;
  bool? isActive;
  String? avatar;
  String? name;
  String? gender;
  DateTime? dateOfBirth;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  User(
      {this.id,
      this.username,
      this.password,
      this.isActive,
      this.avatar,
      this.name,
      this.gender,
      this.dateOfBirth,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  String get genderString {
    if(gender == "1"){
      return "Male";
    }
    if(gender == "2"){
      return "Female";
    }
    if(gender == "3"){
      return "Other";
    }
    return '';
  }

  Gender? get genderValue {
    if(gender == "1"){
      return Gender.male;
    }
    if(gender == "2"){
      return Gender.female;
    }
    if(gender == "3"){
      return Gender.other;
    }
    return null;
  }



  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    isActive = json['isActive'];
    avatar = json['avatar'];
    name = json['name'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'] == null
        ? null
        : DateTime.parse(json['dateOfBirth'] as String);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['password'] = password;
    data['isActive'] = isActive;
    data['avatar'] = avatar;
    data['name'] = name;
    data['gender'] = gender;
    data['dateOfBirth'] = dateOfBirth?.dateTimeToDDMMYYYY;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        username,
        password,
        isActive,
        avatar,
        name,
        gender,
        dateOfBirth,
        createdAt,
        updatedAt,
        deletedAt
      ];
}
