// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:boring_show_app/app.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('HomeScreen should change theme and show buttons',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('Episode #0'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    var switcher = find.byWidgetPredicate((Widget widget) => widget is Switch);
    await tester.tap(switcher);
    await tester.pumpAndSettle();
    expect(
      tester.widget(switcher),
      isA<Switch>().having((s) => s.value, 'value', false),
    );

    // Verify that theme changed
    final controller = Get.find<GetMaterialController>();
    expect(controller.theme?.brightness, Brightness.light);
  });
}
