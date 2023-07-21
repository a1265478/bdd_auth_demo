import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> enterFieldByKey(WidgetTester tester, Key key, String value) async {
  await tester.enterText(
    find.byKey(key),
    value,
  );
  await tester.pump();
}
