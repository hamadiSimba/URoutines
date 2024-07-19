class Modules{
  int? id;
  String? courseName;
  String? courseCode;
  String? courseType;
  String? courseWeight;
  String? courseLecturer;
  bool isPassed = false;
  bool isHappening = false;

  Modules.fromJson(Map<String,dynamic> map){
    id = map["id"];
    courseName = map["courseName"];
    courseCode = map['courseCode'];
    courseType = map['courseType'];
    courseWeight = map['courseWeight'].toString();
    courseLecturer = map['courseLecturer'];
  }

  Modules({ this.courseName, this.courseCode, this.courseType, this.courseWeight, this.courseLecturer});

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = <String,dynamic>{};
    data['courseName'] = courseName;
    data['courseCode'] = courseCode;
    data['courseType'] = courseType;
    data['courseWeight'] = courseWeight;
    data['courseLecturer'] = courseLecturer;
    return data;
  }


  

}

