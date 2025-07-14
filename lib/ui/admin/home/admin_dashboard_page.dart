import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/attendance/attendance_list_page.dart';
import 'package:motor_vehicle/ui/admin/customer/customerlist_page.dart';
import 'package:motor_vehicle/ui/admin/driver/driver_list_page.dart';
import 'package:motor_vehicle/ui/admin/package/package_list_page.dart';
import 'package:motor_vehicle/ui/admin/payment/payment_dashboard.dart';
import 'package:motor_vehicle/ui/admin/report/report_page.dart';

import 'package:motor_vehicle/ui/admin/vehicle/vehicle_list_page.dart';
import 'package:motor_vehicle/ui/customer/home/vehicle.dart';
import 'package:motor_vehicle/ui/login_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/container_table.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bokking/bookng_list_page.dart';

class Dashboard_page extends StatelessWidget {
  const Dashboard_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top:26),
            decoration: BoxDecoration(
              color: Appcolor.primary,
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(30),topRight: Radius.circular(30)
              // ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top:18,bottom: 8),
              child: Center(child: Text("Dashboard",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Appcolor.primary,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: Text('BL Kumawat',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                subtitle: Text('Welcome Back',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                trailing: CircleAvatar(backgroundImage: AssetImage('assets/images/person.jpg'),radius: 30,),
              ),
            ),
          ),

          Expanded(
            child: GridView.count(
              shrinkWrap: true,
              
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              padding: EdgeInsets.all(30),
              crossAxisCount: 2,
              children: [
                InkWell(
                  onTap: (){
                    Get.to(CustomerListPage());
                  },
                  child: Container_table(
                    tital: "Customer",
                    u_icon: Icons.people,
                    bg_color: Appcolor.primary,
                  ),
                ),
                InkWell(
                  onTap: (){
                    Get.to(BookingListPage());
                  },
                  child: Container_table(
                    tital: "Booking",
                    u_icon: Icons.bookmark_add,
                    bg_color: Colors.amber,
                  ),
                ),
                InkWell(
                  onTap:(){
                    Get.to(DriverListPage());
                  },
                  child: Container_table(
                    tital: "Driver",
                    u_icon: Icons.emoji_people,
                    bg_color: Colors.purple,
                  ),
                ),
                InkWell(
                  onTap: ()
                  {
                    Get.to(()=>PackageListPage());
                  },
                  child: Container_table(
                    tital: "Package",
                    u_icon: Icons.paste_outlined,
                    bg_color: Colors.lightGreen,
                  ),
                ),
                InkWell(
                  onTap: (){
                    Get.to(VehicleListPage());
                  },
                  child: Container_table(
                    tital: "Vehicle",
                    u_icon: Icons.drive_eta,
                    bg_color: Color.fromARGB(255, 218, 67, 40),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Get.to(AttendanceListPage());
                  },
                  child: Container_table(
                    tital: "Attendance",
                    u_icon: Icons.add_task,
                    bg_color: Color.fromARGB(255, 131, 26, 216),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Get.to(PaymentDashboard());
                  },
                  child: Container_table(
                    tital: "Payment",
                    u_icon: Icons.payment,
                    bg_color: Colors.teal,
                  ),
                ),
                InkWell(
                   onTap: (){
                      Get.to(ReportPage());
                  },
                  child: Container_table(
                    tital: "Report",
                    u_icon: Icons.add_chart_rounded,
                    bg_color: Colors.purpleAccent,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isLogin', false);
                    Get.defaultDialog(
                      title: 'Logout',
                      titleStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      middleText: 'Are you sure you want to logout?',
                      middleTextStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textCancel: 'Cancel',

                      textConfirm: 'Logout',
                      confirmTextColor: Colors.red,
                      cancelTextColor: Colors.green,
                      buttonColor: Colors.white60,
                      backgroundColor: Colors.white,
                      radius: 15,
                      onConfirm: () {
                        Get.back(); // Close dialog
                        Get.offAll(() => LoginPage()); // Navigate to LoginPage
                      },
                    );

                  },
                  child: Container_table(
                    tital: 'Logout',
                    u_icon: Icons.logout_outlined,
                    bg_color: Colors.redAccent,
                  ),
                )
              ],
              ),
          ),

        ],
      ),
    );
  }
}
