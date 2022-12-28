import 'package:base_bloc_flutter/application/bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart' as core;

import '../../../constants/constants.dart';
import '../../../utils/utils.dart';

class OtpConfirmPage extends StatelessWidget {
  const OtpConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return core.AppScaffold<OtpConfirmBloc>(
      onReceiveArguments: (data, bloc) {
        if (data is OtpConfirmArguments) {
          bloc?.routeNavigate = data.routeNavigate;
          bloc?.phoneNumber = data.phoneNumber;
          bloc?.callBack = data.callback;
        }
      },
      onLoadData: (bloc) => bloc?.add(OtpConfirmInitial()),
      body: const OtpConfirmListener(),
    );
  }
}

class OtpConfirmListener extends StatelessWidget {
  const OtpConfirmListener({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OtpConfirmBloc>();
    return core.BlocListener<OtpConfirmBloc, OtpConfirmState>(
      listenWhen: (previous, current) {
        return current.errMessage != null ||
            previous.isLoading != current.isLoading ||
            previous.isSuccess != current.isSuccess;
      },
      listener: (context, state) {
        if (state.isLoading) {
          core.UIHelper.showLoading();
        } else {
          core.UIHelper.hideLoading();
        }
        if (state.errMessage != null) {
          core.UIHelper.showSnackBar(context, msg: state.errMessage);
        }
        if (state.isSuccess == true) {
          // Navigator.of(context).pushNamed(bloc.routeNavigate);
          if (bloc.callBack != null) {
            bloc.callBack!(context);
          }
        }
      },
      child: const OtpConfirmView(),
    );
  }
}

class OtpConfirmView extends StatelessWidget {
  const OtpConfirmView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          UIConstants.verticalSpace44,
          Text('Confirmation', style: StyleConstants.overSizeText),
          UIConstants.verticalSpace24,
          PhoneNumberWidget(),
          UIConstants.verticalSpace24,
          OtpWidget(),
          ConfirmButton(),
          UIConstants.verticalSpace32,
          ResendWidget()
        ],
      ),
    );
  }
}

class PhoneNumberWidget extends StatelessWidget {
  const PhoneNumberWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OtpConfirmBloc>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Please enter the OTP has been sent to',
          style: StyleConstants.largeText,
        ),
        TextButton(
            onPressed: () {},
            child: Text(bloc.hiddenPhoneNumber(bloc.phoneNumber))),
      ],
    );
  }
}

class ResendWidget extends StatelessWidget {
  const ResendWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocBuilder<OtpConfirmBloc, OtpConfirmState>(
        buildWhen: (pre, cur) {
      return pre.time != cur.time;
    }, builder: (context, state) {
      final time = state.time;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not received any OTP yet?',
            style: StyleConstants.largeText,
          ),
          InkWell(
              onTap: () {
                final bloc = context.read<OtpConfirmBloc>();
                bloc.add(OtpResendEvent());
              },
              child: Text(
                ' Resend OTP',
                style: time > 0
                    ? const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)
                    : const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
              )),
          // TextButton(
          //     onPressed: () {
          //       final bloc = context.read<OtpConfirmBloc>();
          //       bloc.add(OtpResendEvent());
          //     },
          //     child: const Text('Resend OTP')),
          Text('($time)'),
        ],
      );
    });
  }
}

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          final bloc = context.read<OtpConfirmBloc>();
          bloc.add(OtpConfirmPressedEvent(otp: bloc.otp));
          // Navigator.of(context)
          //     .pushNamed(RouteConstants.createPassword,);
        },
        child: const Text('Confirm'));
  }
}

class OtpWidget extends StatelessWidget {
  const OtpWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OtpConfirmBloc>();
    return Container(
        color: Colors.white,
        width: double.infinity,
        // margin: const EdgeInsets.all(20.0),
        // padding: const EdgeInsets.all(20.0),
        child: core.PinCodeTextField(
          showCursor: false,
          appContext: context,
          pastedTextStyle: TextStyle(
            color: Colors.green.shade600,
            fontWeight: FontWeight.bold,
          ),
          length: 6,
          obscureText: false,
          obscuringCharacter: '*',
          backgroundColor: Colors.white,
          blinkWhenObscuring: true,
          animationType: core.AnimationType.fade,
          validator: (v) {
            // if (v!.length < 6) {
            //   return "I'm from validator";
            // } else {
            //   return null;
            // }
          },
          pinTheme: core.PinTheme(
              shape: core.PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(8),
              fieldHeight: 50,
              fieldWidth: 45.83,
              borderWidth: 0.5,
              selectedColor: Colors.grey,
              activeFillColor: Colors.white,
              inactiveColor: const Color(0xFFE5E8EE)),
          cursorColor: Colors.black,
          animationDuration: const Duration(milliseconds: 300),
          controller: TextEditingController(),
          keyboardType: TextInputType.number,
          onCompleted: (value) {
            bloc.otp = value;
          },
          onChanged: (value) {
            bloc.otp = value;
            if (value.length < 6) {}
          },
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            return true;
          },
        ));
  }
}
