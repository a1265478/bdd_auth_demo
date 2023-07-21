import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> tapButtonByKey(WidgetTester tester, Key key) async {
  await tester.tap(find.byKey(key));
  await tester.pump();
}
