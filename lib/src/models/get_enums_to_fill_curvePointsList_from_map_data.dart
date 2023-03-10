import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_maker/src/models/curve_point.dart';

enum PrePointCurveType {
  normal,
  arc,

  quadBezier,
  cubicBezier,
}

enum PostPointCurveType {
  normal,
  arc,

  quadBezier,
  cubicBezier,
}

enum PointPosition { normal, start, end }

enum PointSymmetry { angleSymmetry, allSymmetry, nonSymmetric }

enum ArcTypeOnPoint { normal, arc, symmetric, angleSymmetric, nonSymmetric }

class GetEnumsUsedInCurvePoint {
  static PrePointCurveType getEnum_PrePointCurveType(String data) {
    //log("getEnum_PrePointCurveType data $data");
    data = data.replaceAll("PrePointCurveType.", '').trim();
    //log("getEnum_PrePointCurveType data $data");
    switch (data) {
      case "normal":
        return PrePointCurveType.normal;
        break;
      case "arc":
        return PrePointCurveType.arc;
        break;
      case "quadBezier":
        return PrePointCurveType.quadBezier;
        break;
      case "cubicBezier":
        return PrePointCurveType.cubicBezier;
        break;

      default:
        return PrePointCurveType.normal;
    }
  }

  static PostPointCurveType getEnum_PostPointCurveType(String data) {
    //log("getEnum_PostPointCurveType data $data");
    data = data.replaceAll("PostPointCurveType.", '').trim();
    //log("getEnum_PostPointCurveType data $data");
    switch (data) {
      case "normal":
        return PostPointCurveType.normal;
        break;
      case "arc":
        return PostPointCurveType.arc;
        break;
      case "quadBezier":
        return PostPointCurveType.quadBezier;
        break;
      case "cubicBezier":
        return PostPointCurveType.cubicBezier;
        break;

      default:
        return PostPointCurveType.normal;
    }
  }

  static PointPosition getEnum_PointPositione(String data) {
    //log("getEnum_PointPositione data $data");
    data = data.replaceAll("PointPosition.", '').trim();
    //log("getEnum_PointPositione data $data");
    switch (data) {
      case "normal":
        return PointPosition.normal;
        break;
      case "start":
        return PointPosition.start;
        break;
      case "end":
        return PointPosition.end;
        break;

      default:
        return PointPosition.normal;
    }
  }

  static PointSymmetry getEnum_PointSymmetry(String data) {
    //log("getEnum_PointSymmetry data $data");
    data = data.replaceAll("PointSymmetry.", '').trim();
    //log("getEnum_PointSymmetry data $data");
    switch (data) {
      case "angleSymmetry":
        return PointSymmetry.angleSymmetry;
        break;
      case "allSymmetry":
        return PointSymmetry.allSymmetry;
        break;
      case "nonSymmetric":
        return PointSymmetry.nonSymmetric;
        break;

      default:
        return PointSymmetry.angleSymmetry;
    }
  }

  static ArcTypeOnPoint getEnum_ArcTypeOnPoint(String data) {
    //log("getEnum_ArcTypeOnPoint data $data");
    data = data.replaceAll("ArcTypeOnPoint.", '').trim();
    //log("getEnum_ArcTypeOnPoint data $data");
    switch (data) {
      case "normal":
        return ArcTypeOnPoint.normal;
        break;
      case "arc":
        return ArcTypeOnPoint.arc;
        break;
      case "symmetric":
        return ArcTypeOnPoint.symmetric;
        break;
      case "angleSymmetric":
        return ArcTypeOnPoint.angleSymmetric;
        break;
      case "nonSymmetric":
        return ArcTypeOnPoint.nonSymmetric;
        break;

      default:
        return ArcTypeOnPoint.normal;
    }
  }
}

class CurvePointData {
  int? i;
  double? pX;
  double? pY;
  PointPosition? pP;
  PrePointCurveType? prPCT;
  PostPointCurveType? psPCT;
  double? prX;
  double? prY;
  double? psX;
  double? psY;
  double? prAEX;
  double? prAEY;
  double? psAEX;
  double? psAEY;
  double? r;
  double? tr;
  bool? cl;
  PointSymmetry? pS;
  ArcTypeOnPoint? aTP;

