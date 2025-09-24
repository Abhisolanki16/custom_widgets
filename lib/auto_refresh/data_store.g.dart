// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DataStore on _DataStore, Store {
  late final _$responseAtom = Atom(
    name: '_DataStore.response',
    context: context,
  );

  @override
  String get response {
    _$responseAtom.reportRead();
    return super.response;
  }

  @override
  set response(String value) {
    _$responseAtom.reportWrite(value, super.response, () {
      super.response = value;
    });
  }

  late final _$fetchApiAsyncAction = AsyncAction(
    '_DataStore.fetchApi',
    context: context,
  );

  @override
  Future<void> fetchApi() {
    return _$fetchApiAsyncAction.run(() => super.fetchApi());
  }

  @override
  String toString() {
    return '''
response: ${response}
    ''';
  }
}
