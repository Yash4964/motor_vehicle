import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor_vehicle/model/attendence_model.dart';
import 'package:motor_vehicle/ui/admin/attendance/add_attendance_customer.dart';
import 'package:motor_vehicle/ui/admin/attendance/add_attendance_page.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class View_Attendance extends StatelessWidget {
  final List<AttendanceModel> attList;
  View_Attendance({super.key, required this.attList });
  var arg = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      body:attList.isEmpty ?  Center(child:CircularProgressIndicator())
      :
      Obx(()=>
         ListView.builder(
          itemCount: attList.length,
          itemBuilder: (BuildContext context, int index) {
            final att = attList[index];
            DateTime dateTime = DateTime.parse(att.date);
            final formate = DateFormat('yyyy:MM:dd').format(dateTime);
            return Card(
              color: Appcolor.container,
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/default_person.png'),
                ),
                contentPadding: EdgeInsets.all(12),
                title: InkWell(
                  onTap: () {
                    //Get.to(() => CustomerProfilePage(), arguments: customer);
                  },
                  child: Text(
                    "Driver Name : demo" ,//${att.driverid}
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                subtitle: Text(
                  'Date: ${formate}  |  Time: ${att.time}',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            );
          },
        ),
      ),

    );
  }
}
