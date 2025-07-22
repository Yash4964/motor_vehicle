import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller/camera_contoller.dart';
import 'package:motor_vehicle/controller_api/booking_api_controller.dart';
import 'package:motor_vehicle/controller_api/driver_api_controller.dart';
import 'package:motor_vehicle/model/booking_model.dart';
import 'package:motor_vehicle/model/driver_model.dart';
import 'package:motor_vehicle/model/vehicle_model.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

import '../../../controller_api/attendance_api_controller.dart';

class DropController extends GetxController {

}

class DropdownController extends GetxController {
  var timeselected = '6:30 AM'.obs;
  var timelist = ['6:30 AM', '7:00 AM', '7:30 AM'];

  var datepick = '12/08/2025'.obs;

}


class AddAttendancePages extends StatelessWidget {
  AddAttendancePages({super.key});

  final DropController d = Get.put(DropController());
  final DropdownController c = Get.put(DropdownController());
  var args = Get.arguments;
  final AttendenceConrollerApi a = Get.put(AttendenceConrollerApi());

  BookingApiController bookingcontroller = Get.put(BookingApiController());
  DriverConrollerApi driverConrollerApi = Get.put(DriverConrollerApi());
  CameraContoller cameraContoller = Get.put(CameraContoller());
  @override
  Widget build(BuildContext context) {
    if(args?['isEdit']??false)
    {
      //a.setData(Get.arguments);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.lightBlue,
                    width: 2.5,
                  ),
                ),padding: EdgeInsets.all(2),
                child: Obx(()=>
                   Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: cameraContoller.returnimage.value != null ? FileImage(File(cameraContoller.returnimage.value!.path))
                            : AssetImage('assets/images/default_person.png') as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            cameraContoller.camera();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.lightBlue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.add, color: Colors.white, size: 22),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            labels("Select Booking Name"),
            const SizedBox(height: 10),
            Obx(
                  () {
                    if (bookingcontroller.loader.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if(bookingcontroller.bookingList.isEmpty)
                      {
                        return const Text("No vehicles available");
                      }
                    if (a.selectedbooking == null) {
                      if ((args?['isEdit'] ?? false) ) {
                        final bookingid = args['id'];
                        print("==>>>>>>>"+bookingid);
                        final matchbooking = bookingcontroller.bookingList
                            .firstWhereOrNull((v) => v.id == bookingid);
                        if (matchbooking != null) {
                          a.selectedbooking = Rx<BookingModel>(matchbooking);
                        }
                      } else {
                        a.selectedbooking = Rx<BookingModel>(bookingcontroller.bookingList.first);
                      }
                    }

                        return  Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color:Color(0xFFF3F4F6),
                          ),
                          padding: EdgeInsets.only(left: 5),
                          width: double.infinity,
                            child: DropdownButton(
                            isExpanded: true,
                            value: a.selectedbooking?.value,
                            items: bookingcontroller.bookingList.map
                              (
                                    (book) => DropdownMenuItem(
                                      value: book,
                                        child:Text(book.lernerName ?? ''),
                                    )
                            ).toList(),
                            onChanged: (val) {
    if (val != null) {
    a.selectedbooking?.value = val;
    }}
                          ),
                        );

                  }
            ),

            SizedBox(height: 10),
            labels("Select Driver Name"),
            Obx(
                  () {
                    if(driverConrollerApi.loader.value)
                      {
                        return Center(child: CircularProgressIndicator());
                      }
                    if (driverConrollerApi.driverlist.isEmpty) {
                      return const Text("No vehicles available");
                    }
                    if (a.selecteddriver == null) {
                      if ((args?['isEdit'] ?? false) && args?['driverid'] != null) {
                        final driverid = args['driverid'];
                        final matchdriver = driverConrollerApi.driverlist
                            .firstWhereOrNull((v) => v.id == driverid);
                        if (matchdriver != null) {
                          a.selecteddriver = Rx<DriverModel>(matchdriver);
                        }
                      } else {
                        a.selecteddriver = Rx<DriverModel>(driverConrollerApi.driverlist.first);
                      }
                    }


                   return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:Color(0xFFF3F4F6),
                      ),
                      padding: EdgeInsets.only(left: 5),
                      width: double.infinity,
                      child: DropdownButton(
                        isExpanded: true,
                        value: a.selecteddriver?.value,
                        items: driverConrollerApi.driverlist.map(
                            (driver)=> DropdownMenuItem(
                                value: driver,
                                child: Text(driver.name ?? ''),
                            )
                        ).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            a.selecteddriver?.value = val;
                          }}
                      ),
                    );
                  }
            ),

            labels("Date"),
            InkWell(
              onTap: () {
                _selecteddate(context);
              },
              child: AbsorbPointer(
                absorbing: true,
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
                      child: Text(c.datepick.value),
                    ),
                  ),
                ),
              ),
            ),

            labels("Select Time"),
            Container(
              child: Row(
                children: [
                  Obx(
                        () => Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFFF3F4F6),
                        ),
                        padding: EdgeInsets.only(left: 5),

                        child: DropdownButton(
                          isExpanded: true,
                          value: c.timeselected.value,
                          items: [
                            for (var t in c.timelist)
                              DropdownMenuItem(
                                child: Text(t, style: TextStyle(color: Colors.black87)),
                                value: t,
                              ),
                          ],
                          onChanged: (timevalue) {
                            c.timeselected.value = timevalue!  ;
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Center(
                          child: Obx(() => Text(c.timeselected.value)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Get.back();
                if((args?["isEdit"] ?? false) == false)
                {
                  a.postapi();
                }
                else
                {
                  a.editapi(args['id']);
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
          ],
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
    if(pickedDate != null) {
      c.datepick.value =
      "${pickedDate.day ?? 0}/${pickedDate.month ?? 0}/${pickedDate.year ?? 0}";
    }
  }
}
