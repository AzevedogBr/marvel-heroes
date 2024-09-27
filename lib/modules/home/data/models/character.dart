import '../../domain/entities/character.dart';
import 'package:equatable/equatable.dart';

class CharacterModel extends Equatable {
  final int id;
  final String name;
  final String thumbnailPath;
  final String thumbnailExtension;
  final String description;

  const CharacterModel({
    required this.id,
    required this.name,
    required this.thumbnailPath,
    required this.thumbnailExtension,
    required this.description,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final thumbnail = json['thumbnail'] as Map<String, dynamic>;
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      thumbnailPath: thumbnail['path'],
      thumbnailExtension: thumbnail['extension'],
      description: json['description'] ?? '',
    );
  }

  Character toEntity() {
    return Character(
      id: id,
      name: name,
      imageUrl: '$thumbnailPath.$thumbnailExtension',
      description: description,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        thumbnailPath,
        thumbnailExtension,
      ];
}
