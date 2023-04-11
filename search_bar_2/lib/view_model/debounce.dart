import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int milliseconds;
  //VoidCallback? _callback;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
