import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart' as core;

import '../../../../constants/constants.dart';
import '../../../../utils/utils.dart';
import '../../../bloc/blocs.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const core.AppScaffold<ForgotPasswordBloc>(
      body: ForgotPasswordListener(),
    );
  }
}

class ForgotPasswordListener extends StatelessWidget {
  const ForgotPasswordListener({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listenWhen: (previous, current) {
        return current.errMessage != null ||
            previous.isLoading != current.isLoading;
      },
      listener: (context, state) {
        if (state.isLoading) {
          core.UIHelper.showLoading();
        } else {
          core.UIHelper.hideLoading();
        }
        if (state.errMessage != null) {
          //core.UIHelper.showSnackBar(context, msg: state.errMessage);
          DialogService.errorDialog(context,
              title: 'Error',
              message: state.errMessage
          );
        }
        if (state.isSuccess == true) {
          Navigator.of(context).pushNamed(RouteConstants.otpConfirm,
              arguments: OtpConfirmArguments(
                phoneNumber: state.phoneNumber ?? '',
                routeNavigate: RouteConstants.createNewPassword,
                callback: (ct) {
                  Navigator.of(ct).pushNamed(
                    RouteConstants.createNewPassword,
                    arguments:state.phoneNumber,
                  );
                },
              ));
        }
      },
      child: const ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          UIConstants.verticalSpace44,
          Text('Forgot Password', style: StyleConstants.hugeText),
          UIConstants.verticalSpace44,
          Text('Please enter your Phone number',
              style: StyleConstants.mediumText),
          UIConstants.verticalSpace32,
          ForgotPasswordPhoneInput(),
          UIConstants.verticalSpace80,
          NextButton(),
          UIConstants.verticalSpace32,
        ],
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
        onPressed: () {
          final bloc = context.read<ForgotPasswordBloc>();
          if (bloc.formForgotPasswordKey.currentState!.validate()) {
            bloc.add(NewPasswordButtonPressed(phone: bloc.phoneNumber.text));
          }
        },
        child: const Text('Next'));
  }
}

class ForgotPasswordPhoneInput extends StatefulWidget {
  const ForgotPasswordPhoneInput({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPhoneInput> createState() =>
      _ForgotPasswordPhoneInputState();
}

class _ForgotPasswordPhoneInputState extends State<ForgotPasswordPhoneInput> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ForgotPasswordBloc>();
    return Form(
      key: bloc.formForgotPasswordKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: bloc.phoneNumber,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: 'Enter your phone number',
              prefixIcon: Icon(Icons.local_phone_outlined),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              if(!RegExp(r'^((0[0-9]))\d{8}$').hasMatch(value)){
                return 'Phone error';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
