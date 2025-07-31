import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor_vehicle/model/payment_model.dart';
import 'package:motor_vehicle/ui/admin/attendance/add_attendance_customer.dart';
import 'package:motor_vehicle/ui/admin/attendance/add_attendance_page.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class EmiPayment extends StatelessWidget {
   List<PaymentModel> transactionsList;
   EmiPayment({super.key, required this.transactionsList});

  @override
  Widget build(BuildContext context) {
    if (transactionsList.isEmpty) {
      return const Center(child: Text('No payments yet'));
    }

    return Scaffold(
      backgroundColor: Appcolor.background,
      body: ListView.builder(
        itemCount: transactionsList.length,
        itemBuilder: (BuildContext context, int index) {
          final emi = transactionsList[index];
          DateTime dateTime = DateTime.parse(emi.date);
          final formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
          return Card(
            color: Appcolor.container,
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 2,
            child: ListTile(
              contentPadding: EdgeInsets.all(12),
              title: Text(
                "EMI ${index + 1} : ${emi.amount}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Date: ${formattedDate}',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          );
        },
      ),

    );
  }
}
