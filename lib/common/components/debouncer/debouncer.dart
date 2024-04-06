import 'dart:async';

import 'package:flutter/cupertino.dart';

class Debouncer{
  final int milliseconds;
  Timer? debounce;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    if (debounce?.isActive ?? false) {
      debounce?.cancel();
    }
    debounce = Timer(Duration(milliseconds: milliseconds), action);
  }
}
