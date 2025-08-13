import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller/booking_controller.dart';
import 'package:motor_vehicle/controller/payment_controller.dart';
import 'package:motor_vehicle/ui/admin/payment/add_payment_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:intl/intl.dart';

import '../../../model/payment_model.dart';

class PandingCustomerList extends StatelessWidget {
  PandingCustomerList({super.key});

  final PaymentController paymentController = Get.put(PaymentController());
  final BookingController bookingApiController = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    paymentController.getapi();
    return Scaffold(
      backgroundColor: Appcolor.background,
      body: Obx(() {
        if (paymentController.loader.value) {
          return Center(child: CircularProgressIndicator());
        } else if (paymentController.paymentList.isEmpty) {
          return Center(child: Text("No payment found"));
        } else {

          return ListView.builder(
            itemCount: paymentController.paymentList.length,
            itemBuilder: (context, index) {
              final payment = paymentController.paymentList[index];
              DateTime dateTime = DateTime.parse(payment.date);
              final formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
              return Column(
                children: [
                  Card(
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
                        "Booking ID: ${payment.booking_id}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 15, color: Colors.black),
                              children: [
                                TextSpan(
                                    text: 'Amount: ',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: payment.amount),
                              ],
                            ),
                          ),
                          SizedBox(height: 4),

                          RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 13, color: Colors.black),
                              children: [
                                TextSpan(
                                    text: "Date: ",
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: formattedDate),
                              ],
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.green),
                            onPressed: () {
                              Get.to(
                                    () => AddPaymentPage(),
                                arguments: {
                                  "isEdit": true,
                                  "amount": payment.amount,
                                  "id": payment.id,
                                  "booking_id": payment.booking_id.toString(),
                                  "date": formattedDate,
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              paymentController.delapi(payment.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (index == paymentController.paymentList.length - 1)
                    SizedBox(height: 100),
                ],
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          paymentController.clr();
          Get.to(AddPaymentPage());
        },
        backgroundColor: Appcolor.primary,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
