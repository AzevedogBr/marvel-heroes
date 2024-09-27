import 'package:flutter/material.dart';

import 'di/di.dart';

abstract class BasePage<T extends StatefulWidget, V> extends State<T> {
  late final V viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = Injector().get<V>();
  }
}