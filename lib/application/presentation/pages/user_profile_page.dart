import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/user_profile/user_profile_bloc.dart';
import '../../bloc/user_profile/user_profile_event.dart';
import '../../bloc/user_profile/user_profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<SessionCubit>();
    return BlocProvider(
      create: (context) => ProfileBloc(
        dataRepo: context.read<DataRepository>(),
        storageRepo: context.read<StorageRepository>(),
        user: sessionCubit.selectedUser ?? sessionCubit.currentUser,
        isCurrentUser: sessionCubit.isCurrentUserSelected,
      ),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.imageSourceActionSheetIsVisible) {
            _showImageSourceActionSheet(context);
          }
        },
        child: Scaffold(
          backgroundColor: Color(0xFFF2F2F7),
          appBar: _appBar(),
          body: _profilePage(),
        ),
      ),
    );
  }

  Widget _appBar() {
    final appBarHeight = AppBar().preferredSize.height;
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        return AppBar(
          title: const Text('Profile'),
          actions: [
            if (state.isCurrentUser)
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
          ],
        );
      }),
    );
  }

  Widget _profilePage() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              _avatar(),
              if (state.isCurrentUser) _changeAvatarButton(),
              const SizedBox(height: 30),
              _usernameTile(),
              _emailTile(),
              _descriptionTile(),
              if (state.isCurrentUser) _saveProfileChangesButton(),
            ],
          ),
        ),
      );
    });
  }

  Widget _avatar() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return state.avatarPath == null
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
        backgroundImage: NetworkImage(state.avatarPath),
      );
    });
  }

  Widget _changeAvatarButton() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return TextButton(
        onPressed: () => context.read<ProfileBloc>().add(ChangeAvatarRequest()),
        child: const Text('Change Avatar'),
      );
    });
  }

  Widget _usernameTile() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return ListTile(
        tileColor: Colors.white,
        leading: const Icon(Icons.person),
        title: Text(state.username),
      );
    });
  }

  Widget _emailTile() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return ListTile(
        tileColor: Colors.white,
        leading: const Icon(Icons.mail),
        title: Text(state.email),
      );
    });
  }

  Widget _descriptionTile() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return ListTile(
        tileColor: Colors.white,
        leading: const Icon(Icons.edit),
        title: TextFormField(
          initialValue: state.userDescription,
          decoration: InputDecoration.collapsed(
              hintText: state.isCurrentUser
                  ? 'Say something about yourself'
                  : 'This user hasn\'t updated their profile'),
          maxLines: null,
          readOnly: !state.isCurrentUser,
          toolbarOptions: ToolbarOptions(
            copy: state.isCurrentUser,
            cut: state.isCurrentUser,
            paste: state.isCurrentUser,
            selectAll: state.isCurrentUser,
          ),
          onChanged: (value) => context
              .read<ProfileBloc>()
              .add(ProfileDescriptionChanged(description: value)),
        ),
      );
    });
  }

  Widget _saveProfileChangesButton() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return ElevatedButton(
        onPressed: () {},
        child: const Text('Save Changes'),
      );
    });
  }

  void _showImageSourceActionSheet(BuildContext context) {
    selectImageSource(imageSource) {
      context
          .read<ProfileBloc>()
          .add(OpenImagePicker(imageSource: imageSource));
    }

    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: const Text('Camera'),
              onPressed: () {
                Navigator.pop(context);
                selectImageSource(ImageSource.camera);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Gallery'),
              onPressed: () {
                Navigator.pop(context);
                selectImageSource(ImageSource.gallery);
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
            onTap: () {
              Navigator.pop(context);
              selectImageSource(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_album),
            title: const Text('Gallery'),
            onTap: () {
              Navigator.pop(context);
              selectImageSource(ImageSource.gallery);
            },
          ),
        ]),
      );
    }
  }
}
