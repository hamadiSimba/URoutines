import 'package:sqflite/sqflite.dart';
import 'package:uroutines/model/assignments.dart';
import 'package:uroutines/model/exam.dart';
import 'package:uroutines/model/modules.dart';
import 'package:uroutines/model/user.dart';
import '../model/allAssignments.dart';
import '../model/exams.dart';
import '../model/session.dart';
import '../model/sessions.dart';

class DbHelper {
  static Database? _db;
  static const int _dbversion = 1;
  static const String _dbName = "Uroutines";
  static const String _tableName = "user";
  static const String _courseTable = "course";
  static const String _sessionTable = "session";
  static const String _assignmentsTable = "assignments";
  static const String _examTable = "exams";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }

    try {
      String path = await getDatabasesPath() + '$_dbName.db';
      _db = await openDatabase(path, version: _dbversion,
          onCreate: (db, version) {
        print("New Database Created at db.dart line 25");
        db.execute(
          " CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "fullName STRING, regNumber STRING,"
          "mobileNo STRING, gender STRING,"
          "college STRING, institute STRING,"
          "level INTEGER,"
          "academicYear INTEGER, program STRING)",
        );

        db.execute(
          " CREATE TABLE $_courseTable("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "courseName STRING, courseCode STRING,"
          "courseWeight STRING, courseLecturer STRING,"
          "courseType STRING"
          " )",
        );

        db.execute(
          " CREATE TABLE $_assignmentsTable("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "courseCode STRING, question STRING,"
          "dueDate STRING, assignmentType STRING,"
          "isOpened INTEGER, isDone INTEGER)",
        );

        db.execute(
          " CREATE TABLE $_sessionTable("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "courseCode STRING, weekDay STRING,"
          "startTime STRING, sessionType STRING,"
          "venue STRING )",
        );

        db.execute(
          " CREATE TABLE $_examTable("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "courseCode STRING, examType STRING,"
          "examDate STRING, examPeriod STRING,"
          "venue STRING )",
        );
      });
    } catch (e) {
      print("DataBase error $e");
    }
  }

// *****************************************************User***********************************************************
  static Future<int> insertUser(UserDetails? userDetails) async {
    return await _db?.insert(_tableName, userDetails!.toJson()) ?? 1;
  }

  static Future<int> updateUser(UserDetails? userDetails, int id) async {
    return await _db?.update(_tableName, userDetails!.toJson(),
            where: "id = ?", whereArgs: [id]) ??
        1;
  }

  static Future<List<UserDetails>> userQuery() async {
    List<Map<String, dynamic>> appUser = await _db!.query(_tableName);
    return appUser.isEmpty
        ? []
        : appUser.map((e) => UserDetails.fromJson(e)).toList();
  }

  // ********************************************Assignments***********************************************************
  static Future<int> insertAssignment(Assignments? work) async {
    return await _db?.insert(_assignmentsTable, work!.toJson()) ?? 1;
  }

  static Future<int> updateAssignment(Assignments? work, int id) async {
    return await _db?.update(_assignmentsTable, work!.toJson(),
            where: "id = ?", whereArgs: [id]) ??
        1;
  }

  static Future<List<Assignments>> allAssignmentQuery() async {
    List<Map<String, dynamic>> allAssign = await _db!.query(_assignmentsTable);
    return allAssign.isEmpty
        ? []
        : allAssign.map((e) => Assignments.fromJson(e)).toList();
  }

  static Future<int?> assignmentCount(String code) async {
    var count = Sqflite.firstIntValue(await _db!.rawQuery(
            "SELECT COUNT(`courseCode`) FROM `$_assignmentsTable` WHERE courseCode ='$code'")) ??
        0;
    return count;
  }

  static Future<List<AssignmentsDetails>> assignmentDetQuery() async {
    List<Map<String, dynamic>> sess = await _db!.rawQuery(
        "SELECT * FROM $_courseTable INNER JOIN $_assignmentsTable ON course.courseCode = assignments.courseCode");
    return sess.isEmpty
        ? []
        : sess.map((e) => AssignmentsDetails.fromJson(e)).toList();
  }

