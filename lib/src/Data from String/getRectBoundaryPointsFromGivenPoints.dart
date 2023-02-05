import 'dart:math';

import 'package:flutter/material.dart';

List<Offset> getRectBoundaryPointsFromGivenPoints(List<Offset> points) {
  if (points.isEmpty) {
    return List.generate(4, (index) => Offset.zero);
  }
  if (points.length == 1) {
    return List.generate(4, (index) => points.first);
  }
  double minx = points.first.dx;
  double maxx = points.first.dx;
  double miny = points.first.dy;
  double maxy = points.first.dy;
  for (var i = 1; i < points.length; i++) {
    minx = min(minx, points[i].dx);
    miny = min(miny, points[i].dy);
    maxx = max(maxx, points[i].dx);
    maxy = max(maxy, points[i].dy);
  }
  return [
    Offset(minx, miny),
    Offset(maxx, miny),
    Offset(maxx, maxy),
    Offset(minx, maxy),
  ];
}

Box getBoxForPoints(List<Offset> points) {
  if (points.isEmpty) {
    return Box(0, 0, Offset.zero);
  }
  if (points.length == 1) {
    return Box(0, 0, points.first);
  }
  double minx = points.first.dx;
  double maxx = points.first.dx;
  double miny = points.first.dy;
  double maxy = points.first.dy;
  for (var i = 1; i < points.length; i++) {
    minx = min(minx, points[i].dx);
    miny = min(miny, points[i].dy);
    maxx = max(maxx, points[i].dx);
    maxy = max(maxy, points[i].dy);
  }
  return Box(
      (maxx - minx).abs(),
      (maxy - miny).abs(),
      Offset(
          minx + (maxx - minx).abs() * 0.5, miny + (maxy - miny).abs() * 0.5));
}

class Box {
  double width;
  double height;
  Offset center;
  Box(this.width, this.height, this.center);
}
