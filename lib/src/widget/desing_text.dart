import 'package:flutter/material.dart';

abstract class DesingText {
  static TextStyle botonGlobal = TextStyle(
    fontSize: 20,
    color: Colors.white,
  );
  static botonblobal(double? size, Color? color) {
    return TextStyle(
      fontSize: size,
      color: color,
    );
  }

  static regularText(double? size, Color? color) {
    return TextStyle(fontSize: size, color: color, fontFamily: "roboto");
  }

  static regularBoldText(double? size, Color? color) {
    return TextStyle(
        fontSize: size,
        color: color,
        fontFamily: "roboto",
        fontWeight: FontWeight.bold);
  }

  static sansBoldText(double? size, Color? color) {
    return TextStyle(fontSize: size, color: color, fontFamily: "sansBold");
  }
}
