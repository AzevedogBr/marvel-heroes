import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:superherois/modules/home/domain/domain.dart';
import 'package:superherois/modules/home/data/data.dart';

import 'get_characters_test.mocks.dart';

@GenerateMocks([CharacterRepository])
void main() {
  late MockCharacterRepository mockCharacterRepository;
  late GetCharactersUsecase getCharactersUsecase;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    getCharactersUsecase = GetCharactersUsecase(mockCharacterRepository);
  });

  group('GetCharactersUsecase', () {
    test('retorna uma lista de personagens', () async {
      final characters = [
        Character(id: 1017475, name: 'Iceman', description: '', imageUrl: ''),
      ];
      when(mockCharacterRepository.getCharacters(limit: anyNamed('limit'), offset: anyNamed('offset'), name: anyNamed('name')))
          .thenAnswer((_) async => characters);


      final result = await getCharactersUsecase(limit: 10, offset: 0, name: 'Iceman');

      expect(result, characters);
    });

    test('lança uma exceção quando o repositório falha', () async {
      when(mockCharacterRepository.getCharacters(limit: anyNamed('limit'), offset: anyNamed('offset'), name: anyNamed('name')))
          .thenThrow(Exception('Erro ao buscar personagens'));

      final call = getCharactersUsecase;

      expect(() => call(limit: 10, offset: 0, name: 'Iceman'), throwsA(isA<Exception>()));
    });
  });
}