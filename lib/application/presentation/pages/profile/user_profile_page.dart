import 'package:base_bloc_flutter/constants/constants.dart';
import 'package:base_bloc_flutter/utils/extensions/datetime_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/flutter_core.dart' as core;

import '../../../../utils/app_button.dart';
import '../../../bloc/user_profile/user_profile_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return core.AppScaffold<ProfileBloc>(
      onReceiveArguments: (data, bloc) {
        if (data is String) {
          bloc?.userID = data;
        }
      },
      onLoadData: (bloc) => bloc?.add(GetUserProfileEvent()),
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
    return core.BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) {
        return current.errMessage != null ||
            previous.isLoading != current.isLoading;
      },
      listener: (context, state) {
        if (state.isLoading) {
          UIHelper.showLoading();
        } else {
          UIHelper.hideLoading();
        }
        if (state.errMessage != null) {
          UIHelper.showSnackBar(context, msg: state.errMessage);
        }
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
                Expanded(flex: 1, child: NotificationButtonWidget())
              ],
            ),
            UIConstants.verticalSpace24,
            const AvatarWidget(),
            UIConstants.verticalSpace12,
            const UserNameTileWidget(),
            UIConstants.verticalSpace4,
            const EditUserProfileButton(),
            UIConstants.verticalSpace44,
            const PhoneNumberProfileWidget(),
            UIConstants.verticalSpace16,
            const Divider(
              height: 1,
              color: ColorConstants.textBlack3,
            ),
            UIConstants.verticalSpace16,
            const DateOfBirthWidget(),
            UIConstants.verticalSpace16,
            const Divider(
              height: 1,
              color: ColorConstants.textBlack3,
            ),
            UIConstants.verticalSpace16,
            const GenderWidget(),
            UIConstants.verticalSpace16,
            const Divider(
              height: 1,
              color: ColorConstants.textBlack3,
            ),
            UIConstants.verticalSpace16,
            const LanguageWidget(),
            UIConstants.verticalSpace44,
            const ChangePasswordButtonWidget(),
            UIConstants.verticalSpace16,
            const LogoutButtonWidget(),
          ],
        ),
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

class NotificationButtonWidget extends StatelessWidget {
  const NotificationButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notifications),
      onPressed: () {
        // Navigator.pop(context);
      },
    );
  }
}

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocBuilder<ProfileBloc, ProfileState>(buildWhen: (pre, cur) {
      return pre.user?.avatar != cur.user?.avatar;
    }, builder: (context, state) {
      final avatarPath = state.user?.avatar;
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
              backgroundImage: NetworkImage(avatarPath),
              backgroundColor: Colors.transparent,
            );
    });
  }
}

class EditUserProfileButton extends StatelessWidget {
  const EditUserProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    return core.BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
      return TextButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamed(RouteConstants.editProfile, arguments: state.user)
                .then((value) => bloc.add(GetUserProfileEvent()));
          },
          child: const Text("Edit",
              style: TextStyle(
                  fontSize: 16,
                  color: ColorConstants.gradientTextEdit,
                  fontWeight: FontWeight.w600)));
    });
  }
}

class UserNameTileWidget extends StatelessWidget {
  const UserNameTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocBuilder<ProfileBloc, ProfileState>(buildWhen: (pre, cur) {
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

class PhoneNumberProfileWidget extends StatelessWidget {
  const PhoneNumberProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return core.BlocBuilder<ProfileBloc, ProfileState>(buildWhen: (pre, cur) {
      return pre.user?.username != cur.user?.username;
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
            state.user?.username ?? "",
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
      return pre.user?.dateOfBirth != cur.user?.dateOfBirth;
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
            state.user?.dateOfBirth?.dateTimeToYYYYMMDD ?? '',
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
      return pre.user?.gender != cur.user?.gender;
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
                state.user?.genderString ?? '',
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
    // return core.BlocBuilder<ProfileBloc, ProfileState>(buildWhen: (pre, cur) {
    // return pre.user?.language != cur.user?.language;
    // }, builder: (context, state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Language",
          style: TextStyle(
              fontSize: 16,
              color: ColorConstants.labelUser,
              fontWeight: FontWeight.w400),
        ),
        Row(
          children: const [
            // Image.asset(Assets.images.fagForJapan),
            Text(
              "Japan",
              style: TextStyle(
                  fontSize: 16,
                  color: ColorConstants.textBlack,
                  fontWeight: FontWeight.w600),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorConstants.gradientRight,
              size: 14.0,
            )
          ],
        ),
      ],
    );
    // });
  }
}

class ChangePasswordButtonWidget extends StatelessWidget {
  const ChangePasswordButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
        onPressed: () {
          final bloc = context.read<ProfileBloc>();
          Navigator.of(context).pushNamed(RouteConstants.changePasswordStepOne,
              arguments: bloc.password);
        },
        child: const Text('Change Password'));
  }
}

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientButton(
        onPressed: () {
          final bloc = context.read<ProfileBloc>();
          Navigator.of(context).pushNamedAndRemoveUntil(
            RouteConstants.login,
            ModalRoute.withName(RouteConstants.login),
          );
          bloc.logout();
        },
        child: const Text('Logout'));
  }
}
