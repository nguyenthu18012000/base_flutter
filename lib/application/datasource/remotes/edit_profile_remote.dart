import 'dart:io';

import 'package:flutter_core/flutter_core.dart';
import '../../../constants/constants.dart';
import '../models/models.dart';

class EditProfileRemote {
  final AppClient _appClient;

  EditProfileRemote(this._appClient);

  Future<Either<Failure, String?>> uploadAvatar(String path) async {
    final data = FormData();
    data.files.add(MapEntry(
        'file',
        MultipartFile.fromFileSync(path,
            filename: path.split(Platform.pathSeparator).last)));
    final result = await _appClient.call(ApiConstants.updateAvatar,
        method: RestfulMethod.post, data: data);

    return result.fold(
      (l) => Left(l),
      (r) {
        return Right(User.fromJson(r).avatar);
      },
    );
  }

  Future<Either<Failure, User?>> updateUserProfile(User user) async {
    final result = await _appClient.call(
        ApiConstants.getUserProfile + user.id.toString(),
        method: RestfulMethod.put,
        data: user);

    return result.fold(
      (l) => Left(l),
      (r) {
        return Right(User.fromJson(r));
      },
    );
  }
}
