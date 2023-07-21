import 'package:flutter_test/flutter_test.dart';

void seeType(Type type) {
  expect(find.byType(type), findsOneWidget);
}
