import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'user_infor_register_event.dart';
part 'user_infor_register_state.dart';

enum Gender { male, female,other }

class UserInforRegisterBloc extends Bloc<UserInforRegisterEvent, UserInforRegisterState> {
  UserInforRegisterBloc() : super(UserInforRegisterInitial()) {
    on<UserInforRegisterEvent>((event, emit) {});
  }

  final formUserKey = GlobalKey<FormState>();
}
