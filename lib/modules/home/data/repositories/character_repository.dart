import '../../domain/domain.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters({
    int? limit,
    int? offset,
    String? name,
  });
}
