import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart' as core;


import '../../../../constants/constants.dart';
import '../../../../utils/utils.dart';
import '../../../bloc/blocs.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return core.AppScaffold<RegisterBloc>(
      onLoadData: (bloc) => bloc?.add(StartEvent()),
      body: const RegisterListener(),
    );
  }
}

class RegisterListener extends StatelessWidget {
  const RegisterListener({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocListener<RegisterBloc, RegisterState>(
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
          core.UIHelper.showSnackBar(context, msg: state.errMessage);
        }
        if (state.isSuccess == true) {
          Navigator.of(context).pushNamed(
            RouteConstants.otpConfirm,
            arguments: state.phoneNumber
          );
        }
      },
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          UIConstants.verticalSpace44,
          LogoRegisterWidget(),
          UIConstants.verticalSpace44,
          Text('Register', style: StyleConstants.overSizeText),
          UIConstants.verticalSpace24,
          PhoneInputForm(),
          UIConstants.verticalSpace80,
          RegisterButton(),
          UIConstants.verticalSpace32,
          LoginWidget()
        ],
      ),
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
          style: StyleConstants.largeText,
        ),
        TextButton(onPressed: () {}, child: const Text('Login')),
      ],
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
        onPressed: () {
          final bloc = context.read<RegisterBloc>();
          if (bloc.formRegisterKey.currentState!.validate()) {
            bloc.add(RegisterButtonPressed(phone: bloc.phoneNumber.text));
          }
        },
        child: const Text('Register'));
  }
}

class PhoneInputForm extends StatefulWidget {
  const PhoneInputForm({Key? key}) : super(key: key);

  @override
  State<PhoneInputForm> createState() => _PhoneInputFormState();
}

class _PhoneInputFormState extends State<PhoneInputForm> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterBloc>();
    return Form(
      key: bloc.formRegisterKey,
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
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class LogoRegisterWidget extends StatelessWidget {
  const LogoRegisterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343,
      height: 160,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageHelper.getImage('logo_bg_demo'),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Image.asset(
                ImageHelper.getImage('logo_text_demo'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
