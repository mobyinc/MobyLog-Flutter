import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mobylog/mobylog.dart';

void main() {
  final logger = MobyLog();

  MockClient testClient = MockClient((request) async {
    return http.Response('', 201);
  });

  logger.init('https://mobymock', testClient);

  test('logs an event', () {
    expect(
        logger.screen('home').then((value) => expect(value, true)), completes);
  });

  test('logs extra data', () {
    logger.setUser('tom');

    expect(
        logger.event('toggle',
            info: 'testing',
            data: {'mykey': 'value'}).then((value) => expect(value, true)),
        completes);
  });
}
