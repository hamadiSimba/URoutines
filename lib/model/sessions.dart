class Sessions{
  int? id;
  String? courseCode;
  String? weekDay;
  String? startTime;
  String? sessionType;
  String? venue;
  String? courseName;
  String? courseType;
  String? courseWeight;
  String? courseLecturer;
  bool isPassed = false;
  bool isHappening = false;

  Sessions({this.id, this.courseCode, this.weekDay, this.startTime, this.sessionType, this.venue, this.courseName,this.courseLecturer,this.courseType,this.courseWeight,});

  Sessions.fromJson(Map<String,dynamic> map){
    id = map["id"];
    courseCode = map["courseCode"];
    weekDay = map['weekDay'];
    startTime= map['startTime'];
    sessionType = map['sessionType'];
    venue = map['venue'];
    courseName = map['courseName'];
    courseType = map['courseType'];
    courseWeight = map['courseWeight'].toString();
    courseLecturer = map['courseLecturer'];
  }

  
}