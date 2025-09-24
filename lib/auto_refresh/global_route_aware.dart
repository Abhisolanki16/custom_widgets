import 'package:flutter/material.dart';

final RouteObserver<ModalRoute<void>> globalRouteObserver =
    RouteObserver<ModalRoute<void>>();

typedef RefreshCallback = void Function();

class GlobalRouteAware extends RouteAware {
  final RefreshCallback onPopNext;

  GlobalRouteAware(this.onPopNext);

  @override
  void didPopNext() {
    onPopNext(); // trigger refresh when coming back
  }
}
