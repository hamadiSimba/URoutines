class Exams{
  int? id;
  String? courseCode;
  String? examDate;
  String? examPeriod;
  String? examType;
  String? venue;
  String? courseName;
  String? courseType;
  String? courseWeight;
  String? courseLecturer;
  bool isPassed = false;
  bool isHappening = false;

  Exams({this.id, this.courseCode, this.examDate, this.examPeriod, this.examType, this.venue, this.courseName,this.courseLecturer,this.courseType,this.courseWeight,});

  Exams.fromJson(Map<String,dynamic> map){
    id = map["id"];
    courseCode = map["courseCode"];
    examDate = map['examDate'];
    examPeriod = map['examPeriod'];
    examType = map['examType'];
    venue = map['venue'];
    courseName = map['courseName'];
    courseType = map['courseType'];
    courseWeight = map['courseWeight'].toString();
    courseLecturer = map['courseLecturer'];
  }

  
}