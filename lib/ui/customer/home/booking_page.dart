import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:motor_vehicle/ui/admin/attendance/add_attendance_customer.dart';
import 'package:motor_vehicle/ui/admin/attendance/view_attendance_cus.dart';
import 'package:motor_vehicle/ui/admin/payment/emi_payment.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

class BookingPage extends StatefulWidget {
  BookingPage({super.key});

  @override

  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> with TickerProviderStateMixin {
  var args = Get.arguments;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text("Your Booking Details"),
        backgroundColor: Appcolor.primary,
        elevation: 1,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12),
            Center(
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: EdgeInsets.symmetric(horizontal: 16),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "assets/images/swift.jpg",
                            width: double.infinity,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Days: ${args[3]}  |  KM: ${args[4]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Price: ₹${args[5]}",
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
                        View_Attendance(),
                        EmiPayment(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
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
                      )
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
                Get.to(AddAttendanceCustomer());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
