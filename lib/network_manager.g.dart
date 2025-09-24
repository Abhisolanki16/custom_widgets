// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_manager.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NetworkManager on _NetworkManager, Store {
  late final _$isConnectedAtom = Atom(
    name: '_NetworkManager.isConnected',
    context: context,
  );

  @override
  bool get isConnected {
    _$isConnectedAtom.reportRead();
    return super.isConnected;
  }

  @override
  set isConnected(bool value) {
    _$isConnectedAtom.reportWrite(value, super.isConnected, () {
      super.isConnected = value;
    });
  }

  late final _$_NetworkManagerActionController = ActionController(
    name: '_NetworkManager',
    context: context,
  );

  @override
  void setConnection(bool status) {
    final _$actionInfo = _$_NetworkManagerActionController.startAction(
      name: '_NetworkManager.setConnection',
    );
    try {
      return super.setConnection(status);
    } finally {
      _$_NetworkManagerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isConnected: ${isConnected}
    ''';
  }
}
