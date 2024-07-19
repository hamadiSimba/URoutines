class UserDetails{
  String? fullName;
  String? regNumber;
  String? mobileNo;
  String? gender;
  String? program;
  String? college;
  String? institute;
  int? academicYear;
  int? level;


  UserDetails({this.fullName, this.regNumber, this.mobileNo, this.gender, this.program, this.academicYear, this.college, this.institute, this.level = 4});

  UserDetails.fromJson(Map<String,dynamic> json){
    fullName = json['fullName'];
    regNumber = json['regNumber'];
    mobileNo = json['mobileNo'].toString();
    gender = json['gender'];
    program = json['program'];
    academicYear = json['academicYear'];
    college = json['college'];
    institute = json['institute'];
    level = json['level'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['fullName'] = fullName;
    data['regNumber'] = regNumber;
    data['mobileNo'] = mobileNo;
    data['gender'] = gender;
    data['program'] = program;
    data['academicYear'] = academicYear;
    data['college'] = college;
    data['institute'] = institute;
    data['level'] = level;
    return data;
  }
}