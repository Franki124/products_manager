import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';

StepDefinitionGeneric GivenIHaveLaunchedTheApp() {
  return given<FlutterWorld>('I have launched the app', (context) async {
  });
}

StepDefinitionGeneric WhenITapOnTheFAB() {
  return when<FlutterWorld>('I tap on the floating action button', (context) async {
    final fab = find.byType('FloatingActionButton');
    await context.world.driver!.tap(fab);
  });
}


StepDefinitionGeneric EnterProductName() {
  return when1<String, FlutterWorld>(
    'I enter {string} as the product name',
        (productName, context) async {
      final productNameField = find.byValueKey('ProductNameField');
      await context.world.driver!.tap(productNameField);
      await context.world.driver!.enterText(productName);
    },
  );
}