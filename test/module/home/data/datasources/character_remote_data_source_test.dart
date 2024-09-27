import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:superherois/core/infra/infra.dart' as custom_http;
import 'package:superherois/core/infra/http_interceptor.dart';
import 'package:superherois/modules/home/data/data.dart';
import 'package:http/http.dart' as http;

import '../../../../mocks_response.dart';
import 'widget_test.mocks.dart';

@GenerateMocks([custom_http.HttpClient, HttpInterceptor])
void main() {
  late MockHttpClient mockHttpClient;
  late MockHttpInterceptor mockHttpInterceptor;
  late CharacterRemoteDataSourceImpl characterRemoteDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockHttpInterceptor = MockHttpInterceptor();
    characterRemoteDataSource = CharacterRemoteDataSourceImpl(mockHttpClient);

    when(mockHttpInterceptor.addAuthParams())
        .thenReturn({'ts': '1', 'apikey': 'publicKey', 'hash': 'hash'});
  });

  group('CharacterRemoteDataSourceImpl', () {
    test('getCharacters retorna uma lista de personagens', () async {
      when(mockHttpClient.get(any, any))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final actualCharacters = await characterRemoteDataSource.getCharacters();
      final expectedCharacters = [
        const CharacterModel(
          id: 1017475,
          name: 'Iceman (X-Men: Battle of the Atom)',
          description: '',
          thumbnailPath:
              'http://i.annihil.us/u/prod/marvel/i/mg/9/70/52d72ac3c45f9',
          thumbnailExtension: 'jpg',
        ),
      ];

      // Assert
      expect(actualCharacters, expectedCharacters);
    });
    test('getCharacters lança uma exceção quando a resposta é um erro',
        () async {
      when(mockHttpClient.get(any, any))
          .thenAnswer((_) async => http.Response('Erro', 404));

      final call = characterRemoteDataSource.getCharacters;

      expect(() => call(), throwsA(isA<Exception>()));
    });
  });
}
