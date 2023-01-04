import 'package:base_bloc_flutter/application/datasource/models/models.dart';
import 'package:flutter_core/flutter_core.dart';

class NotificationRemote {
  final AppClient _appClient;

  NotificationRemote(this._appClient);

  Future<Either<Failure, dynamic>> fetchNotificationList() async {
    final result = await _appClient.call(
      '/notification',
      method: RestfulMethod.get,
    );
    return result.fold(
      (l) => Left(l),
      (r) {
        return Right(NotificationList.fromJson(r));
      },
    );
  }

  Future<Either<Failure, dynamic>> readANotification(int id) async {
    final result = await _appClient.call(
      '/notification/$id',
      method: RestfulMethod.put,
      data: {'status': true},
    );
    return result.fold(
      (l) => Left(l),
      (r) {
        return const Right(true);
      },
    );
  }
}
