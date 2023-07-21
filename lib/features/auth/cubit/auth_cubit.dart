import 'dart:async';

import 'package:auth_demo/features/auth/cubit/repositories/auth_repo.dart';
import 'package:auth_demo/features/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  late StreamSubscription<AuthStatus> _authStatusSubscription;
  final AuthRepo _authRepo;
  AuthCubit({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(const AuthState.unknown()) {
    _authStatusSubscription = _authRepo.status.listen(
      (status) => authStatusChanged(status),
    );
  }

  void authStatusChanged(AuthStatus status) async {
    switch (status) {
      case AuthStatus.authenticated:
        final user = await _authRepo.getUser();
        emit(AuthState.authenticated(user));
      case AuthStatus.unauthenticated:
        emit(const AuthState.unauthenticated());
      case AuthStatus.unknown:
        emit(const AuthState.unknown());
    }
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    return super.close();
  }
}
