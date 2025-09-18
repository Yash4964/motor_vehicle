import 'package:flutter/material.dart';
import 'package:motor_vehicle/ui/admin/payment/pending_payment_list.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class PaymentDashboard extends StatelessWidget {
  const PaymentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          "Payment History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Appcolor.primary,
      ),
      body: PandingCustomerList(),
    );
  }
}
