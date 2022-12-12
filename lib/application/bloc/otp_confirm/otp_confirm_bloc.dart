import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:meta/meta.dart';

part 'otp_confirm_event.dart';

part 'otp_confirm_state.dart';

class OtpConfirmArguments {
  final String phoneNumber;
  final String routeNavigate;
  final void Function()? callback;

  OtpConfirmArguments({
    required this.phoneNumber,
    this.callback,
    required this.routeNavigate,
  });
}

class OtpConfirmBloc extends Bloc<OtpConfirmEvent, OtpConfirmState> {
  OtpConfirmBloc() : super(const OtpConfirmState()) {
    on<OtpConfirmInitial>(_onRequestOtp);
    on<OtpResendEvent>(_onResendOtp);
    on<OtpConfirmPressedEvent>(_onConfirmOtp);
  }

  String otp = '';
  String routeNavigate = '';
  String phoneNumber = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationIDReceived ='';

  Future<void> _onRequestOtp(
      OtpConfirmInitial event, Emitter<OtpConfirmState> emit) async {
    emit(state.copyWith(isLoading: true));
    requestOtp('0868349331');
    emit(state.copyWith(isLoading: false));
    int limitTime = 60;
    for (limitTime; limitTime >= 0; limitTime--) {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(isLoading: false, time: limitTime));
    }
  }

  Future<void> _onResendOtp(
      OtpResendEvent event, Emitter<OtpConfirmState> emit) async {
    emit(state.copyWith(isLoading: true));
    //request otp
    emit(state.copyWith(isLoading: false));
    int limitTime = 60;
    for (limitTime; limitTime >= 0; limitTime--) {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(isLoading: false, time: limitTime));
    }
  }

  Future<void> _onConfirmOtp(
      OtpConfirmPressedEvent event, Emitter<OtpConfirmState> emit) async {
    emit(state.copyWith(isLoading: true));
    final otp = event.otp;
    if (otp.length < 6) {
      emit(state.copyWith(isLoading: false, errMessage: 'error otp'));
    } else {
      // verifyOTP(otp);
      emit(state.copyWith(isLoading: false, isSuccess: true));
    }
  }

  String hiddenPhoneNumber(String phone) {
    int length = phone.length;
    List<String> listNumber = phone.split("");
    for (int i = 0; i < length; i++) {
      if (i != 0 &&
          i != 1 &&
          i != length - 1 &&
          i != length - 2 &&
          i != length - 3) {
        listNumber[i] = "*";
      }
    }
    return listNumber.join("");
  }

  Future<void> requestOtp(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+84 868349331',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential).then((value){
          print('successfully');
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) async {
        verificationIDReceived = verificationId;
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP(String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationIDReceived, smsCode: smsCode);
    await _auth.signInWithCredential(credential).then((value){
      print("You are logged in successfully");
    });
  }
}

