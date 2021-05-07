import 'package:flutter_test/flutter_test.dart';

import 'package:moby_log/moby_log.dart';

void main() {
  final logger = MobyLog();
  logger.init('https://moby-log-dev.apps.mobyinc.com');

  test('logs an event', () {
    expect(
        logger
            .logEvent('tester', 'screen', 'home')
            .then((value) => expect(value, true)),
        completes);
  });

  test('logs extra data', () {
    expect(
        logger.logEvent('tester', 'screen', 'home',
            info: 'testing',
            data: {'mykey': 'value'}).then((value) => expect(value, true)),
        completes);
  });
}
