import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart' as core;

import '../../../../constants/constants.dart';
import '../../../../utils/utils.dart';
import '../../../bloc/blocs.dart';

class ChangePasswordStepOnePage extends StatelessWidget {
  const ChangePasswordStepOnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return core.AppScaffold<ChangePasswordStepOneBloc>(
      onReceiveArguments: (data, bloc) {
        if (data is String) {
          bloc?.currentPassword = data;
        }
      },
      body: const ChangePasswordStepOneListener(),
    );
  }
}

class ChangePasswordStepOneListener extends StatelessWidget {
  const ChangePasswordStepOneListener({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocListener<ChangePasswordStepOneBloc, ChangePasswordStepOneState>(
      listener: (context, state) {
        if (state.errMessage != null) {
          core.UIHelper.showSnackBar(context, msg: state.errMessage);
        }
        if (state.isSuccess == true) {
          core.UIHelper.showSnackBar(context, msg: 'Change success');
          // Navigator.of(context)
          //     .popUntil(ModalRoute.withName(RouteConstants.login));
        }
      },
      child: const ChangePasswordStepOneView(),
    );
  }
}

class ChangePasswordStepOneView extends StatelessWidget {
  const ChangePasswordStepOneView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          UIConstants.verticalSpace30,
          Text('Change Password', style: StyleConstants.hugeText),
          UIConstants.verticalSpace44,
          Text('Please re-enter your password first',
              style: StyleConstants.mediumText),
          UIConstants.verticalSpace32,
          CurrentPasswordInputForm(),
          UIConstants.verticalSpace44,
          NextToStepTwoButton(),
          UIConstants.verticalSpace32,
        ],
      ),
    );
  }
}

class NextToStepTwoButton extends StatelessWidget {
  const NextToStepTwoButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
        onPressed: () {
          final bloc = context.read<ChangePasswordStepOneBloc>();
          Navigator.of(context).pushNamed(
            RouteConstants.changePasswordStepTwo,
            arguments: bloc.password.text,
          );
        },
        child: const Text('Next'));
  }
}

class CurrentPasswordInputForm extends StatefulWidget {
  const CurrentPasswordInputForm({super.key});

  @override
  State<CurrentPasswordInputForm> createState() => _CurrentPasswordInputFormState();
}

class _CurrentPasswordInputFormState extends State<CurrentPasswordInputForm> {
  bool _hideText = true;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChangePasswordStepOneBloc>();
    return Form(
      key: bloc.formCurrentPasswordKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: bloc.password,
            enableSuggestions: false,
            autocorrect: false,
            obscureText: _hideText,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Enter your current password',
              prefixIcon: const Icon(
                Icons.lock_outline,
              ),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hideText = !_hideText;
                    });
                  },
                  icon: _hideText
                      ? const Icon(Icons.remove_red_eye_outlined)
                      : const Icon(Icons.visibility_off_sharp)),
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
    ;
  }
}
