import 'package:flutter/material.dart';

Offset offsetFromString(String offsetString) {
  try {
    offsetString = offsetString.replaceAll("Offset(", "").replaceAll(")", "");
    List<String> l = offsetString.split(",");
    if (l.length == 2) {
      return Offset(double.parse(l[0]), double.parse(l[1]));
    }
  } catch (e) {}
  return Offset.zero;
}
