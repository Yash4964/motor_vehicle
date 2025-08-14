import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller/camera_contoller.dart';
import 'package:motor_vehicle/controller/booking_controller.dart';
import 'package:motor_vehicle/controller/driver_api_controller.dart';
import 'package:motor_vehicle/model/booking_model.dart';
import 'package:motor_vehicle/model/driver_model.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import '../../../controller/attendance_api_controller.dart';

class DropController extends GetxController {}

class DropdownController extends GetxController {
  var timelist = ['6:30 AM', '7:00 AM', '7:30 AM'];
  var timeselected = '6:30 AM'.obs;
  var datepick = '12/08/2025'.obs;
}

class AddAttendancePages extends StatelessWidget {
  AddAttendancePages({super.key});

  final DropController d = Get.put(DropController());
  final DropdownController c = Get.put(DropdownController());
  final args = Get.arguments;
  final AttendenceConrollerApi controller = Get.put(AttendenceConrollerApi());
  final BookingController bookingcontroller = Get.put(BookingController());
  final DriverConrollerApi driverConrollerApi = Get.put(DriverConrollerApi());
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bookingcontroller.bookingget();
    controller.clear();

    if (controller.isEdit) {
      controller.setData();
    }else{
      controller.bookingId = Get.arguments?['booking_id'] ?? "";
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Attendance Details',
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
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.lightBlue, width: 2.5),
                  ),
                  padding: EdgeInsets.all(2),
                  child: Obx(
                    () => Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage:
                          controller.imageController.returnimage.value != null
                              ? FileImage(
                            File(controller.imageController.returnimage.value!.path),
                          )
                              : (args?['isEdit'] == true && args?['image'] != null
                              ? NetworkImage(args['image'])
                              : const AssetImage('assets/images/default_person.png'))
                          as ImageProvider,
                        ),



                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () => controller.imageController.pickImageOption(context),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.lightBlue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),
              if (controller.bookingId.isEmpty)...[
                labels("Select Booking Name"),
                SizedBox(height: 10),
                Obx(() {
                  if (bookingcontroller.bookingloaders.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (bookingcontroller.bookingList.isEmpty) {
                    return Text("No vehicles available");
                  }

                  if (controller.selectedbooking == null) {
                    if ((args?['isEdit'] ?? false)) {
                      final bookingid = args['booking_id'];
                      final match = bookingcontroller.bookingList
                          .firstWhereOrNull((b) => b.id == bookingid);
                      if (match != null) {
                        controller.selectedbooking = Rx<BookingModel>(
                          bookingcontroller.bookingList.firstWhere(
                                (b) => b.id == match.id,
                          ),
                        );
                      }
                    } else {
                      controller.selectedbooking = Rx<BookingModel>(
                        bookingcontroller.bookingList.first,
                      );
                    }
                  }

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xFFF3F4F6),
                    ),
                    padding: const EdgeInsets.only(left: 5),
                    width: double.infinity,
                    child: DropdownButton<BookingModel>(
                      isExpanded: true,
                      value: controller.selectedbooking?.value,
                      items: bookingcontroller.bookingList
                          .map(
                            (book) => DropdownMenuItem(
                          value: book,
                          child: Text(book.learnerName ?? ''),
                        ),
                      )
                          .toList(),
                      onChanged: (val) {
                        if (val != null) controller.selectedbooking?.value = val;
                      },
                    ),
                  );
                }),
              ],
              const SizedBox(height: 10),
              labels("Select Driver Name"),
              Obx(() {
                if (driverConrollerApi.loader.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (driverConrollerApi.driverlist.isEmpty) {
                  return const Text("No drivers available");
                }

                if (controller.selecteddriver == null) {
                  if ((args?['isEdit'] ?? false) && args?['driver_id'] != null) {
                    final driverid = args['driver_id'];
                    final match = driverConrollerApi.driverlist.firstWhereOrNull(
                      (v) => v.id == driverid,
                    );
                    if (match != null) {
                      controller.selecteddriver = Rx<DriverModel>(
                        driverConrollerApi.driverlist.firstWhere(
                          (v) => v.id == match.id,
                        ),
                      );
                    }
                  } else {
                    controller.selecteddriver = Rx<DriverModel>(
                      driverConrollerApi.driverlist.first,
                    );
                  }
                }

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFFF3F4F6),
                  ),
                  padding: const EdgeInsets.only(left: 5),
                  width: double.infinity,
                  child: DropdownButton<DriverModel>(
                    isExpanded: true,
                    value: controller.selecteddriver?.value,
                    items: driverConrollerApi.driverlist
                        .map(
                          (driver) => DropdownMenuItem(
                            value: driver,
                            child: Text(driver.name ?? ''),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) controller.selecteddriver?.value = val;
                    },
                  ),
                );
              }),

              labels("Date"),
              InkWell(
                onTap: () => _selecteddate(context),
                child: AbsorbPointer(
                  child: Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xFFF3F4F6),
                      ),
                      padding: const EdgeInsets.only(left: 5),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(c.datepick.value),
                      ),
                    ),
                  ),
                ),
              ),

              labels("Select Time"),
              Obx(() {
                if (!c.timelist.contains(c.timeselected.value)) {
                  c.timeselected.value = c.timelist.first;
                }

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFFF3F4F6),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  width: double.infinity,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox(),
                    value: c.timeselected.value,
                    items: c.timelist
                        .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) c.timeselected.value = val;
                    },
                  ),
                );
              }),

              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    if ((args?['isEdit'] ?? false) == false) {
                      controller.addAttendance();
                    } else {
                      controller.updateAttendance(args['id']);
                    }
                    Get.back();

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
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (controller.loader.value)
                Container(
                  color: Colors.black.withOpacity(0.4),
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),

    );
  }

  Widget labels(String txt) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6, left: 5),
      child: Text(txt, style: const TextStyle(fontSize: 16)),
    );
  }

  void _selecteddate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      c.datepick.value =
          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
    }
  }
}
