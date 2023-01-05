import 'package:base_bloc_flutter/application/bloc/blocs.dart';
import 'package:base_bloc_flutter/application/datasource/datasources.dart';
import 'package:base_bloc_flutter/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart' as core;

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const core.AppScaffold<NotificationBloc>(
      padding: EdgeInsets.zero,
      body: NotificationView(),
    );
  }
}

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    core.BlocProvider.of<NotificationBloc>(context).add(NotificationStared());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          iconSize: 24.0,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Notifications',
          style: StyleConstants.hugeText.copyWith(
            fontWeight: FontWeight.w700,
            color: ColorConstants.textBlack1,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              core.BlocProvider.of<NotificationBloc>(context)
                  .add(NotificationOnReadAll());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.center,
              child: Text(
                'Read all',
                style: StyleConstants.largeText.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.primaryColorSwatch,
                ),
              ),
            ),
          )
        ],
      ),
      body: core.BlocConsumer<NotificationBloc, NotificationState>(
        builder: (BuildContext context, NotificationState state) {
          if ((state.notificationList?.totalItems ?? 0) == 0) {
            return Center(
              child: Text(
                'Notification empty',
                textAlign: TextAlign.start,
                style: StyleConstants.largeText.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                NotificationItem item = state.notificationList?.items?[index] ??
                    NotificationItem();
                return NotificationItemView(
                  notification: item,
                  onTap: () {
                    core.BlocProvider.of<NotificationBloc>(context)
                        .add(NotificationOnTap(id: item.id));
                  },
                );
              },
              itemCount: state.notificationList?.totalItems ?? 0,
            );
          }
        },
        listener: (BuildContext context, NotificationState state) {
          if (state.status.isLoading) {
            core.UIHelper.showLoading();
          } else {
            core.UIHelper.hideLoading();
          }
        },
      ),
    );
  }
}

class NotificationItemView extends StatelessWidget {
  const NotificationItemView({
    Key? key,
    required this.onTap,
    required this.notification,
  }) : super(key: key);
  final Function() onTap;
  final NotificationItem notification;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: notification.status ? Colors.white : ColorConstants.linkWater,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: notification.status
                    ? ColorConstants.catskillWhite
                    : ColorConstants.cruise,
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Icon(
                Icons.notifications_outlined,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.content ?? '',
                    textAlign: TextAlign.start,
                    style: StyleConstants.largeText.copyWith(
                      fontWeight: notification.status
                          ? FontWeight.w400
                          : FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    notification.createdAt ?? '',
                    textAlign: TextAlign.start,
                    style: StyleConstants.mediumText,
                  ),
                ],
              ),
            ),
            Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: notification.status
                    ? Colors.transparent
                    : ColorConstants.errorRed,
              ),
              margin: const EdgeInsets.only(left: 12),
            )
          ],
        ),
      ),
    );
  }
}
