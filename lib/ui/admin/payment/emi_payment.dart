import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/attendance/add_attendance_customer.dart';
import 'package:motor_vehicle/ui/admin/attendance/add_attendance_page.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class EmiPayment extends StatelessWidget {
  EmiPayment({super.key});

  final List<Map<String, dynamic>> customers = [
    {
      'emi':500,
      'Date': '2025/06/15',
      'Time': '6:30',
    },
    {
      'emi':1000,
      'Date': '2025/06/15',
      'Time': '6:30',
    },
    {
      'emi':1000,
      'Date': '2025/06/15',
      'Time': '6:30',
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (BuildContext context, int index) {
          final customer = customers[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 2,
            child: ListTile(
              contentPadding: EdgeInsets.all(12),
              title: Text(
                "EMI 1 : ${customer['emi']!}",
                style: TextStyle(fontWeight: FontWeight.bold),
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
