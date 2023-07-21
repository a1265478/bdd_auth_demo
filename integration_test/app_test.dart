import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:auth_demo/main.dart' as app;

import 'steps/enter_field_by_key.dart';
import 'steps/see_text.dart';
import 'steps/see_type.dart';
import 'steps/tap_button.dart';

//TODO: run flutter test integration_test/app_test.dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login', () {
    const usernameKey = Key('username_input');
    const passwordKey = Key('password_input');
    const loginBtnKey = Key('login_btn');
    const validUsername = 'username';
    const validPassword = 'password';
    const invalidUsername = 'unknow';
    const invalidPassword = 'pxxxx';

    testWidgets('登入流程情境', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 1));
      //不輸入
      await tapButtonByKey(tester, loginBtnKey);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      seeText('Please enter username');
      seeText('Please enter password');
      //未成功登入
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await enterFieldByKey(tester, usernameKey, invalidUsername);
      await enterFieldByKey(tester, passwordKey, invalidPassword);
      await tapButtonByKey(tester, loginBtnKey);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      seeType(SnackBar);
      seeText('Authentication Failure');
      //登入成功
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await enterFieldByKey(tester, usernameKey, validUsername);
      await enterFieldByKey(tester, passwordKey, validPassword);
      await tapButtonByKey(tester, loginBtnKey);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      seeText('Home');
    });
    testWidgets('輸入正確的帳號及密碼', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await enterFieldByKey(tester, usernameKey, validUsername);
      await enterFieldByKey(tester, passwordKey, validPassword);
      await tapButtonByKey(tester, loginBtnKey);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      seeText('Home');
    });

    testWidgets('未輸入帳號或密碼', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tapButtonByKey(tester, loginBtnKey);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      seeText('Please enter username');
      seeText('Please enter password');
    });

    testWidgets('輸入錯誤的帳號或密碼', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await enterFieldByKey(tester, usernameKey, invalidUsername);
      await enterFieldByKey(tester, passwordKey, invalidPassword);
      await tapButtonByKey(tester, loginBtnKey);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      seeType(SnackBar);
      seeText('Authentication Failure');
    });
  });
}
