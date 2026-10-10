
import 'package:flutter_test/flutter_test.dart';
import 'package:aplikasi_ecowalk/main.dart';

void main() {
  testWidgets('EcoWalk app launches successfully',
      (WidgetTester tester) async {
    await tester.pumpWidget(const EcoWalkApp());

    expect(find.byType(EcoWalkApp), findsOneWidget);
  });
}