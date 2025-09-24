import 'package:mobx/mobx.dart';

part 'base_store.g.dart';

class BaseStore = _BaseStore with _$BaseStore;

abstract class _BaseStore with Store {
  @observable
  String response = "";

  @action
  Future<void> fetchApi() async {
    await Future.delayed(const Duration(seconds: 1));
    response = "Fetched at ${DateTime.now()}";
  }
}
