import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { idle, loading, success, error, noInternet }

class NetworkController extends GetxController {
  var status = NetworkStatus.idle.obs;
  var data = Rxn<dynamic>();
  var message = ''.obs;

  final dio.Dio _dio = dio.Dio();

  Future<void> fetchData(
    String url, {
    String method = 'GET',
    Map<String, dynamic>? params,
  }) async {
    status.value = NetworkStatus.loading;

    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      status.value = NetworkStatus.noInternet;
      message.value = "No Internet Connection";
      return;
    }

    try {
      dio.Response response;
      if (method == 'GET') {
        response = await _dio.get(url, queryParameters: params);
      } else if (method == 'POST') {
        response = await _dio.post(url, data: params);
      } else {
        status.value = NetworkStatus.error;
        message.value = "Unsupported HTTP method";
        return;
      }

      if (response.statusCode == 200) {
        data.value = response.data;
        status.value = NetworkStatus.success;
      } else {
        status.value = NetworkStatus.error;
        message.value = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      status.value = NetworkStatus.error;
      message.value = e.toString();
    }
  }
}
