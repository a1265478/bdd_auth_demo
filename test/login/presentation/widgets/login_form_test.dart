import 'package:auth_demo/features/auth/cubit/repositories/auth_repo.dart';
import 'package:auth_demo/features/login/cubit/login_cubit.dart';
import 'package:auth_demo/features/login/presentation/widgets/login_form.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../auth/repositories/auth_repo_test.dart';
import '../../cubit/login_cubit_test.dart';

void main() {
  late LoginCubit loginCubit;
  late AuthRepo authRepo;
  setUp(() {
    loginCubit = MockLoginCubit();
    authRepo = MockAuthRepo();
    when(() => loginCubit.state).thenReturn(const LoginState());
  });

  tearDown(() {
    loginCubit.close();
  });
  group(
    'login form',
    () {
      testWidgets(
        '表格渲染',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: RepositoryProvider.value(
                value: authRepo,
                child: BlocProvider.value(
                  value: loginCubit,
                  child: const Scaffold(body: LoginForm()),
                ),
              ),
            ),
          );

          expect(find.byKey(const Key('username_input')), findsOneWidget);
          expect(find.byKey(const Key('password_input')), findsOneWidget);
          expect(find.byKey(const Key('login_btn')), findsOneWidget);
        },
      );

      testWidgets(
        '表格輸入完整請求登入動作',
        (tester) async {
          when(() => loginCubit.login('username', 'password')).thenReturn(null);
          await tester.pumpWidget(
            MaterialApp(
              home: RepositoryProvider.value(
                value: authRepo,
                child: BlocProvider.value(
                  value: loginCubit,
                  child: const Scaffold(body: LoginForm()),
                ),
              ),
            ),
          );
          await tester.enterText(
            find.byKey(const Key('username_input')),
            'username',
          );
          await tester.enterText(
            find.byKey(const Key('password_input')),
            'password',
          );
          await tester.tap(find.byKey(const Key('login_btn')));
          verify(() => loginCubit.login('username', 'password')).called(1);
        },
      );

      testWidgets(
        '表格未輸入完成顯示錯誤訊息並忽略登入請求',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: RepositoryProvider.value(
                value: authRepo,
                child: BlocProvider.value(
                  value: loginCubit,
                  child: const Scaffold(body: LoginForm()),
                ),
              ),
            ),
          );

          await tester.tap(find.byKey(const Key('login_btn')));
          await tester.pumpAndSettle();
          expect(find.text('Please enter username'), findsOneWidget);
          expect(find.text('Please enter password'), findsOneWidget);
          verifyNever(() => loginCubit.login('', ''));
        },
      );

      testWidgets('當登入錯誤時顯示錯誤訊息', (tester) async {
        whenListen(
          loginCubit,
          Stream.fromIterable(const [
            LoginState(status: ApiStatus.inProgress),
            LoginState(status: ApiStatus.failure)
          ]),
          initialState: const LoginState(status: ApiStatus.failure),
        );
        await tester.pumpWidget(
          MaterialApp(
            home: RepositoryProvider.value(
              value: authRepo,
              child: BlocProvider.value(
                value: loginCubit,
                child: const Scaffold(body: LoginForm()),
              ),
            ),
          ),
        );
        await tester.pump();
        expect(find.byType(SnackBar), findsOneWidget);
      });
    },
  );
}
