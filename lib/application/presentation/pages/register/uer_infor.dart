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
          UIConstants.verticalSpace16,
          ConfirmButton(),
          UIConstants.verticalSpace32,

        ],
      ),
    );
  }
}


class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
        onPressed: () {
          final bloc = context.read<UserInforRegisterBloc>();
        },
        child: const Text('Confirm'));
  }
}


class UserInformationForm extends StatefulWidget {
  const UserInformationForm({super.key});

  @override
  State<UserInformationForm> createState() => _UserInformationFormState();
}

class _UserInformationFormState extends State<UserInformationForm> {
  Gender? gender = Gender.male;
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
                  title: const Text("Male",style: StyleConstants.mediumText),
                  leading: Radio<Gender>(
                    value: Gender.male,
                    groupValue: gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                ),
              ),
              UIConstants.verticalSpace36,
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Female",style: StyleConstants.mediumText),
                  leading: Radio<Gender>(
                    value: Gender.female,
                    groupValue: gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                ),
              ),
              UIConstants.verticalSpace36,
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Other",style: StyleConstants.mediumText),
                  leading: Radio<Gender>(
                    value: Gender.other,
                    groupValue: gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        gender = value;
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

