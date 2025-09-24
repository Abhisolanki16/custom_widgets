enum NetworkStatus { idle, loading, success, error, noInternet }

class NetworkState<T> {
  final NetworkStatus status;
  final T? data;
  final String? message;

  NetworkState._({required this.status, this.data, this.message});

  factory NetworkState.idle() => NetworkState._(status: NetworkStatus.idle);
  factory NetworkState.loading() =>
      NetworkState._(status: NetworkStatus.loading);
  factory NetworkState.success(T data) =>
      NetworkState._(status: NetworkStatus.success, data: data);
  factory NetworkState.error(String message) =>
      NetworkState._(status: NetworkStatus.error, message: message);
  factory NetworkState.noInternet() =>
      NetworkState._(status: NetworkStatus.noInternet, message: "No Internet");
}
