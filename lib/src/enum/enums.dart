import 'package:flutter/material.dart';

enum GradientType { linear, radial, sweep, color }

enum GradientTypesOnly { linear, radial, sweep }

enum BackgroundImageStatus { none, file, memory, asset, network }

enum FileOptions { open, save, saveas }

GradientType getGradientTypeFromString(String gradString) {
  switch (gradString) {
    case"GradientType.color":
      return GradientType.color;
      break;
    case "GradientType.sweep":
      return GradientType.sweep;
      break;
    case "GradientType.radial":
      return GradientType.radial;
      break;
    case "GradientType.linear":
      return GradientType.linear;
      break;
    default:
      return GradientType.color;
  }
}


TileMode getTileModeFromString(String tileString){
    switch (tileString) {
    case"TileMode.clamp":
      return TileMode.clamp;
      break;
    case "TileMode.decal":
      return TileMode.decal;
      break;
    case "TileMode.repeated":
      return TileMode.repeated;
      break;
    case "TileMode.mirror":
      return TileMode.mirror;
      break;
    default:
      return TileMode.clamp;
  }
}