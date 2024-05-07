import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_dialerbutton_flutter/source/dialer_button.dart';

void main() {
  group('DialerButton Tests', () {
    testWidgets('DialerButton constructs with minimal parameters',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: DialerButton(
            topWidget: const Icon(Icons.phone),
            onTapUp: (details) {},
            onTapDown: (details) {},
          ),
        ),
      ));

      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('DialerButton calls onTapUp and onTapDown',
        (WidgetTester tester) async {
      bool onTapUpCalled = false;
      bool onTapDownCalled = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: DialerButton(
            topWidget: const Icon(Icons.phone),
            onTapUp: (details) {
              onTapUpCalled = true;
            },
            onTapDown: (details) {
              onTapDownCalled = true;
            },
          ),
        ),
      ));

      await tester.tap(find.byType(DialerButton));
      await tester.pump(); // Trigger a frame.

      expect(onTapUpCalled, isTrue);
      expect(onTapDownCalled, isTrue);
    });

    testWidgets('DialerButton renders top and bottom widgets correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: DialerButton(
            topWidget: Icon(Icons.phone),
            bottomWidget: Text('Label'),
          ),
        ),
      ));

      expect(find.byIcon(Icons.phone), findsOneWidget);
      expect(find.text('Label'), findsOneWidget);
    });

    testWidgets('DialerButton applies custom colors',
        (WidgetTester tester) async {
      const backgroundColor = Colors.red;
      const borderColor = Colors.blue;
      const splashColor = Colors.green;

      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: DialerButton(
            topWidget: Icon(Icons.phone),
            backgroundColor: backgroundColor,
            borderColor: borderColor,
            splashColor: splashColor,
          ),
        ),
      ));

      final ElevatedButton button = tester.widget(find.byType(ElevatedButton));
      expect(
          button.style?.backgroundColor?.resolve({}), equals(backgroundColor));
      expect(button.style?.overlayColor?.resolve({}), equals(splashColor));
    });
  });
}
