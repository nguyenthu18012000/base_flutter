part of 'notification_bloc.dart';

enum NotificationStatus { initial, loading, success, failure }

extension NotificationStatusExt on NotificationStatus {
  bool get isInitial => this == NotificationStatus.initial;

  bool get isLoading => this == NotificationStatus.loading;

  bool get isSuccess => this == NotificationStatus.success;

  bool get isFailure => this == NotificationStatus.failure;
}

class NotificationState extends Equatable {
  const NotificationState({
    this.status = NotificationStatus.initial,
    this.notificationList,
    this.errorMes,
  });

  final NotificationStatus status;
  final NotificationList? notificationList;
  final String? errorMes;

  NotificationState copyWith({
    NotificationStatus? status,
    NotificationList? notificationList,
    String? errorMes,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notificationList: notificationList ?? this.notificationList,
      errorMes: errorMes
    );
  }

  bool get isEmpty => notificationList?.items?.isEmpty ?? true;

  @override
  List<Object?> get props => [status, notificationList, errorMes];
}
