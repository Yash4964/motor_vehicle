import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/attendance/add_attendance_customer.dart';
import 'package:motor_vehicle/ui/admin/attendance/add_attendance_page.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class View_Attendance extends StatelessWidget {
  View_Attendance({super.key});

  final List<Map<String, String>> customers = [
    {
      'Name': 'Ravi Desai',
      'Attempt': 'Present',
      'Date': '2025/06/15',
      'Time': '6:30',
    },
    {
      'Name': 'Ravi Desai',
      'Attempt': 'Present',
      'Date': '2025/06/15',
      'Time': '6:30',
    },
    {
      'Name': 'Amit Patel',
      'Attempt': 'Present',
      'Date': '2025/06/15',
      'Time': '6:30',
    },
    {
      'Name': 'Ravi Desai',
      'Attempt': 'Present',
      'Date': '2025/06/15',
      'Time': '6:30',
    },
    {
      'Name': 'Ravi Desai',
      'Attempt': 'Present',
      'Date': '2025/06/15',
      'Time': '6:30',
    },
    {
      'Name': 'Ravi Desai',
      'Attempt': 'Present',
      'Date': '2025/06/15',
      'Time': '6:30',
    },
    {
      'Name': 'Ravi Desai',
      'Attempt': 'Present',
      'Date': '2025/06/15',
      'Time': '6:30',
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (BuildContext context, int index) {
          final customer = customers[index];
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
                  Get.to(() => CustomerProfilePage(), arguments: customer);
                },
                child: Text(
                  "Driver Name : ${customer['Name']!}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Text(
                'Date: ${customer['Date']}  |  Time: ${customer['Time']}',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          );
        },
      ),

    );
  }
}
