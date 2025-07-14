import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingController extends GetxController {

  bool isCustomer = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getData();
  }

  void getData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isCustomer = prefs.getBool('customer')!;
  }
}