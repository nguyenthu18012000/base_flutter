import 'dart:ui';

import 'package:intl/intl.dart';

import 'datetime_extension.dart';

extension IntegerExtension on int {
  String get dayOfWeekDateTimeString {
    return DateTime.fromMillisecondsSinceEpoch(this * 1000).dayOfWeekDateTimeVN;
  }

  String get dateTimeString {
    return DateTime.fromMillisecondsSinceEpoch(this * 1000).dateTimeString;
  }

  String get dateString => DateTime.fromMillisecondsSinceEpoch(this * 1000).dateString;
  DateTime get dateTimeValue => DateTime.fromMillisecondsSinceEpoch(this * 1000);

  String get currencyString {
    return '${NumberFormat("#,###").format(this).replaceAll(',', '.')}đ';
  }

  Color get colorFromIntValue {
    switch (this) {
      case 0:
        return const Color(0xff1555a7);
      case 1:
        return const Color(0xfff37678);
      case 2:
        return const Color(0xffE60708);
      case 3:
        return const Color(0xff540967);
    }
    return const Color(0xff1555a7);
  }

  Color get colorTableFromIntValue {
    switch (this) {
      case 0:
        return const Color(0xffffffff);
      case 1:
        return const Color(0xfff37678);
      case 2:
        return const Color(0xffE60708);
      case 3:
        return const Color(0xff540967);
    }
    return const Color(0xffffffff);
  }
}
