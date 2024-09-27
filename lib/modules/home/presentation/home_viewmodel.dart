// lib/modules/home/presentation/home_viewmodel.dart
import 'package:flutter/material.dart';
import '../domain/domain.dart';
import 'home_state.dart';

class HomeViewmodel {
  final GetCharactersUsecase _getCharacters;
  final HomeState state;
  int _offset = 20;
  final int _limit = 20;

  HomeViewmodel(this._getCharacters)
      : state = HomeState(
          characters: ValueNotifier<List<Character>>([]),
          status: ValueNotifier<HomeStatus>(HomeStatus.success),
        );

  Future<void> fetchCharacters({String? name}) async {
    try {
      state.status.value = HomeStatus.loading;
      final result = await _getCharacters(limit: 20, name: name);
      state.characters.value = result;
      state.status.value = HomeStatus.success;
    } catch (e) {
      state.status.value = HomeStatus.error;
    }
  }

  Future<void> loadMoreCharacters() async {
    state.status.value = HomeStatus.loadingMore;
    final newCharacters = await _getCharacters.call(
      limit: _limit,
      offset: _offset,
    );
    state.characters.value = [...state.characters.value, ...newCharacters];
    _offset += _limit;
    state.status.value = HomeStatus.success;
  }
}
