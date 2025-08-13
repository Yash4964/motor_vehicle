import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:motor_vehicle/controller/booking_controller.dart';
import 'package:motor_vehicle/ui/admin/attendance/add_attendance_page.dart';
import 'package:motor_vehicle/ui/admin/attendance/view_attendance_cus.dart';
import 'package:motor_vehicle/ui/admin/payment/emi_payment.dart';
import 'package:motor_vehicle/utils/app_utils.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

class BookingDetailsPage extends StatelessWidget {
  var args = Get.arguments;
  BookingController bookingController = Get.find<BookingController>();

  GetStorage getStorage = GetStorage();
  String bookingId = "";

  BookingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (getStorage.read('user_mode') ?? '').toString().toLowerCase();
    final bool isCustomer = user == 'customer';
    bookingId = args["booking_id"] ?? "";

    bookingController.bookingDetailsget(bookingId);

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

      body: Obx(() {
        if (bookingController.loadered.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (bookingController.bookingDetails == null) {
          return Center(child: Text("Booking not found"));
        }

        return Column(
          children: [
            SizedBox(height: 12),
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
                            "Total Fees: ₹${bookingController.bookingModel.package.price}",
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
                              "Customer name: ${bookingController.bookingModel.customer.name}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Learner name: ${bookingController.bookingModel.learnerName}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Package name:  ${bookingController.bookingModel.package.name}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Days: ${bookingController.bookingModel.package.days}  | km :  ${bookingController.bookingModel.package.km}  ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Booking Date: ${AppUtils.getStringDateFromDatTime(bookingController.bookingModel.joiningDate)}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Join Time: ${bookingController.bookingModel.timeSlot}",
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
            Expanded(
              child: DefaultTabController(
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
                    Expanded(
                      child: TabBarView(
                        children: [
                          ViewAttendance(
                            attendenceList:
                                bookingController.bookingModel.attendances ??
                                [],
                          ),
                          EmiPayment(
                            transactionsList:
                                bookingController.bookingModel.transactions ??
                                [],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),

      floatingActionButton: isCustomer
          ? Container()
          : Padding(
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
                      Get.to(
                        AddAttendancePages(),
                        arguments: {"booking_id": bookingId.toString()},
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
