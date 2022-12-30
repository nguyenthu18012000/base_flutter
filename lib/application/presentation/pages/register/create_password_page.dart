import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart' as core;

import '../../../../constants/constants.dart';
import '../../../../utils/utils.dart';
import '../../../bloc/blocs.dart';
import '../../widgets/widgets.dart';

class CreatePasswordPage extends StatelessWidget {
  const CreatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return core.AppScaffold<CreatePasswordBloc>(
      onReceiveArguments: (data, bloc) {
        if (data is String) {
          bloc?.phoneNumber = data;
        }
      },
      onLoadData: (bloc) => bloc?.add(CreatePasswordInitial()),
      body: const CreatePasswordListener(),
    );
  }
}

class CreatePasswordListener extends StatelessWidget {
  const CreatePasswordListener({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocListener<CreatePasswordBloc, CreatePasswordState>(
      listenWhen: (previous, current) {
        return current.errMessage != null ||
            previous.isSuccess != current.isSuccess;
      },
      listener: (context, state) {
        if (state.errMessage != null) {
          core.UIHelper.showSnackBar(context, msg: state.errMessage);
        }
        if (state.isSuccess == true) {
          final bloc = context.read<CreatePasswordBloc>();
          Navigator.of(context).pushNamed(RouteConstants.userInforRegister,
              arguments: UserInforRegisterArguments(
                  phoneNumber: bloc.phoneNumber,
                  password: state?.password ?? ''));
        }
      },
      child: const CreatePasswordView(),
    );
  }
}

class CreatePasswordView extends StatelessWidget {
  const CreatePasswordView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          UIConstants.verticalSpace44,
          Text('Create Password', style: StyleConstants.hugeText),
          UIConstants.verticalSpace44,
          Text('Please create a password for your account',
              style: StyleConstants.mediumText),
          UIConstants.verticalSpace32,
          PasswordInputForm(),
          UIConstants.verticalSpace44,
          CreatePasswordButton(),
          UIConstants.verticalSpace32,
        ],
      ),
    );
  }
}

class CreatePasswordButton extends StatelessWidget {
  const CreatePasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
        onPressed: () {
          final bloc = context.read<CreatePasswordBloc>();
          if (bloc.formCreatePasswordKey.currentState!.validate()) {
            bloc.add(CreateButtonPressed(password: bloc.password.text));
          }
        },
        child: const Text('Create Password'));
  }
}

class PasswordInputForm extends StatefulWidget {
  const PasswordInputForm({super.key});

  @override
  State<PasswordInputForm> createState() => _PasswordInputFormState();
}

class _PasswordInputFormState extends State<PasswordInputForm> {
  bool _hidePassword = true;
  bool _hidePasswordConfirm = true;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreatePasswordBloc>();
    return Form(
      key: bloc.formCreatePasswordKey,
      child: Column(
        children: <Widget>[
          TextFieldPassword(
            controller: bloc.password,
            hintText: 'Enter your password..',
            textInputType: TextInputType.text,
            validator: (value){
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          UIConstants.verticalSpace16,
          TextFieldPassword(
            controller: bloc.passwordConfirm,
            hintText:  'Re-enter password',
            textInputType: TextInputType.text,
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
          // TextFormField(
          //   controller: bloc.password,
          //   enableSuggestions: false,
          //   autocorrect: false,
          //   obscureText: _hidePassword,
          //   keyboardType: TextInputType.text,
          //   decoration: InputDecoration(
          //     hintText: 'Enter your new password',
          //     prefixIcon: Icon(Icons.lock_outline),
          //     suffixIcon: IconButton(
          //         onPressed: () {
          //           setState(() {
          //             _hidePassword = !_hidePassword;
          //           });
          //         },
          //         icon: _hidePassword
          //             ? Icon(Icons.remove_red_eye_outlined)
          //             : Icon(Icons.visibility_off_sharp)),
          //   ),
          //   // The validator receives the text that the user has entered.
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please enter some text';
          //     }
          //     return null;
          //   },
          // ),
          // UIConstants.verticalSpace16,
          // TextFormField(
          //   controller: bloc.passwordConfirm,
          //   enableSuggestions: false,
          //   autocorrect: false,
          //   obscureText: _hidePasswordConfirm,
          //   keyboardType: TextInputType.text,
          //   decoration: InputDecoration(
          //     hintText: 'Re-enter password',
          //     prefixIcon: Icon(Icons.lock_outline),
          //     suffixIcon: IconButton(
          //         onPressed: () {
          //           setState(() {
          //             _hidePasswordConfirm = !_hidePasswordConfirm;
          //           });
          //         },
          //         icon: _hidePasswordConfirm
          //             ? Icon(Icons.remove_red_eye_outlined)
          //             : Icon(Icons.visibility_off_sharp)),
          //   ),
          //   // The validator receives the text that the user has entered.
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please enter some text';
          //     }
          //     if (bloc.password.text != bloc.passwordConfirm.text) {
          //       return "Password not match, please try again.";
          //     }
          //     return null;
          //   },
          // ),
        ],
      ),
    );
    ;
  }
}
