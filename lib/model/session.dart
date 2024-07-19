class Session{
  int? id;
  String? courseCode;
  String? weekDay;
  String? startTime;
  String? sessionType;
  String? venue;

  Session({ this.courseCode, this.weekDay, this.startTime, this.sessionType, this.venue});

  Session.fromJson(Map<String,dynamic> map){
    id = map["id"];
    courseCode = map["courseCode"];
    weekDay = map['weekDay'];
    startTime= map['startTime'];
    sessionType = map['sessionType'];
    venue = map['venue'];
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = <String,dynamic>{};
    data['courseCode'] = courseCode;
    data['weekDay'] = weekDay;
    data['startTime'] = startTime;
    data['sessionType'] = sessionType;
    data['venue'] = venue;
    return data;
  }
}