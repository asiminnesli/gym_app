import 'package:flutter/material.dart';

class UiHelper {
  double percentage(BuildContext context, double perc) {
    return MediaQuery.of(context).size.width * perc;
  }

  Gradient bgGradient() {
    return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [
          0,
          0.5,
          1
        ],
        colors: [
          Color(0xFF21243C),
          Color(0xFF414561),
          Color(0xFF21243C),
        ]);
  }
}
