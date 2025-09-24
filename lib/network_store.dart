// import 'package:custom_widgets/network_state.dart';
// import 'package:mobx/mobx.dart';
// import 'package:dio/dio.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// part 'network_store.g.dart';

// class NetworkStore = _NetworkStore with _$NetworkStore;

// abstract class _NetworkStore with Store {
//   final Dio _dio = Dio();

//   @observable
//   NetworkState<dynamic> state = NetworkState.idle();

//   @action
//   Future<void> fetchData(
//     String url, {
//     String method = 'GET',
//     Map<String, dynamic>? params,
//   }) async {
//     state = NetworkState.loading();

//     final connectivity = await Connectivity().checkConnectivity();
//     if (connectivity == ConnectivityResult.none) {
//       state = NetworkState.noInternet();
//       return;
//     }

//     try {
//       Response response;
//       if (method == 'GET') {
//         response = await _dio.get(url, queryParameters: params);
//       } else if (method == 'POST') {
//         response = await _dio.post(url, data: params);
//       } else {
//         state = NetworkState.error("Unsupported HTTP method");
//         return;
//       }

//       if (response.statusCode == 200) {
//         state = NetworkState.success(response.data);
//       } else {
//         state = NetworkState.error('Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       state = NetworkState.error(e.toString());
//     }
//   }
// }
