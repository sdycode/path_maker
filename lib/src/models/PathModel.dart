import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_maker/src/Data%20from%20String/offsetFromString.dart';
import 'package:path_maker/src/Data%20from%20String/sizeFromString.dart';
import 'package:path_maker/src/enum/enums.dart';
import 'package:path_maker/src/models/colorStopModel.dart';
import 'package:path_maker/src/models/curve_point.dart';

import 'dart:ui' as ui;

import 'package:path_maker/src/models/get_enums_to_fill_curvePointsList_from_map_data.dart';

class PathModel {
  int pathNo;
  String pathName;
  List<CurvePoint> points = [];
  Offset offsetFromOrigin = Offset.zero;
  bool continuousSweep = true;
  bool open;
  bool stroke;
  double strokeWidth = 3;
  double rad = 400;
  double focalRad = 0;
  double startSweepAngle = 0;
  double endSweepAngle = pi * 2;
  String hexColorString = "ffaa55";
  List<ColorStopModel> colorStopModels = [
    ColorStopModel(0.0, "fff8b249", 0),
    ColorStopModel(1.0, "fffee795", 0.0)
  ];
  Paint paint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;
  GradientType gradientType = GradientType.color;
  Offset linearFrom = Offset.zero;
  Offset linearTo = Offset(200, 200);
  Offset center = Offset(100, 100);
  Offset focalCenter = Offset(150, 150);
  Size size;
  TileMode tileMode;

  PathModel.withAllData(
      {required this.pathNo,
      required this.pathName,
      required this.points,
      required this.continuousSweep,
      required this.open,
      required this.stroke,
      required this.strokeWidth,
      required this.rad,
      required this.focalRad,
      required this.startSweepAngle,
      required this.endSweepAngle,
      required this.hexColorString,
      required this.colorStopModels,
      required this.paint,
      required this.gradientType,
      required this.linearFrom,
      required this.linearTo,
      required this.center,
      required this.focalCenter,
      required this.size,
      required this.tileMode,
      required this.offsetFromOrigin
      });
  PathModel.withCurvePoints(
    this.points, {
    required this.paint,
    this.stroke = false,
    this.open = false,
    this.pathName = "path",
    this.pathNo = 0,
    this.size = const Size(200, 200),
    this.tileMode = TileMode.clamp,
    this.startSweepAngle = 0,
    this.endSweepAngle = pi * 2,
    this.continuousSweep = true,
  });
  factory PathModel.copyWithoutPoints(PathModel pathModel) {
    return PathModel.withAllData(
        pathNo: pathModel.pathNo,
        pathName: pathModel.pathName,
        points: [],
        continuousSweep: pathModel.continuousSweep,
        open: pathModel.open,
        stroke: pathModel.stroke,
        strokeWidth: pathModel.strokeWidth,
        rad: pathModel.rad,
        focalRad: pathModel.focalRad,
        startSweepAngle: pathModel.startSweepAngle,
        endSweepAngle: pathModel.endSweepAngle,
        hexColorString: pathModel.hexColorString,
        colorStopModels: [
          ...pathModel.colorStopModels.map((e) {
            return ColorStopModel.copy(e);
          })
        ],
        paint: pathModel.paint,
        gradientType: pathModel.gradientType,
        linearFrom: pathModel.linearFrom,
        linearTo: pathModel.linearTo,
        center: pathModel.center,
        focalCenter: pathModel.focalCenter,
        size: pathModel.size,
        tileMode: pathModel.tileMode,
        offsetFromOrigin: pathModel.offsetFromOrigin
        );
  }
  PathModel.withoutPoints(
      {required this.paint,
      required this.stroke,
      required this.open,
      required this.pathName,
      required this.pathNo,
      required this.size,
      required this.tileMode});
  factory PathModel.fromJson(Map<String, dynamic> map) {
    return PathModel.withAllData(
        pathNo: map["pathNo"] as int,
        pathName: map["pathName"] as String,
        points: [
          ...((map["points"] as List).map((e) {
            return CurvePoint.fromCurvePointData(CurvePointData.fromJson(e));
          }))
        ],
        continuousSweep: map["continuousSweep"] as bool,
        open: map["open"] as bool,
        stroke: map["stroke"] as bool,
        strokeWidth: map["strokeWidth"] as double,
        rad: map["rad"] as double,
        focalRad: map["focalRad"] as double,
        startSweepAngle: map["startSweepAngle"] as double,
        endSweepAngle: map["endSweepAngle"] as double,
        hexColorString: map["hexColorString"] as String,
        colorStopModels: [
          ...((map["colorStopModels"] as List).map((e) {
            return ColorStopModel.fromJson(e);
          }))
        ],
        paint: Paint(),
        gradientType: getGradientTypeFromString(map["gradientType"] as String),
        linearFrom: offsetFromString(map["linearFrom"].toString()),
        linearTo: offsetFromString(map["linearTo"].toString()),
        center: offsetFromString(map["center"].toString()),
        focalCenter: offsetFromString(map["focalCenter"].toString()),
        size: sizeFromString(map["size"].toString()),
        tileMode: getTileModeFromString(map["tileMode"] as String),
        offsetFromOrigin: offsetFromString(map["offsetFromOrigin"].toString()));
  }
  Map<String, dynamic> toJson() {
    return {
      "pathNo": this.pathNo,
      "pathName": this.pathName,
      "points": [
        ...this.points.map((e) {
          return CurvePointData.fromCurvePoint(e).toStringNumJson();
        })
      ],
      "continuousSweep": this.continuousSweep,
      "open": this.open,
      "stroke": this.stroke,
      "strokeWidth": this.strokeWidth,
      "rad": this.rad,
      "focalRad": this.focalRad,
      "startSweepAngle": this.startSweepAngle,
      "endSweepAngle": this.endSweepAngle,
      "hexColorString": this.hexColorString,
      "colorStopModels": [
        ...this.colorStopModels.map((e) {
          return e.getJsonMapForColorStopModel(e);
        })
      ],
      "paint": this.paint.toString(),
      "gradientType": this.gradientType.toString(),
      "linearFrom": this.linearFrom.toString(),
      "linearTo": this.linearTo.toString(),
      "center": this.center.toString(),
      "focalCenter": this.focalCenter.toString(),
      "size": this.size.toString(),
      "tileMode": this.tileMode.toString(),
      "offsetFromOrigin": this.offsetFromOrigin.toString()
    };
  }
}
