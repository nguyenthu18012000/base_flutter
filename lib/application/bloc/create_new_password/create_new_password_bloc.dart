import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

part 'create_new_password_event.dart';

part 'create_new_password_state.dart';

class CreateNewPasswordBloc
    extends Bloc<CreateNewPasswordEvent, CreateNewPasswordState> {
  CreateNewPasswordBloc() : super(const CreateNewPasswordState()) {
    on<CreatePasswordButtonPressed>(_onPress);
  }

  final formCreatePasswordKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();

  Future<void> _onPress(CreatePasswordButtonPressed event,
      Emitter<CreateNewPasswordState> emit) async {
    final password = event.password;

    emit(state.copyWith(isSuccess: true, password: password));
  }
}
