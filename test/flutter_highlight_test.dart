import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test', (tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: FlutterHighlight(
              minOpacity: 0.17,
              maxOpacity: 0.86,
              blinkNumber: 2,
              duration: Duration(seconds: 2),
              child: Text('My Text'),
            ),
          ),
        ),
      ),
    );

    final FlutterHighlightState state = tester.firstState(
      find.byType(FlutterHighlight),
    );

    final animationController = state.animationController;
    expect(animationController.value, 0.17);

    await tester.pump(Duration(seconds: 2));
    expect(animationController.value, 0.86);
  });
}
