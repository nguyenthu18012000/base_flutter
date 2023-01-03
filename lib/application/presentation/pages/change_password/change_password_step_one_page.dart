import 'package:base_bloc_flutter/application/bloc/change_password/step_two/change_password_step_two_bloc.dart';
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
          UIConstants.verticalSpace44,
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
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: 'Enter your new password',
              prefixIcon: Icon(Icons.lock_outline),
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
