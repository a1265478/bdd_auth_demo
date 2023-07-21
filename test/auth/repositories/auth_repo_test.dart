import 'package:auth_demo/features/auth/cubit/repositories/auth_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late AuthRepo authRepo;
  setUp(() {
    authRepo = AuthRepo();
  });
  group('Auth repository', () {
    test('login success', () async {
      expect(authRepo.login('username', 'password'), completes);
    });

    test('login failure', () {
      expect(
        authRepo.login('unknow', 'pxxxx'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
