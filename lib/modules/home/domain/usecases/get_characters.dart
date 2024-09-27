import '../../data/data.dart';
import '../entities/entities.dart';

class GetCharactersUsecase {
  final CharacterRepository _repository;

  GetCharactersUsecase(this._repository);

  Future<List<Character>> call({
    int? limit,
    int? offset,
    String? name,
  }) async {
    final characterModels = await _repository.getCharacters(
      limit: limit,
      offset: offset,
      name: name,
    );
    return characterModels;
  }
}
