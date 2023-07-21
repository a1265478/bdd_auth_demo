import 'package:auth_demo/features/login/cubit/login_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Login state test', () {
    test('supports value comparisons', () {
      expect(const LoginState(), const LoginState());
    });
  });
}
