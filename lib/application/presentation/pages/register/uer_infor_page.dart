import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart' as core;

import '../../../../constants/constants.dart';
import '../../../../utils/utils.dart';
import '../../../bloc/blocs.dart';

class UserInforPage extends StatelessWidget {
  const UserInforPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const core.AppScaffold<UserInforRegisterBloc>(
      body: UserInforView(),
    );
  }
}

class UserInforView extends StatelessWidget {
  const UserInforView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          UIConstants.verticalSpace44,
          Text('User information', style: StyleConstants.hugeText),
          UIConstants.verticalSpace44,
          UserInformationForm(),
          UIConstants.verticalSpace32,
          PrivacyCheck(),
          UIConstants.verticalSpace16,
          ConfirmInforButton(),
          UIConstants.verticalSpace32,
        ],
      ),
    );
  }
}

class ConfirmInforButton extends StatelessWidget {
  const ConfirmInforButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
        onPressed: () {
          final bloc = context.read<UserInforRegisterBloc>();
          if (bloc.enableSubmit()) {
            bloc.add(SubmitInforPressedEvent(
                name: bloc.name.text,
                dateOfBirth: bloc.dateOfBirth.text,
                gender: bloc.gender!));
          }
        },
        child: const Text('Confirm'));
  }
}

class PrivacyCheck extends StatelessWidget {
  const PrivacyCheck({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserInforRegisterBloc>();
    return core.BlocBuilder<UserInforRegisterBloc, UserInforRegisterState>(
        buildWhen: (pre, cur) {
      return pre.isReadPrivacy != cur.isReadPrivacy;
    }, builder: (context, state) {
      return Row(
        children: [
          InkWell(
            onTap: () {
              bloc.add(CheckPrivacyEvent(isChecked: !bloc.isReadPrivacy));
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                state.isReadPrivacy
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: Colors.blue,
                size: 28.0,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'I agree with the ',
                      style: StyleConstants.mediumText
                          .copyWith(color: Colors.black)),
                  TextSpan(
                      text: 'Terms of services',
                      style: StyleConstants.mediumText
                          .copyWith(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                        }),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class UserInformationForm extends StatefulWidget {
  const UserInformationForm({super.key});

  @override
  State<UserInformationForm> createState() => _UserInformationFormState();
}

class _UserInformationFormState extends State<UserInformationForm> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserInforRegisterBloc>();

    return Form(
      key: bloc.formUserKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Name', style: StyleConstants.mediumText),
          UIConstants.verticalSpace4,
          TextFormField(
            controller: bloc.name,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: 'Enter your name',
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
          const Text('Gender', style: StyleConstants.mediumText),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Male", style: StyleConstants.mediumText),
                  leading: Radio<Gender>(
                    value: Gender.male,
                    groupValue: bloc.gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        bloc.gender = value;
                      });
                    },
                  ),
                ),
              ),
              UIConstants.verticalSpace36,
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Female", style: StyleConstants.mediumText),
                  leading: Radio<Gender>(
                    value: Gender.female,
                    groupValue: bloc.gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        bloc.gender = value;
                      });
                    },
                  ),
                ),
              ),
              UIConstants.verticalSpace36,
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Other", style: StyleConstants.mediumText),
                  leading: Radio<Gender>(
                    value: Gender.other,
                    groupValue: bloc.gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        bloc.gender = value;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          const Text('Date of birth', style: StyleConstants.mediumText),
          UIConstants.verticalSpace16,
          TextFormField(
            controller: bloc.dateOfBirth,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(
              hintText: 'yyyy/mm/dd',
              suffixIcon: Icon(Icons.calendar_today_outlined),
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
