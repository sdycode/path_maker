import 'package:flutter/material.dart';
import 'package:path_maker/src/Data%20from%20String/getRectBoundaryPointsFromGivenPoints.dart';
import 'package:path_maker/src/Data%20from%20String/matrix.dart';
import 'package:path_maker/src/models/PathModel.dart';

import 'dart:ui' as ui;

import '../enum/enums.dart';

ui.Shader? getShader(
    GradientType gradientType, PathModel pathModel, Size s, Box box) {
  switch (gradientType) {
    case GradientType.color:
      return null;
    case GradientType.linear:
      return ui.Gradient.linear(
        pathModel.linearFrom,
        pathModel.linearTo,
        [
          ...pathModel.colorStopModels
              .map((e) => Color(int.parse("0x${e.hexColorString}")))
        ],
        [...pathModel.colorStopModels.map((e) => e.colorStop)],
        pathModel.tileMode,
      );
    case GradientType.radial:
      return ui.Gradient.radial(
          pathModel.center,
          pathModel.rad,
          [
            ...pathModel.colorStopModels
                .map((e) => Color(int.parse("0x${e.hexColorString}")))
          ],
          [...pathModel.colorStopModels.map((e) => e.colorStop)],
          pathModel.tileMode,
          idenityFloat64List(),
          pathModel.focalCenter,
          pathModel.focalRad);
    case GradientType.sweep:
      return ui.Gradient.sweep(
        pathModel.center,
        pathModel.continuousSweep
            ? [
                ...pathModel.colorStopModels
                    .map((e) => Color(int.parse("0x${e.hexColorString}"))),
                Color(int.parse(
                    "0x${pathModel.colorStopModels.first.hexColorString}"))
              ]
            : [
                ...pathModel.colorStopModels
                    .map((e) => Color(int.parse("0x${e.hexColorString}")))
              ],
        pathModel.continuousSweep
            ? [
                0.0,
                ...pathModel.colorStopModels
                    .sublist(1, pathModel.colorStopModels.length - 1)
                    .map((e) {
                  return e.colorStop;
                }),
                pathModel.colorStopModels.last.colorStop,
                1.0
              ]
            : [...pathModel.colorStopModels.map((e) => e.colorStop)],
        pathModel.tileMode,
        pathModel.startSweepAngle,
        pathModel.endSweepAngle,
      );
    default:
      return ui.Gradient.linear(Offset.zero, ui.Offset(s.width, s.height), [
        Colors.red,
        Colors.yellow,
      ]);
  }
}
