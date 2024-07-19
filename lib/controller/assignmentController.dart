import 'package:get/get.dart';
import 'package:uroutines/model/assignments.dart';
import 'package:uroutines/utility/db.dart';

class AssignementController extends GetxController{
  
  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addAssignment({Assignments? works})async{
    return await DbHelper.insertAssignment(works);
  }

  Future<int> updateAssignment({Assignments? works, int? id})async{
    return await DbHelper.updateAssignment(works, id!);
  }
}