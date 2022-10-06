// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_manager_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserManager on _UserManagerBase, Store {
  late final _$userAtom = Atom(name: '_UserManagerBase.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$getUserAsyncAction =
      AsyncAction('_UserManagerBase.getUser', context: context);

  @override
  Future<void> getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  late final _$removeUserAsyncAction =
      AsyncAction('_UserManagerBase.removeUser', context: context);

  @override
  Future<void> removeUser() {
    return _$removeUserAsyncAction.run(() => super.removeUser());
  }

  late final _$_UserManagerBaseActionController =
      ActionController(name: '_UserManagerBase', context: context);

  @override
  void setUser(User value) {
    final _$actionInfo = _$_UserManagerBaseActionController.startAction(
        name: '_UserManagerBase.setUser');
    try {
      return super.setUser(value);
    } finally {
      _$_UserManagerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}
