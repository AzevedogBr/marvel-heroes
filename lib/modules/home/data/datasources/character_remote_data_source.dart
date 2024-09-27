import 'dart:convert';

import '../../../../core/infra/infra.dart';
import '../models/models.dart';

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> getCharacters({
    int? limit,
    int? offset,
    String? name,
  });
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final HttpClient httpClient;

  CharacterRemoteDataSourceImpl(this.httpClient);

  @override
  Future<List<CharacterModel>> getCharacters({
    int? limit,
    int? offset,
    String? name,
  }) async {
    try {
      final queryParameters = <String, String>{};
      if (limit != null) queryParameters['limit'] = limit.toString();
      if (offset != null) queryParameters['offset'] = offset.toString();
      if (name != null && name.isNotEmpty) {
        queryParameters['nameStartsWith'] = name;
      }

      final response = await httpClient.get(
        '/v1/public/characters',
        queryParameters,
      );
      final List<dynamic> data = jsonDecode(response.body)['data']['results'];
      return data.map((json) => CharacterModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
