import '../../domain/domain.dart';
import '../datasources/datasources.dart';
import 'character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource _remoteDataSource;

  CharacterRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Character>> getCharacters({
    int? limit,
    int? offset,
    String? name,
  }) async {
    try {
      final characterModels = await _remoteDataSource.getCharacters(
        limit: limit,
        offset: offset,
        name: name,
      );
      return characterModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }
}
