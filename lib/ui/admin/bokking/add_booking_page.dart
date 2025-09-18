import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller/booking_controller.dart';
import 'package:motor_vehicle/controller/customer_api_controller.dart';
import 'package:motor_vehicle/controller/package_api_controller.dart';
import 'package:motor_vehicle/model/customer_model.dart';
import 'package:motor_vehicle/model/package_model.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

import '../attendance/add_attendance_customer.dart';

class DropController extends GetxController {
  var timeselected =  "7:00 AM - 7:30 AM".obs;
    var timelist = [ "6:30 AM - 7:00 AM",
      "7:00 AM - 7:30 AM",
      "7:30 AM - 8:00 AM",
      "8:00 AM - 8:30 AM",
      "8:30 AM - 9:00 AM",
      "9:00 AM - 9:30 AM",
      "9:30 AM - 10:00 AM",
      "10:00 AM - 10:30 AM",
      "10:30 AM - 11:00 AM",
      "11:00 AM - 11:30 AM",
      "11:30 AM - 12:00 PM",
      "12:00 PM - 12:30 PM",
      "12:30 PM - 1:00 PM",

      "2:00 PM - 2:30 PM",
      "2:30 PM - 3:00 PM",
      "3:00 PM - 3:30 PM",
      "3:30 PM - 4:00 PM",
      "4:00 PM - 4:30 PM",
      "4:30 PM - 5:00 PM",
      "5:00 PM - 5:30 PM",
      "5:30 PM - 6:00 PM",
      "6:00 PM - 6:30 PM",
      "6:30 PM - 7:00 PM",
      "7:00 PM - 7:30 PM",];
}

class AddBookingPage extends StatelessWidget {
  AddBookingPage({super.key});

  final DropController d = Get.put(DropController());
  final Customercontoller c = Get.put(Customercontoller());
  final BookingController bookingController = Get.put(BookingController());
  final CustomerController customerController = Get.put(CustomerController());
  final PackageController packageController = Get.put(PackageController());
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    customerController.getCustomerList();
    packageController.getPackageList();
    bookingController.clear();

    if (Get.arguments?['booking_id'] != null) {
      bookingController.setData();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Booking Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Appcolor.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          child: Column(
            key: _formkey,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              labels("Select Customer"),
              Obx(() {
                if (customerController.customerlist.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Initialization block (can be moved to initState as well)
                bookingController.selectCustomer ??= Rx<CustomerModel>(
                  customerController.customerlist[0],
                );

                final selected = customerController.customerlist
                    .firstWhereOrNull(
                      (e) => e.id == bookingController.selectCustomer?.value.id,
                    );

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFFF3F4F6),
                  ),
                  padding: const EdgeInsets.only(left: 5),
                  width: double.infinity,
                  child: DropdownButton<CustomerModel>(
                    isExpanded: true,
                    value: selected,
                    items: customerController.customerlist.map((customer) {
                      return DropdownMenuItem(
                        value: customer,
                        child: Text(customer.name ?? "Unknown"),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        bookingController.selectCustomer?.value = val;
                      }
                    },
                  ),
                );
              }),

              labels("Booking Name"),
              TextFieldWidget(
                controller: bookingController.learner_name,
                hint: 'Enter Booking Name',
                textInputType: TextInputType.name,
              ),

              labels("Select Package"),
              Obx(() {
                if (packageController.tolist.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }

                bookingController.selectpackage ??= Rx<PackageModel>(
                  packageController.tolist[0],
                );

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFF3F4F6),
                  ),
                  padding: EdgeInsets.only(left: 5),
                  width: double.infinity,
                  child: DropdownButton<PackageModel>(
                    isExpanded: true,
                    value: bookingController.selectpackage?.value,
                    items: packageController.tolist.map((p) {
                      return DropdownMenuItem(
                        value: p,
                        child: Text(p.name ?? ""),
                      );
                    }).toList(),
                    onChanged: (val) {
                      bookingController.selectpackage?.value = val!;
                    },
                  ),
                );
              }),

              labels("Joining Date"),
              InkWell(
                onTap: () => _selecteddate(context),
                child: AbsorbPointer(
                  child: Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFFF3F4F6),
                      ),
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      child: Text(bookingController.joining_date.value),
                    ),
                  ),
                ),
              ),

              labels("Select Time"),
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFF3F4F6),
                  ),
                  padding: EdgeInsets.only(left: 5),
                  width: double.infinity,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: d.timeselected.value,
                    items: d.timelist
                        .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                        .toList(),
                    onChanged: (val) => d.timeselected.value = val!,
                  ),
                ),
              ),

              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  bookingController.joining_date.value = c.datepick.value;
                  bookingController.timeSlot.text = d.timeselected.value;
                  //b.bookingDate.text = DateTime.now().toString().split(' ')[0];
                  if (bookingController.isEdit) {
                    bookingController.updateBooking();
                  } else {
                    bookingController.addBooking();
                  }

                  Get.back();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Appcolor.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget labels(String txt) => Padding(
    padding: EdgeInsets.only(top: 12, bottom: 6, left: 5),
    child: Text(txt, style: TextStyle(fontSize: 16)),
  );

  void _selecteddate(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      bookingController.joining_date.value = c.datepick.value =
      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
    }
  }

}
