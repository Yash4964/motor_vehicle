import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller_api/payment_controller.dart';
import 'package:motor_vehicle/ui/admin/customer/addcustomer_page.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/ui/admin/payment/add_payment_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class CompletePaymentDetails extends StatelessWidget {
  CompletePaymentDetails({super.key});

  final PaymentController paymentController = Get.put(PaymentController());
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      body: Obx(() {
        if (paymentController.paymentList.isEmpty)
        {
          return Center(child: CircularProgressIndicator());
        }
        else
        {
          return Form(
            key: _formkey,
            child: ListView.builder(
              itemCount: paymentController.paymentList.length,
              itemBuilder: (context, index) {
                final payment = paymentController.paymentList[index];
                return Card(
                  color: Appcolor.container,
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/person3.jpg"),
                    ),
                    title: Text(
                      payment.bookingid,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Text('Amount: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                payment.amount,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text("Date :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold)),
                            SizedBox(width: 4),
                            Text(payment.date, style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      }),

    );
  }
}
