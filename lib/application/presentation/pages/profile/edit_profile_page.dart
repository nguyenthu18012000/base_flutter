import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart' as core;
import 'package:image_picker/image_picker.dart';
import 'package:base_bloc_flutter/utils/extensions/datetime_extension.dart';

import '../../../../constants/constants.dart';
import '../../../../utils/utils.dart';
import '../../../bloc/blocs.dart';
import '../../../datasource/models/user.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return core.AppScaffold<EditProfileBloc>(
      onReceiveArguments: (data, bloc) {
        if (data is User) {
          // bloc?.user = data;
          bloc?.updateUserProfile(data);
        }
      },
      onLoadData: (bloc) => bloc?.add(FillEditProfileEvent()),
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
          Navigator.pop(context);
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
        children:  [
          UIConstants.verticalSpace30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(flex: 1, child: IconButtonWidget()),
              Expanded(
                flex: 8,
                child: Text("Account Setting",
                    style: TextStyle(
                        fontSize: 24,
                        color: ColorConstants.textBlack,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          UIConstants.verticalSpace44,
          const AvatarWidget(),
          UIConstants.verticalSpace12,
          const Align(alignment: Alignment.center, child: UserNameTileWidget()),
          UIConstants.verticalSpace32,
          const UserInformationForm(),
          UIConstants.verticalSpace32,
          const ConfirmInforButton(),
          UIConstants.verticalSpace32,
        ],
      ),
    );
  }
}

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
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
          bloc.add(SubmitProfileEvent(bloc.user));
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
                _showImageSourceActionSheet(context);
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
          : GestureDetector(
              onTap: () async {
                _showImageSourceActionSheet(context);
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(avatarPath ?? ''),
                backgroundColor: Colors.transparent,
              ),
            );
    });
  }
}

void _showImageSourceActionSheet(BuildContext context) {
  selectImageSource(imageSource) {
    context
        .read<EditProfileBloc>()
        .add(OpenImagePicker(imageSource: imageSource));
  }

  if (Platform.isIOS) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? photo =
                  await picker.pickImage(source: ImageSource.camera);
              selectImageSource(photo?.path);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Choose from the library'),
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
              selectImageSource(image?.path);
            },
          )
        ],
      ),
    );
  } else {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(children: [
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Camera'),
          onTap: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? photo =
                await picker.pickImage(source: ImageSource.camera);
            selectImageSource(photo?.path);
          },
        ),
        ListTile(
          leading: const Icon(Icons.photo_album),
          title: const Text('Choose from the library'),
          onTap: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image =
                await picker.pickImage(source: ImageSource.gallery);
            selectImageSource(image?.path);
          },
        ),
      ]),
    );
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
    return core.BlocBuilder<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
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
              controller: bloc.userName,
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
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    locale: const Locale('en'),
                    firstDate: DateTime(1950),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime.now());

                if (pickedDate != null) {
                  String formattedDate =
                  core.DateFormat('dd/MM/yyyy').format(pickedDate);
                  setState(() {
                    bloc.dateOfBirth.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {
                }
              },
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
                    title:
                        const Text("Female", style: StyleConstants.mediumText),
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
                    title:
                        const Text("Other", style: StyleConstants.mediumText),
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
    });
  }
}