  CurvePointData(
      {this.i,
      this.pX,
      this.pY,
      this.pP,
      this.prPCT,
      this.psPCT,
      this.prX,
      this.prY,
      this.psX,
      this.psY,
      this.prAEX,
      this.prAEY,
      this.psAEX,
      this.psAEY,
      this.r,
      this.tr,
      this.cl,
      this.pS,
      this.aTP});
  factory CurvePointData.fromCurvePoint(CurvePoint p) {
    return CurvePointData(
      i: p.index,
      pX: p.point.dx,
      pY: p.point.dy,
      pP: p.pointPosition,
      prPCT: p.prePointCurveType,
      psPCT: p.postPointCurveType,
      prX: p.prePoint.dx,
      prY: p.prePoint.dy,
      psX: p.postPoint.dx,
      psY: p.postPoint.dy,
      prAEX: p.preArcEndPoint.dx,
      prAEY: p.preArcEndPoint.dy,
      psAEX: p.postArcEndPoint.dx,
      psAEY: p.postArcEndPoint.dy,
      r: p.arcRadius,
      tr: p.tempArcRadius,
      cl: p.isArcClockwise,
      pS: p.pointSymmetry,
      aTP: p.arcTypeOnPoint,
    );
  }
  CurvePointData.fromModifedJson(Map<String, dynamic> json) {
    i = json['i'] ?? 0;
    pX = (((json['pX'] ) ?? 0.0) as num).toDouble();
    pY = (((json['pY']) ?? 0.0)as num) .toDouble();
    pP = GetEnumsUsedInCurvePoint.getEnum_PointPositione(json['pP'] as String);
    prPCT = GetEnumsUsedInCurvePoint.getEnum_PrePointCurveType(
        json['prPCT'] as String);
    psPCT = GetEnumsUsedInCurvePoint.getEnum_PostPointCurveType(
        json['psPCT'] as String);
    prX = ((json['prX'] ?? 0.0)as num).toDouble();
    prY = ((json['prY'] ?? 0.0)as num).toDouble();
    psX = ((json['psX'] ?? 0.0)as num).toDouble();
    psY = ((json['psY'] ?? 0.0)as num).toDouble();
    prAEX = ((json['prAEX'] ?? 0.0)as num).toDouble();
    prAEY = ((json['prAEY'] ?? 0.0)as num).toDouble();
    psAEX = ((json['psAEX'] ?? 0.0)as num).toDouble();
    psAEY = ((json['psAEY'] ?? 0.0)as num).toDouble();
    r =  ((json['r'] ?? 0.0)as num).toDouble();
    tr = ((json['tr'] ?? 0.0)as num).toDouble();
    cl = json['cl'] == true ? true : false;
    pS = GetEnumsUsedInCurvePoint.getEnum_PointSymmetry(json['pS'] as String);
    aTP =
        GetEnumsUsedInCurvePoint.getEnum_ArcTypeOnPoint(json['aTP'] as String);
  }
  CurvePointData.fromJson(Map<String, dynamic> json) {
    i = int.tryParse(json['i'] as String) ?? 0;
    pX = double.tryParse(json['pX'] as String) ?? 0.0;
    pY = double.tryParse(json['pY'] as String) ?? 0.0;
    pP = GetEnumsUsedInCurvePoint.getEnum_PointPositione(json['pP'] as String);
    prPCT = GetEnumsUsedInCurvePoint.getEnum_PrePointCurveType(
        json['prPCT'] as String);
    psPCT = GetEnumsUsedInCurvePoint.getEnum_PostPointCurveType(
        json['psPCT'] as String);
    prX = double.tryParse(json['prX'] as String) ?? 0.0;
    prY = double.tryParse(json['prY'] as String) ?? 0.0;
    psX = double.tryParse(json['psX'] as String) ?? 0.0;
    psY = double.tryParse(json['psY'] as String) ?? 0.0;
    prAEX = double.tryParse(json['prAEX'] as String) ?? 0.0;
    prAEY = double.tryParse(json['prAEY'] as String) ?? 0.0;
    psAEX = double.tryParse(json['psAEX'] as String) ?? 0.0;
    psAEY = double.tryParse(json['psAEY'] as String) ?? 0.0;
    r = double.tryParse(json['r'] as String) ?? 0.0;
    tr = double.tryParse(json['tr'] as String) ?? 0.0;
    cl = (json['cl'] as String) == "true" ? true : false;
    pS = GetEnumsUsedInCurvePoint.getEnum_PointSymmetry(json['pS'] as String);
    aTP =
        GetEnumsUsedInCurvePoint.getEnum_ArcTypeOnPoint(json['aTP'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['i'] = this.i;
    data['pX'] = this.pX;
    data['pY'] = this.pY;
    data['pP'] = this.pP;
    data['prPCT'] = this.prPCT;
    data['psPCT'] = this.psPCT;
    data['prX'] = this.prX;
    data['prY'] = this.prY;
    data['psX'] = this.psX;
    data['psY'] = this.psY;
    data['prAEX'] = this.prAEX;
    data['prAEY'] = this.prAEY;
    data['psAEX'] = this.psAEX;
    data['psAEY'] = this.psAEY;
    data['r'] = this.r;
    data['tr'] = this.tr;
    data['cl'] = this.cl;
    data['pS'] = this.pS;
    data['aTP'] = this.aTP;
    return data;
  }

  Map<String, dynamic> toStringNumJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['i'] = this.i;
    data['pX'] = this.pX;
    data['pY'] = this.pY;
    data['pP'] = this.pP.toString();
    data['prPCT'] = this.prPCT.toString();
    data['psPCT'] = this.psPCT.toString();
    data['prX'] = this.prX;
    data['prY'] = this.prY;
    data['psX'] = this.psX;
    data['psY'] = this.psY;
    data['prAEX'] = this.prAEX;
    data['prAEY'] = this.prAEY;
    data['psAEX'] = this.psAEX;
    data['psAEY'] = this.psAEY;
    data['r'] = this.r;
    data['tr'] = this.tr;
    data['cl'] = this.cl.toString();
    data['pS'] = this.pS.toString();
    data['aTP'] = this.aTP.toString();
    return data;
  }
}

class GetPointsDataFromJson {
  static List<CurvePoint> createCurvePointsListFromJson(
      Map<String, List<Map<String, String>>> map) {
    List<CurvePoint> points = [];
    if (map.values.isNotEmpty) {
      map.values.first.forEach((Map<String, String> e) {
        CurvePointData d = CurvePointData.fromJson(e);

        points.add(CurvePoint.fromCurvePointData(d));
      });
    }
    return points;
  }

