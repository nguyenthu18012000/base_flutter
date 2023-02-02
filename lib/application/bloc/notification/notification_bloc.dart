import 'package:base_bloc_flutter/application/datasource/datasources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(this.notificationRemote) : super(const NotificationState()) {
    on<NotificationStared>(fetchNotificationList);
    on<NotificationOnTap>(readANotification);
    on<NotificationOnReadAll>(readAllNotification);
  }

  final NotificationRemote notificationRemote;

  void fetchNotificationList(
    NotificationStared event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(status: NotificationStatus.loading));
    final result = await notificationRemote.fetchNotificationList();
    result.fold((l) {
      emit(state.copyWith(
        status: NotificationStatus.failure,
        errorMes: l.message,
      ));
    }, (r) {
      emit(state.copyWith(
        status: NotificationStatus.success,
        notificationList: (r as NotificationList).copyWith(
            items: r.items
                ?.map((e) => e.copyWith(
                    createdAt: convertNotificationDatetime(e.createdAt ?? '')))
                .toList()),
      ));
    });
  }

  String convertNotificationDatetime(String time) {
    if (time.isEmpty) return '';
    DateTime date = DateTime.parse(time);
    if (DateTime.now().day == date.day) {
      return 'Today - ${DateFormat('hh:mm').format(date)}';
    } else {
      return DateFormat('yyyy/MM/dd - hh:mm').format(date);
    }
  }

  void readANotification(
    NotificationOnTap event,
    Emitter<NotificationState> emit,
  ) async {
    if (event.id != null) {
      emit(state.copyWith(
          status: NotificationStatus.success,
          notificationList: state.notificationList?.copyWith(
            items: List.from(state.notificationList?.items?.map((element) =>
                    element.copyWith(
                        status:
                            event.id == element.id ? true : element.status)) ??
                []),
          )));
      await notificationRemote.readANotification(event.id!);
    }
  }

  void readAllNotification(
    NotificationOnReadAll event,
    Emitter<NotificationState> emit,
  ) {}
}
