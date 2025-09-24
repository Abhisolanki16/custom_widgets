import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { idle, loading, success, error, noInternet }

class NetworkProvider with ChangeNotifier {
  NetworkStatus status = NetworkStatus.idle;
  dynamic data;
  String message = '';

  final Dio _dio = Dio();

  Future<void> fetchData(
    String url, {
    String method = 'GET',
    Map<String, dynamic>? params,
  }) async {
    status = NetworkStatus.loading;
    notifyListeners();

    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      status = NetworkStatus.noInternet;
      message = "No Internet Connection";
      notifyListeners();
      return;
    }

    try {
      Response response;
      if (method == 'GET') {
        response = await _dio.get(url, queryParameters: params);
      } else if (method == 'POST') {
        response = await _dio.post(url, data: params);
      } else {
        status = NetworkStatus.error;
        message = "Unsupported HTTP method";
        notifyListeners();
        return;
      }

      if (response.statusCode == 200) {
        data = response.data;
        status = NetworkStatus.success;
      } else {
        status = NetworkStatus.error;
        message = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      status = NetworkStatus.error;
      message = e.toString();
    }

    notifyListeners();
  }
}
