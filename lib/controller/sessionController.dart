import 'package:get/get.dart';
import 'package:uroutines/model/assignments.dart';
import 'package:uroutines/model/session.dart';
import 'package:uroutines/utility/db.dart';

class SessionController extends GetxController{
  
  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addSession({Session? sessions})async{
    return await DbHelper.insertSession(sessions);
  }

  Future<int> updateSession({Session? sessions, int? id})async{
    return await DbHelper.updateSession(sessions, id!);
  }
}