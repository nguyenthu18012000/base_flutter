import 'package:base_bloc_flutter/constants/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<StartEvent>((event, emit) {});
    on<RegisterButtonPressed>(_onGetEmployees);
  }

  final phoneNumber = TextEditingController();
  final formRegisterKey = GlobalKey<FormState>();

  Future<void> _onGetEmployees(
      RegisterButtonPressed event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isLoading: true));
    final phoneNumber = event.phone;
    final currentState = state;

    emit(state.copyWith(isLoading: false, isSuccess: true, phoneNumber: phoneNumber));
  }

}
