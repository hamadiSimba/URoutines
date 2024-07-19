class Exam{
  int? id;
  String? courseCode;
  String? examType;
  String? venue;
  String? examDate;
  String? examPeriod;

  Exam({this.courseCode, this.examType, this.venue, this.examDate, this.examPeriod});

  Map<String,dynamic> toJson(){
    Map<String,dynamic> exam = Map<String,dynamic>();
    exam['courseCode'] = courseCode;
    exam['examType'] = examType;
    exam['venue'] = venue;
    exam['examDate'] = examDate;
    exam['examPeriod'] = examPeriod;
    return exam;
  }

  Exam.fromJson(Map<String,dynamic> map){
    id = map['id'];
    courseCode = map['courseCode'];
    examType = map['examType'];
    venue = map['venue'];
    examDate = map['examDate'];
    examPeriod = map['examPeriod'];
  }

}