import 'package:custom_widgets/auto_refresh/global_route_aware.dart';
import 'package:flutter/material.dart';
import 'data_store.dart';
import 'package:provider/provider.dart';

mixin AutoRefresh<T extends StatefulWidget> on State<T> {
  late GlobalRouteAware _routeAware;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _routeAware = GlobalRouteAware(() {
      final store = context.read<DataStore>();
      store.fetchApi(); // global refresh
    });
    globalRouteObserver.subscribe(_routeAware, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    globalRouteObserver.unsubscribe(_routeAware);
    super.dispose();
  }
}
