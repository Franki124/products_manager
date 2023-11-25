import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:products_manager/main.dart' as app;
import 'package:products_manager/pages/widgets/label_text_field_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group('end-to-end test', () {
    testWidgets('Initialize the app', (tester) async {
      await launchApp(tester);

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets(
        'tap on the floating action button, verify proper add product page',
        (tester) async {
      await launchApp(tester);
      await tapOnFAB(tester);

      expect(
          find.widgetWithText(LabelTextField, 'Product Name'), findsOneWidget);
      expect(
          find.widgetWithText(LabelTextField, 'Product Price'), findsOneWidget);
    });

    testWidgets('tap on the Add button, verify that product was added',
        (tester) async {
      await launchApp(tester);
      await tapOnFAB(tester);

      await enterTextInField(tester, 'Product Name', 'Smartphone');
      await enterTextInField(tester, 'Product Price', '1000');
      await tester.tap(find.widgetWithText(TextButton, 'Add'));
      await tester.pumpAndSettle();

      final Finder productNameFinder = find.text('Smartphone');
      final Finder productPriceFinder = find.text('\$ 1000');

      await tester.scrollUntilVisible(
        productNameFinder,
        500,
      );

      await tester.pumpAndSettle();

      expect(productNameFinder, findsOneWidget);
      expect(productPriceFinder, findsOneWidget);
    });

    testWidgets('Update the created product', (tester) async {
      await launchApp(tester);

      final Finder productItem = find.text('Smartphone');
      await tester.scrollUntilVisible(productItem, 500);

      await tester.drag(productItem, const Offset(500, 0));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      await enterTextInField(tester, 'Product Name', 'Updated Smartphone');
      await tester.tap(find.widgetWithText(TextButton, 'Save'));
      await tester.pumpAndSettle();

      final Finder productNameFinder = find.text('Updated Smartphone');
      expect(productNameFinder, findsOneWidget);
    });

    testWidgets('Delete the created product', (tester) async {
      await launchApp(tester);

      final Finder productItem = find.text('Updated Smartphone');
      await tester.scrollUntilVisible(productItem, 500);

      await tester.drag(productItem, const Offset(-500, 0));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      expect(find.text('Updated Smartphone'), findsNothing);
    });
  });
}

Future<void> launchApp(WidgetTester tester) async {
  app.main();
  await tester.pumpAndSettle();
}

Future<void> tapOnFAB(WidgetTester tester) async {
  final Finder fab = find.byType(FloatingActionButton);
  await tester.tap(fab);
  await tester.pumpAndSettle();
}

Future<void> enterTextInField(
    WidgetTester tester, String labelText, String text) async {
  final Finder field = find.widgetWithText(LabelTextField, labelText);
  await tester.ensureVisible(field);
  await tester.tap(field);

  await tester.enterText(field, '');

  await tester.enterText(field, text);
  await tester.pumpAndSettle();
}
