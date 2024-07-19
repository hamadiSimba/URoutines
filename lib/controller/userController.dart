import 'package:get/get.dart';
import 'package:uroutines/model/user.dart';
import 'package:uroutines/utility/db.dart';

class UserDetailsController extends GetxController{
  
  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addUser({UserDetails? userDetails})async{
    return await DbHelper.insertUser(userDetails);
  }

  Future<int> updateUser({UserDetails? userDetails, int? id})async{
    return await DbHelper.updateUser(userDetails, id!);
  }
}