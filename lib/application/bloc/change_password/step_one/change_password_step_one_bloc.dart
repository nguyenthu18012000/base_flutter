import 'package:base_bloc_flutter/application/datasource/datasources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

import '../../../datasource/remotes/change_password_step_one_remote.dart';

part 'change_password_step_one_event.dart';

part 'change_password_step_one_state.dart';

class ChangePasswordStepOneBloc
    extends Bloc<ChangePasswordStepOneEvent, ChangePasswordStepOneState> {
  ChangePasswordStepOneBloc() : super(const ChangePasswordStepOneState());

  final formCurrentPasswordKey = GlobalKey<FormState>();
  final password = TextEditingController();
  String? currentPassword = '';
}
