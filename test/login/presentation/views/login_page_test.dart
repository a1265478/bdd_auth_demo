import 'package:auth_demo/features/auth/cubit/repositories/auth_repo.dart';
import 'package:auth_demo/features/login/cubit/login_cubit.dart';
import 'package:auth_demo/features/login/presentation/views/login_page.dart';
import 'package:auth_demo/features/login/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../auth/repositories/auth_repo_test.dart';
import '../../cubit/login_cubit_test.dart';

void main() {
  late LoginCubit loginCubit;
  late AuthRepo authRepo;
  setUp(() {
    loginCubit = MockLoginCubit();
    authRepo = MockAuthRepo();
  });
  group(
    'Login page',
    () {
      testWidgets(
        'render login form',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: RepositoryProvider.value(
                value: authRepo,
                child: BlocProvider.value(
                  value: loginCubit,
                  child: const LoginPage(),
                ),
              ),
            ),
          );

          await tester.pumpAndSettle();
          expect(find.byType(LoginForm), findsOneWidget);
        },
      );
    },
  );
}
