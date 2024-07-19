class AssignmentsDetails {
  int? id;
  String? courseCode;
  String? assignmentType;
  String? dueDate;
  String? question;
  String? courseName;
  String? courseType;
  String? courseWeight;
  String? courseLecturer;
  int? isOpened = 0;
  int? isDone = 0;

  AssignmentsDetails(
      {this.courseCode,
      this.question,
      this.assignmentType,
      this.dueDate,
      this.courseName,
      this.courseLecturer,
      this.courseType,
      this.courseWeight,
      isDone = 0,
      isOpened = 0});

  AssignmentsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseCode = json['courseCode'];
    assignmentType = json['assignmentType'];
    dueDate = json['dueDate'];
    isOpened = json['isOpened'];
    isDone = json['isDone'];
    question = json['question'];
    courseName = json['courseName'];
    courseLecturer = json['courseLecturer'];
    courseType = json['courseType'];
    courseWeight = json['courseWeight'].toString();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['courseCode'] = courseCode;
    data['assignmentType'] = assignmentType;
    data['dueDate'] = dueDate;
    data['isOpened'] = isOpened;
    data['isDone'] = isDone;
    data['question'] = question;
    data['courseName'] = courseName;
    data['courseLecturer'] = courseLecturer;
    data['courseType'] = courseType;
    data['courseWeight'] = courseWeight;
    return data;
  }
}
