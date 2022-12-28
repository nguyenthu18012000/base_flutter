import 'dart:io';
import 'package:base_bloc_flutter/application/presentation/pages/pages.dart';
import 'package:base_bloc_flutter/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_core/flutter_core.dart' as core;

import '../../../../constants/ui_constants.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../utils/image_helper.dart';
import '../../../bloc/user_profile/user_profile_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return core.AppScaffold<ProfileBloc>(
      onReceiveArguments: (data, bloc) {},
      isBack: true,
      onLoadData: (bloc) => bloc?.add,
      body: const ProfileListener(),
    );
  }
}

class ProfileListener extends StatelessWidget {
  const ProfileListener({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    return core.BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        // if (state.imageSourceActionSheetIsVisible) {
        //   _showImageSourceActionSheet(context);
        // }
      },
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            UIConstants.verticalSpace24,
            const AvatarWidget(),
            UIConstants.verticalSpace12,
            const UserNameTileWidget(),
            UIConstants.verticalSpace4,
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    RouteConstants.userProfile,
                  );
                },
                child: const Text("Edit",
                    style: TextStyle(
                        fontSize: 16,
                        color: ColorConstants.gradientTextEdit,
                        fontWeight: FontWeight.w600))),
            const PhoneNumberProfileWidget(),
            const Divider(
              height: 1,
              color: ColorConstants.textBlack3,
            ),
            const DateOfBirthWidget(),
            const Divider(
              height: 1,
              color: ColorConstants.textBlack3,
            ),
            const GenderWidget(),
            const Divider(
              height: 1,
              color: ColorConstants.textBlack3,
            ),
            const LanguageWidget(),
            const ChangePasswordButtonWidget()
          ],
        ),
      ),
    );
  }
}

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocBuilder<ProfileBloc, ProfileState>(buildWhen: (pre, cur) {
      return pre.user.avatarPath != cur.user.avatarPath;
    }, builder: (context, state) {
      final avatarPath = state.user.avatarPath;
      return avatarPath == null
          ? Container(
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
            )
          : CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(avatarPath ?? ''),
            );
    });
  }
}

class UserNameTileWidget extends StatelessWidget {
  const UserNameTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocBuilder<ProfileBloc, ProfileState>(buildWhen: (pre, cur) {
      return pre.user.name != cur.user.name;
    }, builder: (context, state) {
      return Text(
        state.user.name ?? '',
        style: const TextStyle(
            fontSize: 20,
            color: ColorConstants.textBlack,
            fontWeight: FontWeight.w700),
      );
    });
  }
}

class PhoneNumberProfileWidget extends StatelessWidget {
  const PhoneNumberProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocBuilder<ProfileBloc, ProfileState>(buildWhen: (pre, cur) {
      return pre.user.phoneNumber != cur.user.phoneNumber;
    }, builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Phone number",
            style: TextStyle(
                fontSize: 16,
                color: ColorConstants.labelUser,
                fontWeight: FontWeight.w400),
          ),
          Text(
            "${state.user.phoneNumber}",
            style: const TextStyle(
                fontSize: 16,
                color: ColorConstants.textBlack,
                fontWeight: FontWeight.w600),
          ),
        ],
      );
    });
  }
}

class DateOfBirthWidget extends StatelessWidget {
  const DateOfBirthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocBuilder<ProfileBloc, ProfileState>(buildWhen: (pre, cur) {
      return pre.user.dateOfBirth != cur.user.dateOfBirth;
    }, builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Date of Birth",
            style: TextStyle(
                fontSize: 16,
                color: ColorConstants.labelUser,
                fontWeight: FontWeight.w400),
          ),
          Text(
            "${state.user.dateOfBirth}",
            style: const TextStyle(
                fontSize: 16,
                color: ColorConstants.textBlack,
                fontWeight: FontWeight.w600),
          ),
        ],
      );
    });
  }
}

class GenderWidget extends StatelessWidget {
  const GenderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocBuilder<ProfileBloc, ProfileState>(buildWhen: (pre, cur) {
      return pre.user.gender != cur.user.gender;
    }, builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Gender",
            style: TextStyle(
                fontSize: 16,
                color: ColorConstants.labelUser,
                fontWeight: FontWeight.w400),
          ),
          Row(
            children: [
              const Icon(
                Icons.male,
                size: 20,
              ),
              Text(
                "${state.user.gender}",
                style: const TextStyle(
                    fontSize: 16,
                    color: ColorConstants.textBlack,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      );
    });
  }
}

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocBuilder<ProfileBloc, ProfileState>(buildWhen: (pre, cur) {
      return pre.user.language != cur.user.language;
    }, builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Gender",
            style: TextStyle(
                fontSize: 16,
                color: ColorConstants.labelUser,
                fontWeight: FontWeight.w400),
          ),
          Row(
            children: [
              Image.asset(Assets.images.fagForJapan),
              Text(
                "${state.user.language}",
                style: const TextStyle(
                    fontSize: 16,
                    color: ColorConstants.textBlack,
                    fontWeight: FontWeight.w600),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: ColorConstants.gradientRight,
              )
            ],
          ),
        ],
      );
    });
  }
}

class ChangePasswordButtonWidget extends StatelessWidget {
  const ChangePasswordButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          debugPrint('Received click');
        },
        child: const Text('Change Password'),
      ),
    );
  }
}

// void _showImageSourceActionSheet(BuildContext context) {
//   selectImageSource(imageSource) {
//     context.read<ProfileBloc>().add(OpenImagePicker(imageSource: imageSource));
//   }
//
//   if (Platform.isIOS) {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (context) =>
//           CupertinoActionSheet(
//             actions: [
//               CupertinoActionSheetAction(
//                 child: const Text('Camera'),
//                 onPressed: () {
//                   Navigator.pop(context);
//                   selectImageSource(ImageSource.camera);
//                 },
//               ),
//               CupertinoActionSheetAction(
//                 child: const Text('Gallery'),
//                 onPressed: () {
//                   Navigator.pop(context);
//                   selectImageSource(ImageSource.gallery);
//                 },
//               )
//             ],
//           ),
//     );
//   } else {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) =>
//           Wrap(children: [
//             ListTile(
//               leading: const Icon(Icons.camera_alt),
//               title: const Text('Camera'),
//               onTap: () {
//                 Navigator.pop(context);
//                 selectImageSource(ImageSource.camera);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo_album),
//               title: const Text('Gallery'),
//               onTap: () {
//                 Navigator.pop(context);
//                 selectImageSource(ImageSource.gallery);
//               },
//             ),
//           ]),
//     );
//   }
// }
