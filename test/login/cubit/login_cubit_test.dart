import 'package:auth_demo/features/auth/cubit/repositories/auth_repo.dart';
import 'package:auth_demo/features/login/cubit/login_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../auth/repositories/auth_repo_test.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
  late AuthRepo authRepo;
  setUp(() {
    authRepo = MockAuthRepo();
  });
  group('Login submitted', () {
    blocTest(
      'Login success',
      setUp: () {
        when(
          () => authRepo.login(
            'username',
            'password',
          ),
        ).thenAnswer((_) => Future<String>.value('user'));
      },
      build: () => LoginCubit(authRepo: authRepo),
      act: (bloc) {
        bloc.login('username', 'password');
      },
      expect: () => const <LoginState>[
        LoginState(status: ApiStatus.inProgress),
        LoginState(status: ApiStatus.success),
      ],
    );

    blocTest(
      'Login failure',
      setUp: () {
        when(
          () => authRepo.login(
            'username',
            'password',
          ),
        ).thenThrow(Exception('OOPS'));
      },
      build: () => LoginCubit(authRepo: authRepo),
      act: (bloc) {
        bloc.login('username', 'password');
      },
      expect: () => const <LoginState>[
        LoginState(status: ApiStatus.inProgress),
        LoginState(status: ApiStatus.failure),
      ],
    );
  });
}
