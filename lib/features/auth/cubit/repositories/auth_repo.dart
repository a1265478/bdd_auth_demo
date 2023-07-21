import 'dart:async';

import 'package:auth_demo/features/auth/cubit/auth_cubit.dart';
import 'package:auth_demo/features/models/user.dart';

class AuthRepo {
  final _controller = StreamController<AuthStatus>();

  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> login(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      if (username != 'username') {
        throw Exception('Not exist');
      }
      _controller.add(AuthStatus.authenticated);
    } catch (_) {
      rethrow;
    }
  }

  Future<User> getUser() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return const User('username');
  }
}
