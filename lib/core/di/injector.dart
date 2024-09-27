
import 'dart:collection';

class Injector {
  static final Injector _singleton = Injector._internal();
  final _instances = HashMap<Type, dynamic>();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  void register<T>(T instance) {
    _instances[T] = instance;
  }

  T get<T>() {
    return _instances[T] as T;
  }
}