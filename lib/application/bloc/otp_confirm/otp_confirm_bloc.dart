import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:meta/meta.dart';

part 'otp_confirm_event.dart';
part 'otp_confirm_state.dart';

class OtpConfirmBloc extends Bloc<OtpConfirmEvent, OtpConfirmState> {
  OtpConfirmBloc() : super(const OtpConfirmState()) {
    on<OtpConfirmInitial>(_onRequestOtp);
    on<OtpResendEvent>(_onResendOtp);
    on<OtpConfirmPressedEvent>(_onConfirmOtp);
  }

  String otp = '';

  late Timer timer;

  Future<void> _onRequestOtp(
      OtpConfirmInitial event, Emitter<OtpConfirmState> emit) async {
    emit(state.copyWith(isLoading: true));
   //request otp
    emit(state.copyWith(isLoading: false));
    // int limitTime = 60;
    // timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
    //   if (limitTime > 0) {
    //      limitTime--;
    //      emit(state.copyWith(isLoading: false, time: limitTime));
    //   } else {
    //     limitTime = -1;
    //     timer.cancel();
    //   }
    // });
  }

  Future<void> _onResendOtp(
      OtpResendEvent event, Emitter<OtpConfirmState> emit) async {
    emit(state.copyWith(isLoading: true));
    //request otp
    emit(state.copyWith(isLoading: false));
    // int limitTime = 60;
    // timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
    //   if (limitTime > 0) {
    //     limitTime--;
    //     emit(state.copyWith(isLoading: false, time: limitTime));
    //   } else {
    //     limitTime = -1;
    //     timer.cancel();
    //   }
    // });
  }

  Future<void> _onConfirmOtp(
      OtpConfirmPressedEvent event, Emitter<OtpConfirmState> emit) async {
    emit(state.copyWith(isLoading: true));
    final otp = event.otp;
   if(otp.length<6){
     emit(state.copyWith(isLoading: false, errMessage: 'error otp'));
   }else{

     emit(state.copyWith(isLoading: false, isSuccess: true));
   }

  }



}
