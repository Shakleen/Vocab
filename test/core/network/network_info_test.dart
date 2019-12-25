import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vocab/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfoImpl;
  MockDataConnectionChecker checker;

  setUp(() {
    checker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(checker);
  });

  test(
    'should forward isConnected call to DataConnectionChecker.hasConnection',
    () async {
      final hasConnectionFuture = Future.value(true);
      when(checker.hasConnection).thenAnswer((_) async => hasConnectionFuture);
      final result = await networkInfoImpl.isConnected;
      verify(checker.hasConnection);
      expect(result, await hasConnectionFuture);
    },
  );
}
