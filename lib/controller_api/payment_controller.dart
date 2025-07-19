import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http ;
import 'package:motor_vehicle/controller_api/booking_api_controller.dart';
import 'package:motor_vehicle/model/booking_model.dart';
import 'package:motor_vehicle/model/payment_model.dart';
import 'package:motor_vehicle/ui/admin/payment/add_payment_page.dart';

class PaymentController extends GetxController {

  final TextEditingController amount = TextEditingController();
  CustomerController customerController = Get.put(CustomerController());

  @override
  void onInit() {
    super.onInit();
    getapi();

  }
  RxList<PaymentModel> paymentList = <PaymentModel>[].obs;
  Rx<BookingModel>? selectedbook;

  Future<void> getapi() async {
    final response = await http.get(
      Uri.parse(
          'https://6874eafbdd06792b9c95d77b.mockapi.io/motor/payment'),
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<PaymentModel> payment = data
          .map((e) => PaymentModel.fromJson(e))
          .toList();
      paymentList.value = payment;
    }
  }


  Future<void> delapi(String id) async {
    final response = await http.delete(
      Uri.parse(
          'https://6874eafbdd06792b9c95d77b.mockapi.io/motor/payment/$id'),
    );
    if (response.statusCode == 200) {
      paymentList.removeWhere((item) => item.id == id);
      Get.snackbar('deleted', 'thank you');
      getapi();
    }
  }

  Future<void> postapi() async {
    final response = await http.post(
      Uri.parse("https://6874eafbdd06792b9c95d77b.mockapi.io/motor/payment"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(_getData()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      getapi();
      Get.snackbar("confrim", "thankyou",backgroundColor: Colors.green);
    }
  }

  Future<void> editapi(String id) async {
    final response = await http.put(
      Uri.parse('https://6874eafbdd06792b9c95d77b.mockapi.io/motor/payment/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(_getData()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      getapi();
      clr();
      Get.snackbar("Update Successfully", "thankyou");
    }
  }

  void clr(){
    amount.clear();
    selectedbook = null;
  }

  Map<String,dynamic> _getData() {
    return
        {
          "bookingid": selectedbook?.value.id ?? "",
          "amount": amount.text,
          "date": customerController.datevalue.value,
        };
  }

  void setData(Map<String, dynamic> arguments) {
    amount.text = arguments["amount"];
    String bookingId = arguments["bookingid"];
    print("*********************" + bookingId);

    final matchedBooking = Get.find<BookingApiController>()
        .bookingList
        .firstWhereOrNull((book) => book.id == bookingId);

    if (matchedBooking != null) {
      selectedbook = Rx<BookingModel>(matchedBooking);
    }

    customerController.datevalue.value = arguments["date"] ?? customerController.datevalue.value;
  }

}
