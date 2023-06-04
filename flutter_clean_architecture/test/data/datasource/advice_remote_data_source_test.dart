import 'package:flutter_clean_architecture/data/datasource/advice_remote_data_source.dart';
import 'package:flutter_clean_architecture/data/exceptions/exceptions.dart';
import 'package:flutter_clean_architecture/data/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  group("AdviceRemoteDataSource", () {
    group("should return AdviceModel", () {
      test("when Client response was 200 and has valid data", () async {
        final mockClient = MockClient();

        final adviceRemoteDataSource =
            AdviceRemoteDataSourceImpl(client: mockClient);
        const responseBody = '{"advice": "test advice", "advice_id": 1}';

        when(
          mockClient.get(
            Uri.parse("https://api.flutter-community.de/api/v1/advice"),
            headers: {"content-type": "application/json; charset=utf-8"},
          ),
        ).thenAnswer(
            (realInvocation) => Future.value(http.Response(responseBody, 200)));

        final result = await adviceRemoteDataSource.getRandomAdviceFromApi();
        expect(result, AdviceModel(advice: 'test advice', id: 1));
      });
    });

    group('should throw', () {
      test('a ServerException when Client response wa not 200', () {
        final mockClient = MockClient();
        final adviceRemoteDataSource =
            AdviceRemoteDataSourceImpl(client: mockClient);

        when(
          mockClient.get(
            Uri.parse("https://api.flutter-community.de/api/v1/advice"),
            headers: {"content-type": "application/json; charset=utf-8"},
          ),
        ).thenAnswer((realInvocation) => Future.value(http.Response('', 201)));

        expect(() => adviceRemoteDataSource.getRandomAdviceFromApi(),
            throwsA(isA<ServerException>()));
      });

      test('aType error when Client response was 200 and has no valid data',
          () {
        final mockClient = MockClient();
        final adviceRemoteDataSource =
            AdviceRemoteDataSourceImpl(client: mockClient);

        const responseBody = '{"advice": "test advice"}';

        when(
          mockClient.get(
            Uri.parse("https://api.flutter-community.de/api/v1/advice"),
            headers: {"content-type": "application/json; charset=utf-8"},
          ),
        ).thenAnswer(
            (realInvocation) => Future.value(http.Response(responseBody, 200)));

        expect(() => adviceRemoteDataSource.getRandomAdviceFromApi(),
            throwsA(isA<TypeError>()));
      });
    });
  });
}
