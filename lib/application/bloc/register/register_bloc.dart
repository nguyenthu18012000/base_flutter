import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<StartEvent>((event, emit) {});
    on<RegisterButtonPressed>(_onRegisterPhone);
  }

  final phoneNumber = TextEditingController();
  final formRegisterKey = GlobalKey<FormState>();

  Future<void> _onRegisterPhone(
      RegisterButtonPressed event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isLoading: true));
    final phoneNumber = event.phone;
    final currentState = state;

    emit(state.copyWith(isLoading: false, isSuccess: true, phoneNumber: phoneNumber));
  }

}
