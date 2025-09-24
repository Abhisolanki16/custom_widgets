import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'network_manager.g.dart';

class NetworkManager = _NetworkManager with _$NetworkManager;

abstract class _NetworkManager with Store {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _subscription;

  @observable
  bool isConnected = true;

  @action
  void setConnection(bool status) {
    isConnected = status;
  }

  void initialize(BuildContext context) {
    _subscription = _connectivity.onConnectivityChanged
        .map((results) => results.first) // List → single result
        .listen((result) {
          bool status = result != ConnectivityResult.none;

          if (status != isConnected) {
            setConnection(status);
            if (!status) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("No internet connection"),
                  duration: Duration(seconds: 3),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Internet connected"),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          }
        });
  }

  void dispose() {
    _subscription?.cancel();
  }
}
