import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller_api/booking_api_controller.dart';
import 'package:motor_vehicle/controller_api/payment_controller.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

import '../../../model/booking_model.dart';


class CustomerController extends GetxController
{

  var datevalue = '12/08/2025'.obs;
  @override
  void onInit() {
    super.onInit();
    final today = DateTime.now();
    datevalue.value = "${today.day}/${today.month}/${today.year}";
  }
}

class AddPaymentPage extends StatelessWidget {
  AddPaymentPage({super.key});

  final CustomerController c = Get.put(CustomerController());

  BookingApiController bookingcontroller = Get.put(BookingApiController());
  PaymentController paymentController = Get.put(PaymentController());

  final _formkey = GlobalKey<FormState>();
  var args = Get.arguments;
  @override
  Widget build(BuildContext context) {
    if(args?['isEdit']??false && paymentController.selectedbook == null)
    {
      paymentController.setData(Get.arguments);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Payment Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Appcolor.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labels("Select Booking Name"),
              const SizedBox(height: 10),
              Obx(
                      () {
                    if(bookingcontroller.bookingList.isEmpty)
                    {
                      return Center(child: CircularProgressIndicator(),);
                    }
                    paymentController.selectedbook ??= Rx<BookingModel>(bookingcontroller.bookingList[0]);

                    return  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:Color(0xFFF3F4F6),
                      ),
                      padding: EdgeInsets.only(left: 5),
                      width: double.infinity,
                      child: DropdownButton(
                        isExpanded: true,
                        value: paymentController.selectedbook?.value,
                        items: bookingcontroller.bookingList.map
                          (
                                (book) => DropdownMenuItem(
                              value: book,
                              child:Text(book.lernerName),
                            )
                        ).toList(),
                        onChanged: (val) {
                          paymentController.selectedbook?.value = val as BookingModel;
                        },
                      ),
                    );

                  }
              ),
              labels("Amount"),
              TextFieldWidget(
                controller: paymentController.amount,
                hint: '₨ : 1,000',
                textInputType: TextInputType.number,
              ),
              labels("Joining Date"),
              InkWell(
                onTap: () {
                  _selected(context);
                },
                child: AbsorbPointer(
                  absorbing: true,
                  child: Obx(
                        () => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:Color(0xFFF3F4F6),
                      ),
                      padding: EdgeInsets.only(left: 5),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(c.datevalue.value),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Get.back();
                  if ((args?["isEdit"] ?? false) == false) {
                    paymentController.postapi();
                  } else {
                    paymentController.editapi(args["id"]);
                  }


                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Appcolor.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFF3F4F6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
               SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget labels(String txt) {
    return Padding(
      padding:  EdgeInsets.only(top: 12, bottom: 6, left: 5),
      child: Text(txt, style:  TextStyle(fontSize: 16)),
    );
  }

  void _selected(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      c.datevalue.value =
      "${pickedDate.day ?? 0}/${pickedDate.month ?? 0}/${pickedDate.year ?? 0}";
    }
  }

}
