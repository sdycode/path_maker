import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_maker/src/Data%20from%20String/getRectBoundaryPointsFromGivenPoints.dart';
import 'package:path_maker/src/Data%20from%20String/sizeFromString.dart';
import 'package:path_maker/src/models/PathModel.dart';
import 'package:path_maker/src/models/curve_point.dart';
import 'package:path_maker/src/widget/getPathModelFromMap.dart';
import 'package:path_maker/src/widget/singleCustomPathPainter.dart';


class CustomPathPainterFromAsset extends StatefulWidget {
  final String filePath;
  final Size size;
  final Widget? child;
  final Color? bgColor;
  const CustomPathPainterFromAsset(
      {super.key,
      required this.filePath,
      required this.size,
      this.child,
      this.bgColor});

  @override
  State<CustomPathPainterFromAsset> createState() =>
      _CustomPathPainterFromAssetState();
}

class _CustomPathPainterFromAssetState
    extends State<CustomPathPainterFromAsset> {
  Size paintSize = Size(200, 200);
  List<CurvePoint> _points = [];
  int pathModelIndex = 0;
  Uint8List? _pickedImageData;
  String errorMessage = "";
  List<PathModel> _pathModels = [
    // PathModel.withCurvePoints(_points,
    //     paint: Paint()..color = Colors.primaries.first, pathName: "path0")
  ];
  void _openAndLoadFileFromAsset() async {
    paintSize = Size(widget.size.width, widget.size.height);
    String preJsonString = "preJsonString";
    try {
      if (!widget.filePath.contains('.json')) {
        errorMessage = "Only Json File Allowed";
        Fluttertoast.showToast(
            msg: "Please select json file", toastLength: Toast.LENGTH_LONG);
      }
      Uint8List bytes = Uint8List(8);

      try {
        bytes = (await rootBundle.load(widget.filePath)).buffer.asUint8List();
        // log("bytess $bytes");
      } catch (e) {
        errorMessage = "Incorrect Path";
      }

      preJsonString = String.fromCharCodes(bytes);
      // log("preJsonString $preJsonString");
      // // log("err preJsonString ${file.extension}  etxte/ $preJsonString");
      Map jsonData = {};
      try {
        jsonData = jsonDecode(preJsonString);
      } catch (e) {
        errorMessage = "Problem In JsonDecode";
        // // log("err preJsonString jsonData err $e / $jsonData");
      }

      // // log("err preJsonString jsonData $jsonData");
      try {
        List l = jsonData["pathModels"];
        _pathModels.clear();
        Map firstMap = l.first as Map;
        int pn = 0;

        l.forEach((e) {
          PathModel? pathModel = getPathModelFromMap(e);
          // log("pointslen pnp $pn : ${pathModel!.points.length}");
          pn++;

          // resetColorStopPositiontoLastForGivenPathModel(pathModel);
          _pathModels.add(pathModel!);
          // showHidePaths.add(true);
          // log("pathss ${_pathModels.length}");
        });
        // _pathModels.reversed;
        try {
          // // log("img ${jsonData['bgImage'] as List<int>.runtimeType}");
          _pickedImageData = Uint8List.fromList(
              (jsonData['bgImage'] as List).map((e) => (e as int)).toList());
        } catch (e) {}

        try {
          log("paintsize  $paintSize : ${jsonData["size"]}");
          paintSize = jsonData["size"] != null
              ? sizeFromString(jsonData["size"])
              : widget.size;
          log("paintsize  after $paintSize : ${jsonData["size"]}");
        } catch (e) {
          log("paintsize  errr $paintSize : ${e}");
        }
        pathModelIndex = 0;
        _points = List.from(_pathModels[pathModelIndex].points);
        if (mounted) {
          setState(() {
            errorMessage = "";
          });
        }
      } catch (e) {
        // log("err $e");
        Fluttertoast.showToast(
            msg: "Json has incorrect data", toastLength: Toast.LENGTH_LONG);
        errorMessage = "Json has incorrect data";
        if (mounted) {
          setState(() {});
        }
      }

      return;
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _openAndLoadFileFromAsset();
  }

  @override
  Widget build(BuildContext context) {
    log("lenggg ${_pathModels.length}");
    return AspectRatio(
      aspectRatio: 1.8,
      child: Container(
        width: widget.size.width,
        height: widget.size.height,
        // color: widget.bgColor,
        color: Colors.purple.shade100,
        child: errorMessage.isEmpty && _pathModels.isNotEmpty
            ? Stack(
                children: [
                  // for(PathModel pathModel in _pathModels) _DemoPainter(pathNo, box, pathModel: pathModel)
                  ...List.generate(
                    _pathModels.length,
                    (index) => Container(
                      width: double.infinity,
                      height: double.infinity,
                      // color: Colors.yellow.shade100.withAlpha(150),
                      child: CustomPaint(
                          painter: SingleCustomPathPainter(
                              index,
                              pathModel: _pathModels[index],
                              getBoxForPoints(_pathModels[index]
                                  .points
                                  .map((e) => e.point)
                                  .toList()),
                              paintSize: paintSize)),
                    ),
                  )
                ],
              )
            : Center(
                child: Text(errorMessage),
              ),
      ),
    );
  }
}
