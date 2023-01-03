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
      body: LoginListener(),
    );
  }
}

class LoginListener extends StatelessWidget {
  const LoginListener({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocListener<LoginBloc, LoginState>(
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
          final bloc = context.read<LoginBloc>();
          Navigator.of(context).pushNamed(
            RouteConstants.userProfile,
            arguments: bloc.userId,
          );
          core.UIHelper.showSnackBar(context, msg: 'success');
        }
      },
      child: const LoginView(),
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
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                RouteConstants.register,
              );
            },
            child: const Text('Register')),
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
          if (bloc.formLoginKey.currentState!.validate()) {
            bloc.add(LoginButtonPressed(
                username: bloc.username.text, password: bloc.password.text));
          }
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
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                RouteConstants.forgotPassword,
              );
            },
            child: const Text('Forgot Password?')),
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
  bool _hideText = true;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return Form(
      key: bloc.formLoginKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            enableSuggestions: false,
            controller: bloc.username,
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
              if(!RegExp(r'^((0[0-9]))\d{8}$').hasMatch(value)){
                return 'Phone error';
              }
              return null;
            },
          ),
          UIConstants.verticalSpace16,
          TextFormField(
            controller: bloc.password,
            obscureText: _hideText,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              prefixIcon: const Icon(
                Icons.password_outlined,
              ),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hideText = !_hideText;
                    });
                  },
                  icon: _hideText
                      ? Icon(Icons.remove_red_eye_outlined)
                      : Icon(Icons.visibility_off_sharp)),
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
