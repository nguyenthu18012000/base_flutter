import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart' as core;
import 'package:image_picker/image_picker.dart';

import '../../../../constants/constants.dart';
import '../../../../utils/utils.dart';
import '../../../bloc/blocs.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return core.AppScaffold<EditProfileBloc>(
      onReceiveArguments: (data, bloc) {},
      body: const EditProfileListener(),
    );
  }
}

class EditProfileListener extends StatelessWidget {
  const EditProfileListener({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocListener<EditProfileBloc, EditProfileState>(
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
          core.UIHelper.showSnackBar(context, msg: 'ok');
        }
      },
      child: const UserInforView(),
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
          Text("Account Setting",
              style: TextStyle(
                  fontSize: 24,
                  color: ColorConstants.textBlack,
                  fontWeight: FontWeight.w700)),
          UIConstants.verticalSpace44,
          AvatarWidget(),
          UIConstants.verticalSpace12,
          Align(alignment: Alignment.center, child: UserNameTileWidget()),
          UserInformationForm(),
          UIConstants.verticalSpace32,
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
          final bloc = context.read<EditProfileBloc>();
          // if (bloc.enableSubmit()) {
          //   bloc.add(SubmitInforPressedEvent(
          //       name: bloc.name.text,
          //       dateOfBirth: bloc.dateOfBirth.text,
          //       gender: bloc.gender!));
          // }
        },
        child: const Text('Update Profile'));
  }
}

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocBuilder<EditProfileBloc, EditProfileState>(
        buildWhen: (pre, cur) {
      return pre.user?.avatar != cur.user?.avatar;
    }, builder: (context, state) {
      final avatarPath = state.user?.avatar;
      return avatarPath == null
          ? GestureDetector(
              onTap: () async {
                showBottomSheet(context);
                // final ImagePicker picker = ImagePicker();
                // // final XFile? photo =
                // //     await picker.pickImage(source: ImageSource.camera);
                //
                // final XFile? image =
                //     await picker.pickImage(source: ImageSource.gallery);
                //
                // // print(photo.path);
              },
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                width: 100,
                height: 100,
                child: const Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
            )
          : CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(avatarPath ?? ''),
              backgroundColor: Colors.transparent,
            );
    });
  }
}

void showBottomSheet(context) {
  showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withAlpha(60),
      isScrollControlled: true,
      builder: (builder) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState2) {
            return Wrap(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIConstants.verticalSpace36,
                    const Text("Change Avatar",
                        style: TextStyle(
                            fontSize: 20,
                            color: ColorConstants.textBlack,
                            fontWeight: FontWeight.w600)),
                    UIConstants.verticalSpace8,
                    InkWell(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? photo =
                            await picker.pickImage(source: ImageSource.camera);
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: ColorConstants.black, width: 1.0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 18.0),
                        child: const Text(
                          'Camera',
                          style: TextStyle(
                              fontSize: 16, color: ColorConstants.black),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? photo =
                            await picker.pickImage(source: ImageSource.gallery);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 18.0),
                        child: const Text(
                          'Choose from the library',
                          style: TextStyle(
                              fontSize: 16, color: ColorConstants.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]);
          },
        );
      });
}

class UserNameTileWidget extends StatelessWidget {
  const UserNameTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocBuilder<EditProfileBloc, EditProfileState>(
        buildWhen: (pre, cur) {
      return pre.user?.name != cur.user?.name;
    }, builder: (context, state) {
      return Text(
        state.user?.name ?? 'User Name',
        style: const TextStyle(
            fontSize: 20,
            color: ColorConstants.textBlack,
            fontWeight: FontWeight.w700),
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
    final bloc = context.read<EditProfileBloc>();

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
          const Text('Phone number', style: StyleConstants.mediumText),
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
          const Text('Date of birth', style: StyleConstants.mediumText),
          UIConstants.verticalSpace4,
          TextFormField(
            controller: bloc.dateOfBirth,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(
              hintText: 'dd/mm/yyyy',
              suffixIcon: Icon(Icons.calendar_today_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              try {
                final DateTime d =
                    core.DateFormat('dd/mm/yyyy').parseStrict(value);
              } catch (e) {
                return 'date format:dd/mm/yyyy';
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
        ],
      ),
    );
  }
}
