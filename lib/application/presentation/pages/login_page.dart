import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart' as core;

import '../../../constants/constants.dart';
import '../../../utils/utils.dart';
import '../../bloc/blocs.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const core.AppScaffold<LoginBloc>(
      body: LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          UIConstants.verticalSpace44,
          LogoWidget(),
          UIConstants.verticalSpace44,
          Text('Login', style: StyleConstants.overSizeText),
          UIConstants.verticalSpace24,
          LoginInputForm(),
          UIConstants.verticalSpace6,
          ForgotPassButton(),
          UIConstants.verticalSpace32,
          LoginButton(),
          UIConstants.verticalSpace32,
          RegisterWidget()
        ],
      ),
    );
  }
}

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Not have an account yet?',
          style: StyleConstants.largeText,
        ),
        TextButton(onPressed: () {}, child: const Text('Register')),
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
        onPressed: () {
          final bloc = context.read<LoginBloc>();
          bloc.formLoginKey.currentState!.validate();
        },
        child: const Text('Login'));
  }
}

class ForgotPassButton extends StatelessWidget {
  const ForgotPassButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        TextButton(onPressed: () {}, child: const Text('Forgot Password?')),
      ],
    );
  }
}

class LoginInputForm extends StatefulWidget {
  const LoginInputForm({super.key});

  @override
  State<LoginInputForm> createState() => _LoginInputFormState();
}

class _LoginInputFormState extends State<LoginInputForm> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return Form(
      key: bloc.formLoginKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: 'Enter your phone number',
              prefixIcon: Icon(Icons.phone_iphone_outlined),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          UIConstants.verticalSpace16,
          TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter your password',
              prefixIcon: Icon(
                Icons.password_outlined,
              ),
              suffixIcon: IconButton(
                  onPressed: null, icon: Icon(Icons.remove_red_eye_outlined)),
            ),
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
    ;
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({
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
