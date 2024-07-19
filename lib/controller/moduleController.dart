import 'package:get/get.dart';
import 'package:uroutines/utility/db.dart';
import '../model/modules.dart';

class ModuleController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  List moduleList = <Modules>[].obs;
  List<Modules> moduleList2 = [];
  Modules _modules = Modules();

  Future<int> addModule({Modules? modules1}) async {
    return await DbHelper.insertModules(modules1);
  }

  Future<int> updateModule({Modules? modules1, int? id}) async {
    return await DbHelper.updateModule(modules1, id!);
  }
}
