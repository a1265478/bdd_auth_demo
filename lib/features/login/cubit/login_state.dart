// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = ApiStatus.init,
    this.errorMsg,
  });

  final ApiStatus status;
  final String? errorMsg;
  @override
  List<Object?> get props => [status, errorMsg];

  LoginState copyWith({
    ApiStatus? status,
    String? Function()? errorMsg,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMsg: errorMsg != null ? errorMsg() : this.errorMsg,
    );
  }
}

enum ApiStatus {
  init,
  inProgress,
  success,
  failure,
}
