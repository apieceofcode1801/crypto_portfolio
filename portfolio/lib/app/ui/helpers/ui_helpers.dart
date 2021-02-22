import 'dart:math';

import 'package:flutter/material.dart';

class UIHelpers {
  static Color generateRandomColor() {
    final random = Random();
    final red = random.nextInt(255);
    final green = random.nextInt(255);
    final blue = random.nextInt(255);
    // final alpha = random.nextInt(255);

    return Color.fromARGB(255, red, green, blue);
  }
}
