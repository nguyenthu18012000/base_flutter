part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {
  final limit = 12;
}

class NotificationStared extends NotificationEvent {}

class NotificationRefresh extends NotificationEvent {}

class NotificationLoadMore extends NotificationEvent {}

class NotificationOnTap extends NotificationEvent {
  NotificationOnTap({required this.id});

  final int? id;
}

class NotificationOnReadAll extends NotificationEvent {}
