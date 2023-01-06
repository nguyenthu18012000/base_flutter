import 'package:flutter/widgets.dart';

extension ContextExtension on BuildContext {
  hideKeyboard() {
    FocusScope.of(this).requestFocus(new FocusNode());
  }

  bool get isTablet {
    var shortestSide = MediaQuery.of(this).size.shortestSide;
    return shortestSide >= 600;
  }

  double get paddingTop => MediaQuery.of(this).padding.top;
}

extension NavigatorStateExtension on NavigatorState {

  void pushNamedIfNotCurrent( String routeName, {Object? arguments} ) {
    if (!isCurrent(routeName)) {
      pushNamed( routeName, arguments: arguments );
    }
  }

  bool isCurrent( String routeName ) {
    bool isCurrent = false;
    popUntil( (route) {
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    } );
    return isCurrent;
  }

}
