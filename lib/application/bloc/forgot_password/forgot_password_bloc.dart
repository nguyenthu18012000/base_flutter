import 'package:base_bloc_flutter/constants/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:meta/meta.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(const ForgotPasswordState()) {
    on<NewPasswordButtonPressed>(_onSubmitPhoneNumber);
  }

  final phoneNumber = TextEditingController();
  final formForgotPasswordKey = GlobalKey<FormState>();

  Future<void> _onSubmitPhoneNumber(
      NewPasswordButtonPressed event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(isLoading: true));
    final phoneNumber = event.phone;
    final currentState = state;

    emit(state.copyWith(
        isLoading: false, isSuccess: true, phoneNumber: phoneNumber));
  }
}
