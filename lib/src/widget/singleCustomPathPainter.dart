import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:path_maker/src/Data%20from%20String/getRectBoundaryPointsFromGivenPoints.dart';
import 'package:path_maker/src/models/PathModel.dart';
import 'package:path_maker/src/models/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:path_maker/src/widget/getShader.dart';


class SingleCustomPathPainter extends CustomPainter {
  int pathNo;
  Box box;
  PathModel pathModel;
  Size paintSize;
  SingleCustomPathPainter(
    this.pathNo,
    this.box, {
    required this.pathModel,
    required this.paintSize
  });

  @override
  void paint(Canvas canvas, Size s) {
    Shader? shader = getShader(pathModel.gradientType, pathModel, s, box);

    Paint paint = Paint()
      ..strokeWidth = pathModel.strokeWidth
      ..strokeCap = ui.StrokeCap.round
      ..shader = shader
      ..color = ui.Color(int.parse("0xff${pathModel.hexColorString}"))
      ..style = pathModel.stroke ? PaintingStyle.stroke : PaintingStyle.fill;
    Path path = Path();
    // log("pointslen in paint $pathNo :  ${pathModel.points.length}");
    if (pathModel.points.length < 2) {
      return;
    }

    for (var i = 1; i < pathModel.points.length; i++) {
      if (i == 1) {
        // &&pathModel.points[0].arcTypeOnPoint != ArcTypeOnPoint.arc
        path.moveTo(
            pathModel.points.first.point.dx, pathModel.points.first.point.dy);
        if (!pathModel.stroke) {
          path.moveTo(pathModel.points[i - 1].postArcEndPoint.dx,
              pathModel.points[i - 1].postArcEndPoint.dy);
        }
      } else {}
      if (pathModel.points[i - 1].postPointCurveType ==
          PostPointCurveType.arc) {
        // move to
        path.lineTo(pathModel.points[i - 1].postArcEndPoint.dx,
            pathModel.points[i - 1].postArcEndPoint.dy);
      } else {
        // move to
        path.lineTo(
            pathModel.points[i - 1].point.dx, pathModel.points[i - 1].point.dy);
      }
      int nextIndex = (i + 1) % pathModel.points.length;
      int preIndex = i - 1;
      Offset p = pathModel.points[i].point;
      Offset pre = pathModel.points[i].prePoint;
      Offset postPoint = pathModel.points[i].postPoint;
      Offset preArcEnd = pathModel.points[i].preArcEndPoint;
      Offset postArcEnd = pathModel.points[i].postArcEndPoint;
      Offset prePost = pathModel.points[i - 1].postPoint;
      Offset nextPoint = pathModel.points[nextIndex].point;

      // Check next of arc  point is cubic bezier ( and make pre point of next as quad from cubic)

      if (pathModel.points[i].arcTypeOnPoint == ArcTypeOnPoint.arc) {
        if (pathModel.points[nextIndex].prePointCurveType ==
            PrePointCurveType.cubicBezier) {
          pathModel.points[nextIndex].prePointCurveType =
              PrePointCurveType.quadBezier;
        }
      }

      if (pathModel.points[i].prePointCurveType == PrePointCurveType.normal) {
        path.lineTo(p.dx, p.dy);
      } else if (pathModel.points[i].prePointCurveType ==
          PrePointCurveType.quadBezier) {
        path.quadraticBezierTo(pre.dx, pre.dy, p.dx, p.dy);
        if (pathModel.points[nextIndex].arcTypeOnPoint ==
            ArcTypeOnPoint.normal) {
          path.quadraticBezierTo(
              postPoint.dx, postPoint.dy, nextPoint.dx, nextPoint.dy);
          i++;
        }
      } else if (pathModel.points[i].prePointCurveType ==
          PrePointCurveType.cubicBezier) {
        path.cubicTo(prePost.dx, prePost.dy, pre.dx, pre.dy, p.dx, p.dy);
      } else if (pathModel.points[i].prePointCurveType ==
          PrePointCurveType.arc) {
        if (pathModel.points[i - 1].postPointCurveType ==
            PostPointCurveType.quadBezier) {
          path.quadraticBezierTo(
              prePost.dx, prePost.dy, preArcEnd.dx, preArcEnd.dy);
        }
        path.lineTo(preArcEnd.dx, preArcEnd.dy);
        path.arcToPoint(postArcEnd,
            radius: Radius.circular(pathModel.points[i].arcRadius),
            clockwise: pathModel.points[i].isArcClockwise);

        // i++;
        // path.lineTo(nextPoint, y)
        // canvas.drawPoints(
        //     ui.PointMode.points,
        //     [preArcEnd, postArcEnd],
        //     Paint()
        //       ..color = Colors.amber
        //       ..strokeWidth = 6);
      }
    }
    if (!pathModel.open) {
      Offset pLast = pathModel.points[0].point;
      Offset preLast = pathModel.points[0].prePoint;
      Offset preArcEnd = pathModel.points[0].preArcEndPoint;
      Offset postArcEnd = pathModel.points[0].postArcEndPoint;
      Offset prePostLast = pathModel.points.last.postPoint;

      int nextIndex = 1;

      if (pathModel.points[0].arcTypeOnPoint == ArcTypeOnPoint.arc) {
        if (pathModel.points[nextIndex].prePointCurveType ==
            PrePointCurveType.cubicBezier) {
          pathModel.points[nextIndex].prePointCurveType =
              PrePointCurveType.quadBezier;
        }
      }
      if (pathModel.points[0].prePointCurveType == PrePointCurveType.normal) {
        path.lineTo(pLast.dx, pLast.dy);
      } else if (pathModel.points[0].prePointCurveType ==
          PrePointCurveType.quadBezier) {
        path.quadraticBezierTo(preLast.dx, preLast.dy, pLast.dx, pLast.dy);
        if (pathModel.points[1].arcTypeOnPoint == ArcTypeOnPoint.normal) {
          Offset postPoint = pathModel.points[0].postPoint;
          Offset nextPoint = pathModel.points[1].point;
          path.quadraticBezierTo(
              postPoint.dx, postPoint.dy, nextPoint.dx, nextPoint.dy);
          // i++;
        }
      } else if (pathModel.points[0].prePointCurveType ==
          PrePointCurveType.cubicBezier) {
        path.cubicTo(prePostLast.dx, prePostLast.dy, preLast.dx, preLast.dy,
            pLast.dx, pLast.dy);
      } else if (pathModel.points[0].prePointCurveType ==
          PrePointCurveType.arc) {
        path.lineTo(preArcEnd.dx, preArcEnd.dy);
        path.arcToPoint(postArcEnd,
            radius: Radius.circular(pathModel.points[0].arcRadius),
            clockwise: pathModel.points[0].isArcClockwise);
        // canvas.drawPoints(
        //     ui.PointMode.points,
        //     [preArcEnd, postArcEnd],
        //     Paint()
        //       ..color = Colors.amber
        //       ..strokeWidth = 6);
      }

      if (!pathModel.stroke) {
        path.close();
      }
    }
    //   offset: pathModels[i].offsetFromOrigin,
    canvas.translate(
        pathModel.offsetFromOrigin.dx, pathModel.offsetFromOrigin.dy);
    double widthFactor =  s.width/paintSize.width ;
    double heightFactor = s.height/ paintSize.height ;
    canvas.scale(widthFactor, heightFactor);
    canvas.drawPath(path, paint);

    //  canvas.scale(100,200);
   

   
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
