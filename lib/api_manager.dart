import 'package:dio/dio.dart';
import 'network_manager.dart';

class ApiManager {
  final Dio _dio = Dio();
  final NetworkManager networkManager;

  ApiManager({required this.networkManager});

  Future<Response?> getRequest(String url) async {
    if (!networkManager.isConnected) {
      print("No internet, skipping API call");
      return null;
    }

    try {
      final response = await _dio.get(url);
      return response;
    } catch (e) {
      print("API Error: $e");
      return null;
    }
  }

  // You can add postRequest, putRequest similarly
}
