import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

import 'add_product_steps.dart'; // Import your step definitions

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = ['test_driver/features/'] // Path to feature files
    ..stepDefinitions = [
      GivenIHaveLaunchedTheApp(),
      WhenITapOnTheFAB(),
      EnterProductName(),
      // Add other step definitions here
    ]
    ..reporters = [ProgressReporter()]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = 'test_driver/app.dart';

  return GherkinRunner().execute(config);
}