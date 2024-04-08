import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adoptme/homePage.dart'; 

void main() {
  testWidgets('HomePage Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomePage(
        toggleTheme: () {}, 
      ),
    ));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.search), findsOneWidget);
  });
}
