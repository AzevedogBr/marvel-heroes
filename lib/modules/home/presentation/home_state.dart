import 'package:flutter/material.dart';

import '../domain/domain.dart';

enum HomeStatus {
  loading,
  success,
  loadingMore,
  error,
}

class HomeState {
  final ValueNotifier<List<Character>> characters;
  final ValueNotifier<HomeStatus> status;

  HomeState({
    required this.characters,
    required this.status,
  });
}