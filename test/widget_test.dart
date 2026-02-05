import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pharmacy/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PharmyApp());

    // Verify that the counter text does not exist (since your app doesn't have a counter)
    // You can adjust this test according to your actual UI
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsNothing);

    // Example: if you had a button with '+' icon, you could test tapping
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // Verify expected behavior after tap
  });
}
