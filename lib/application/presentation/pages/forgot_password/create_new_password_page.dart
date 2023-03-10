import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart' as core;

import '../../../../constants/constants.dart';
import '../../../../utils/utils.dart';
import '../../../bloc/blocs.dart';
import '../../widgets/widgets.dart';

class CreateNewPasswordPage extends StatelessWidget {
  const CreateNewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return core.AppScaffold<CreateNewPasswordBloc>(
      onReceiveArguments: (data, bloc) {
        if (data is String) {
          bloc?.phoneNumber = data;
        }
      },
      body: const CreateNewPasswordListener(),
    );
  }
}

class CreateNewPasswordListener extends StatelessWidget {
  const CreateNewPasswordListener({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocListener<CreateNewPasswordBloc, CreateNewPasswordState>(
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
          core.UIHelper.showSnackBar(context, msg: 'Change success');
          // Navigator.of(context)
          //     .popUntil(ModalRoute.withName(RouteConstants.login));
          Navigator.of(context).pushNamedAndRemoveUntil(
            RouteConstants.login,
            ModalRoute.withName(RouteConstants.login),
          );
        }
      },
      child: const CreateNewPasswordView(),
    );
  }
}

class CreateNewPasswordView extends StatelessWidget {
  const CreateNewPasswordView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          UIConstants.verticalSpace44,
          Text('Create New Password', style: StyleConstants.hugeText),
          UIConstants.verticalSpace44,
          Text('Please create new password for your account',
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
          final bloc = context.read<CreateNewPasswordBloc>();
          FocusScope.of(context).unfocus();
          if (bloc.formCreatePasswordKey.currentState!.validate()) {
            bloc.add(CreatePasswordButtonPressed(
               // password: bloc.password.text
            ));
          }
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
  bool _hidePassword = true;
  bool _hidePasswordConfirm = true;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateNewPasswordBloc>();
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
