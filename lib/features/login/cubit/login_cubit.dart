import 'package:auth_demo/features/auth/cubit/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(const LoginState());
  final AuthRepo _authRepo;

  void login(String username, String password) async {
    emit(state.copyWith(status: ApiStatus.inProgress));
    try {
      await _authRepo.login(username, password);
      emit(state.copyWith(status: ApiStatus.success));
    } catch (_) {
      emit(state.copyWith(status: ApiStatus.failure));
    }
  }
}
