import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller_api/booking_api_controller.dart';
import 'package:motor_vehicle/controller_api/payment_controller.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';
import '../../../model/booking_model.dart';

class AddPaymentPage extends StatelessWidget {
  AddPaymentPage({super.key});

  BookingApiController bookingcontroller = Get.put(BookingApiController());
  PaymentController paymentController = Get.put(PaymentController());

  final _formkey = GlobalKey<FormState>();
  var args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    paymentController.clr();
    if (args?['isEdit'] ?? false) {
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
              Obx(() {
                if (bookingcontroller.loader.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (bookingcontroller.bookingList.isEmpty) {
                  return const Center(child: Text("No Data Found"));
                }

                if (paymentController.selectedbook == null) {
                  if (args?['isEdit'] == true) {
                    final bookingId = args["bookingid"] ?? "";
                    final matchedBooking = bookingcontroller.bookingList
                        .firstWhereOrNull((book) => book.id == bookingId);

                    if (matchedBooking != null) {
                      paymentController.selectedbook = Rx<BookingModel>(
                        matchedBooking,
                      );
                    }
                  } else {
                    paymentController.selectedbook = Rx<BookingModel>(
                      bookingcontroller.bookingList[0],
                    );
                  }
                }

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFF3F4F6),
                  ),
                  padding: EdgeInsets.only(left: 5),
                  width: double.infinity,
                  child: DropdownButton<BookingModel>(
                    isExpanded: true,
                    value: paymentController.selectedbook?.value,
                    items: bookingcontroller.bookingList
                        .map(
                          (book) => DropdownMenuItem<BookingModel>(
                            value: book,
                            child: Text(book.lernerName),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        paymentController.selectedbook?.value =
                            val as BookingModel;
                      }
                    },
                  ),
                );
              }),

              labels("Amount"),
              TextFieldWidget(
                controller: paymentController.amount,
                hint: '₨ : 1,000',
                textInputType: TextInputType.number,
              ),
              labels("Joining Date"),
              GestureDetector(
                onTap: () {
                  _selected(context);
                },
                child: AbsorbPointer(
                  child: Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFFF3F4F6),
                      ),
                      padding: EdgeInsets.only(left: 5),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(paymentController.datevalue.value),
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
      padding: EdgeInsets.only(top: 12, bottom: 6, left: 5),
      child: Text(txt, style: TextStyle(fontSize: 16)),
    );
  }

  void _selected(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      paymentController.datevalue.value =
          "${pickedDate.day ?? 0}/${pickedDate.month ?? 0}/${pickedDate.year ?? 0}";
    }
  }
}
