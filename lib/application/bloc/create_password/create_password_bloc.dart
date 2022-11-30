import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:meta/meta.dart';

part 'create_password_event.dart';
part 'create_password_state.dart';

class CreatePasswordBloc extends Bloc<CreatePasswordEvent, CreatePasswordState> {
  CreatePasswordBloc() : super(const CreatePasswordState()) {
    on<CreatePasswordInitial>((event, emit) {});
    on<CreateButtonPressed>(_onPress);
  }

  final formCreatePasswordKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();

  Future<void> _onPress(
      CreateButtonPressed event, Emitter<CreatePasswordState> emit) async {
    final password = event.password;
   // final passwordConfirm = event.confirmPassword;
    print(password);


    emit(state.copyWith( isSuccess: true, password: password));
  }
}
