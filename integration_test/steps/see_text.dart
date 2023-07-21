import 'package:flutter_test/flutter_test.dart';

void seeText(String text) {
  expect(find.text(text), findsOneWidget);
}
