import 'package:base_bloc_flutter/application/bloc/change_password/step_two/change_password_step_two_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart' as core;

import '../../../../constants/constants.dart';
import '../../../../utils/utils.dart';
import '../../../bloc/blocs.dart';

class ChangePasswordStepTwoPage extends StatelessWidget {
  const ChangePasswordStepTwoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return core.AppScaffold<ChangePasswordStepTwoBloc>(
      onReceiveArguments: (data, bloc) {
        if (data is String) {
          bloc?.currentPassword = data;
          print("$data");
        }
      },
      body: const ChangePasswordStepTwoListener(),
    );
  }
}

class ChangePasswordStepTwoListener extends StatelessWidget {
  const ChangePasswordStepTwoListener({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocListener<ChangePasswordStepTwoBloc,
        ChangePasswordStepTwoState>(
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
      child: const ChangePasswordStepTwoView(),
    );
  }
}

class ChangePasswordStepTwoView extends StatelessWidget {
  const ChangePasswordStepTwoView({
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
          Text('Create new password for your account',
              style: StyleConstants.mediumText),
          UIConstants.verticalSpace32,
          NewPasswordInputForm(),
          UIConstants.verticalSpace44,
          CreateNewPasswordButton(),
          UIConstants.verticalSpace32,
        ],
      ),
    );
  }
}

class CreateNewPasswordButton extends StatelessWidget {
  const CreateNewPasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
        onPressed: () {
          // final bloc = context.read<ChangePasswordStepTwoBloc>();
          // if (bloc.formCreatePasswordKey.currentState!.validate()) {
          //   bloc.add(CreatePasswordButtonPressed(password: bloc.password.text));
          // }
        },
        child: const Text('Create Password'));
  }
}

class NewPasswordInputForm extends StatefulWidget {
  const NewPasswordInputForm({super.key});

  @override
  State<NewPasswordInputForm> createState() => _NewPasswordInputFormState();
}

class _NewPasswordInputFormState extends State<NewPasswordInputForm> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChangePasswordStepTwoBloc>();
    return Form(
      key: bloc.formCreatePasswordKey,
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
          UIConstants.verticalSpace16,
          TextFormField(
            controller: bloc.passwordConfirm,
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: 'Re-enter password',
              prefixIcon: Icon(Icons.lock_outline),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              if (bloc.password.text != bloc.passwordConfirm.text) {
                return "Password not match, please try again.";
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