  static Map<String, List<Map<String, String>>> getMapForPointsof1Path(
      File file) {
    String data = file.readAsStringSync();
    Map<String, List<Map<String, String>>> map = {};
    try {
      map = json.decode(data);
    } catch (e) {}

    return map;
  }
}

Map<String, String> shortToLongMap = {
  "i": "index",
  "pX": "pointX",
  "pY": "pointY",
  "pP": "pointPosition",
  "prPCT": "prePointCurveType",
  "psPCT": "postPointCurveType",
  "prX": "prePointX",
  "prY": "prePointY",
  "psX": "postPointX",
  "psY": "postPointY",
  "prAEX": "preArcEndPointX",
  "prAEY": "preArcEndPointY",
  "psAEX": "postArcEndPointX",
  "psAEY": "postArcEndPointY",
  "r": "arcRadius",
  "tr": "tempArcRadius",
  "cl": "isArcClockwise",
  "pS": "pointSymmetry",
  "aTP": "arcTypeOnPoint",
};

Map<String, String> LongToshortMap = {
  "index": "i",
  "pointX": "pX",
  "pointY": "pY",
  "pointPosition": "pP",
  "prePointCurveType": "prPCT",
  "postPointCurveType": "psPCT",
  "prePointX": "prX",
  "prePointY": "prY",
  "postPointX": "psX",
  "postPointY": "psY",
  "preArcEndPointX": "prAEX",
  "preArcEndPointY": "prAEY",
  "postArcEndPointX": "psAEX",
  "postArcEndPointY": "psAEY",
  "arcRadius": "r",
  "tempArcRadius": "tr",
  "isArcClockwise": "cl",
  "pointSymmetry": "pS",
  "arcTypeOnPoint": "aTP",
};
void main() {
  List<String> l = [
    "index",
    "point",
    "pointPosition",
    "prePointCurveType",
    "postPointCurveType",
    "prePoint",
    "postPoint",
    "preArcEndPoint",
    "postArcEndPoint",
    "arcRadius",
    "tempArcRadius",
    "isArcClockwise",
    "preLength",
    "postLength",
    "preAngle",
    "postAngle",
    "pointSymmetry",
    "arcTypeOnPoint"
  ];

  shortToLongMap.forEach((key, value) {
    print("$key : p.${value},");
    //  i: p.index,
  });
  // l.forEach((e) {
  //   print('"$e": "\${p.${e}.toString()}", ');
  // });
  // shortToLongMap.forEach((key, value) {
  //   print('"$value": "$key",');
  // });
  return;
//
  List<ArcTypeOnPoint> values = ArcTypeOnPoint.values;
  String total = "";
  for (var i = 0; i < values.length; i++) {
    total += ''' 
       case "${values[i].toString().split('.')[1]}":
        return ${values[i]};
        break;\n''';
//       print(total);
  }
  print('''
  switch (data) {
$total
default:
 return ${values[0]};
    }
''');
}
