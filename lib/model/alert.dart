class Alert{
  final String title;
  final String description;
  final String subject;
  final DateTime time;
  final DateTime startDate;
  final DateTime deadlineDate;

  Alert({required this.title,required this.subject,required this.description,required this.time,required this.startDate,required this.deadlineDate});
}

List<Alert> recentsAlerts = [
  Alert(title: "Tutorial", 
    subject: "Operating System", 
    description: "Individual Assignment", 
    time: DateTime.parse("2023-03-25 14:30:00"), 
    startDate: DateTime.parse("2023-03-25 14:30:00"), 
    deadlineDate: DateTime.parse("2023-03-26 00:30:00"),
  ),

  // Alert(title: "Lecture", 
  //   subject: "Data structure", 
  //   description: "Group Assignment", 
  //   time: DateTime.parse("2023-03-24 13:30:00"), 
  //   startDate: DateTime.parse("2023-03-24 13:30:00"), 
  //   deadlineDate: DateTime.parse("2023-03-24 13:40:00"),
  // ),
];