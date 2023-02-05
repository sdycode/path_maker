class ColorStopModel {
  double colorStop;
  String hexColorString;
  double left;
  ColorStopModel(this.colorStop, this.hexColorString, this.left);
  ColorStopModel.withStopValue(this.colorStop,
      [this.hexColorString = "ffffffff", this.left = 0]);
  factory ColorStopModel.copy(ColorStopModel model) {
    return ColorStopModel(model.colorStop, model.hexColorString, model.left);
  }
  factory ColorStopModel.fromJson(Map<String, dynamic> map) {
    return ColorStopModel((map["colorStop"]as num).toDouble(),
        map["hexColorString"], (map["left"]as num).toDouble());
  }
  Map<String, dynamic> getJsonMapForColorStopModel(ColorStopModel c) {
    return {
      "colorStop": colorStop,
      "hexColorString": hexColorString,
      "left": left
    };
  }
}


