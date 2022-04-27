import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bytebank/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ByteBankApp());
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
  });
}
