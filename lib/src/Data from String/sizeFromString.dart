import 'package:flutter/material.dart';

Size sizeFromString(String sizeString) {  try {
    sizeString = sizeString.replaceAll("Size(", "").replaceAll(")", "");
    List<String> l = sizeString.split(",");
    if (l.length == 2) {
      return Size(double.parse(l[0]), double.parse(l[1]));
    }
  } catch (e) {}
  
  return Size(200, 200);
}
