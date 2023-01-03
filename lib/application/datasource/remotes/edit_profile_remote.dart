import 'dart:io';

import 'package:flutter_core/flutter_core.dart';
import '../../../constants/constants.dart';
import '../models/models.dart';

class EditProfileRemote {
  final AppClient _appClient;

  EditProfileRemote(this._appClient);

  Future<Either<Failure, User?>> uploadAvatar(String path) async {
    final data = FormData();
    data.files.add(MapEntry(
        'fileUpload',
        MultipartFile.fromFileSync(path,
            filename: path.split(Platform.pathSeparator).last)));
    final result = await _appClient.call(ApiConstants.getUserProfile,
        method: RestfulMethod.post, data: data);

    return result.fold(
      (l) => Left(l),
      (r) {
        return Right(r.map((e) => User.fromJson(e)));
      },
    );
  }
}
