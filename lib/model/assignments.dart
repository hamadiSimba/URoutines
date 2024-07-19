class Assignments {
  int? id;
  String? courseCode;
  String? assignmentType;
  String? dueDate;
  String? question;
  int? isOpened = 0;
  int? isDone = 0;

  Assignments(
      {this.courseCode,
      this.question,
      this.assignmentType,
      this.dueDate,
      isDone = 0,
      isOpened = 0});

  Assignments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseCode = json['courseCode'];
    assignmentType = json['assignmentType'];
    dueDate = json['dueDate'];
    isOpened = json['isOpened'];
    isDone = json['isDone'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['courseCode'] = courseCode;
    data['assignmentType'] = assignmentType;
    data['dueDate'] = dueDate;
    data['isOpened'] = isOpened;
    data['isDone'] = isDone;
    data['question'] = question;
    return data;
  }
}
