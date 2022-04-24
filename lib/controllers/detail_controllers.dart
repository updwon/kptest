

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SecondScreenController extends GetxController {
  dynamic argumentData = Get.arguments;

  RxMap data= {}.obs;


  @override
  void onInit() {

    print(argumentData.toString());

    data = RxMap.from(argumentData);

    super.onInit();
  }
}