// ****************************************************Courses**********************************************************

  static Future<int> insertModules(Modules? modules) async {
    return await _db?.insert(_courseTable, modules!.toJson()) ?? 1;
  }

  static Future deleteModule(int id) async {
    await _db?.delete(_courseTable, where: "id = ?", whereArgs: [id]);
  }

  static Future<int> updateModule(Modules? module, int id) async {
    return await _db?.update(_courseTable, module!.toJson(),
            where: "id = ?", whereArgs: [id]) ??
        1;
  }

  static Future<List<Modules>> courseQuery() async {
    List<Map<String, dynamic>> mods = await _db!.query(_courseTable);
    return mods.isEmpty ? [] : mods.map((e) => Modules.fromJson(e)).toList();
  }

  static Future<List<Modules>> singleCourseQuery(int id) async {
    List<Map<String, dynamic>> mods =
        await _db!.query(_courseTable, where: "id = ?", whereArgs: [id]);
    return mods.isEmpty ? [] : mods.map((e) => Modules.fromJson(e)).toList();
  }

  static Future<int?> courseCount(String code) async {
    var count = Sqflite.firstIntValue(await _db!.rawQuery(
            "SELECT COUNT(`courseName`) FROM `$_courseTable` WHERE courseCode ='$code'")) ??
        0;
    return count;
  }

  static Future<List<Modules>> retrieveCourse(String code) async {
    List<Map<String, dynamic>> mods = await _db!
        .query(_courseTable, where: "courseCode = ?", whereArgs: [code]);
    return mods.isEmpty ? [] : mods.map((e) => Modules.fromJson(e)).toList();
  }

  // *****************************************************Sessions*******************************************************

  static Future<List<Sessions>> sessionsQuery(String day) async {
    List<Map<String, dynamic>> sess = await _db!.rawQuery(
        "SELECT * FROM $_courseTable INNER JOIN $_sessionTable ON course.courseCode = session.courseCode WHERE weekDay = '$day'");
    return sess.isEmpty ? [] : sess.map((e) => Sessions.fromJson(e)).toList();
  }

  static Future<int> insertSession(Session? session) async {
    return await _db?.insert(_sessionTable, session!.toJson()) ?? 1;
  }

  static Future<int> updateSession(Session? session, int id) async {
    return await _db?.update(_sessionTable, session!.toJson(),
            where: "id = ?", whereArgs: [id]) ??
        1;
  }

  static Future deleteSession(int id) async {
    await _db?.delete(_sessionTable, where: "id = ?", whereArgs: [id]);
  }

  static Future<int?> sessionCount(String code) async {
    var count = Sqflite.firstIntValue(await _db!.rawQuery(
            "SELECT COUNT(`courseCode`) FROM `$_sessionTable` WHERE courseCode ='$code'")) ??
        0;
    return count;
  }

  // *****************************************************Exams***********************************************************
  static Future<int> insertExam(Exam? exams) async {
    return await _db?.insert(_examTable, exams!.toJson()) ?? 1;
  }

  static Future<int> updateExam(Exam? exams, int id) async {
    return await _db?.update(_examTable, exams!.toJson(),
            where: "id = ?", whereArgs: [id]) ??
        1;
  }

  static Future<List<Exam>> examQuery() async {
    List<Map<String, dynamic>> exam = await _db!.query(_examTable);
    return exam.isEmpty ? [] : exam.map((e) => Exam.fromJson(e)).toList();
  }

  static Future<List<Exams>> examsQuery() async {
    List<Map<String, dynamic>> exams = await _db!.rawQuery(
        "SELECT * FROM $_courseTable INNER JOIN $_examTable ON course.courseCode = exam.courseCode");
    return exams.isEmpty ? [] : exams.map((e) => Exams.fromJson(e)).toList();
  }
}
