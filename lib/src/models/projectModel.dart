import 'package:path_maker/src/models/PathModel.dart';

class ProjectModel {
  String projectName;
  List<int> bgImage;
  List<PathModel> pathModels;

  ProjectModel({
    required this.projectName,
    required this.bgImage,
    required this.pathModels,
  });
  Map<String, dynamic> toJson() {
    return {
      "projectName": this.projectName,
      
      "pathModels": [
        ...(this.pathModels.map((e) {
          return e.toJson();
        }))
      ],"bgImage": this.bgImage,
    };
  }

  factory ProjectModel.fromJson(Map<String, dynamic> map) {
    return ProjectModel(
        projectName: map["projectName"],
        bgImage: map["bgImage"],
        pathModels: [map["pathModels"]]);
  }
}
