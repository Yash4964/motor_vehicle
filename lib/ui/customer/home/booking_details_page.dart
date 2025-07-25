import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:motor_vehicle/controller/booking_controller.dart';
import 'package:motor_vehicle/controller_api/attendance_api_controller.dart';
import 'package:motor_vehicle/controller_api/booking_api_controller.dart';
import 'package:motor_vehicle/model/booking_model.dart';
import 'package:motor_vehicle/ui/admin/attendance/add_attendance_customer.dart';
import 'package:motor_vehicle/ui/admin/attendance/add_attendance_page.dart';
import 'package:motor_vehicle/ui/admin/attendance/view_attendance_cus.dart';
import 'package:motor_vehicle/ui/admin/payment/emi_payment.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

import '../../../model/attendence_model.dart';

class BookingDetailsPage extends StatelessWidget {
  var args = Get.arguments;
  final BookingController bookingController = Get.put(BookingController());
  BookingApiController bookingApiController = Get.put(BookingApiController());

  AttendenceConrollerApi attendenceConrollerApi = Get.put(AttendenceConrollerApi());
  final _form = GlobalKey<FormState>();
  BookingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bookingController.isCustomer=true;
    return Scaffold(
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text("Your Booking Details"),
        backgroundColor: Appcolor.primary,
        elevation: 1,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Obx(()
        {
          if(bookingApiController.bookingList.isEmpty)
          {
            return  Center(child: CircularProgressIndicator());
          }
          final booking_id = args["Booking_id"] ?? "";
          final match = bookingApiController.bookingList.firstWhereOrNull(

              (i)  =>  i.id == booking_id  );

          if (booking_id == null) {
            return Center(child: Text("Booking not found"));
          }

          final att_id = match?.id;
          final List<AttendanceModel> attendanceList = attendenceConrollerApi.tolist.where(
              (j) => j.booking_id == att_id
          ).toList();
          return Column(
            key: _form,
            children: [
              SizedBox(height: 16),
              Center(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                "assets/images/swift.jpg",
                                width: 110,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Total Fees: ₹5000",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Pending: ₹500",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 2),
                              Text(
                                "Customer name: ${match?.id}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "Customer name: ${match?.customer_id}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Package name:  ${match?.package_id}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Days: 5 | km : 5 ",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Booking Date: ${match?.joining_date }",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Join Date: ${match?.joining_date}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Divider(color: Colors.grey, thickness: 1),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: Colors.black,
                      indicatorColor: Colors.blue,
                      tabs: [
                        Tab(text: "Attendance"),
                        Tab(text: "Payment"),
                      ],
                    ),
                    SizedBox(
                      height: 600,
                      child: TabBarView(
                        children: [
                          View_Attendance(attList: attendanceList),
                          EmiPayment(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        ),
      ),
      floatingActionButton: bookingController.isCustomer ? Container() : Padding(
        padding: EdgeInsets.all(8.0),
        child: SpeedDial(
          animatedIcon: AnimatedIcons.add_event,
          spacing: 15,
          shape: CircleBorder(),
          useRotationAnimation: true,
          foregroundColor: Colors.white,
          backgroundColor: Appcolor.primary,
          children: [
            SpeedDialChild(
              shape: CircleBorder(),
              backgroundColor: Colors.green,
              child: Icon(Icons.payment_outlined, color: Colors.white),
              label: 'Payment',
              onTap: () {
                Get.defaultDialog(
                  title: "Enter Amount",
                  content: Column(
                    children: [
                      SizedBox(height: 10),
                      TextFieldWidget(
                        hint: "Amount",
                        textInputType: TextInputType.phone,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => Get.back(),
                            child: Text("Back"),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () => Get.back(),
                            child: Text(
                              "+ ADD",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  radius: 10,
                );
              },
            ),
            SpeedDialChild(
              shape: CircleBorder(),
              backgroundColor: Colors.purple,
              child: Icon(Icons.add_task, color: Colors.white),
              label: 'Attendance',
              onTap: () {
                attendenceConrollerApi.clr();
                Get.to(AddAttendancePages(),arguments: {

                  "isEdit": true,
                  "id":args["Booking_id"]
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
