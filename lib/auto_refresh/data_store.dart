import 'package:mobx/mobx.dart';

part 'data_store.g.dart';

class DataStore = _DataStore with _$DataStore;

abstract class _DataStore with Store {
  @observable
  String response = "";

  @action
  Future<void> fetchApi() async {
    // fake API call
    await Future.delayed(Duration(seconds: 1));
    response = "Data fetched at ${DateTime.now()}";
  }
}
