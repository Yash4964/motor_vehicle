import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor_vehicle/controller/booking_controller.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class ComplateCustomerList extends StatelessWidget {
  ComplateCustomerList({super.key});

  final BookingController bookingApiController = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    bookingApiController.bookingget(); // fetch bookings
    return Scaffold(
      backgroundColor: Appcolor.background,
      body: Obx(() {
        if (bookingApiController.bookingloaders.value) {
          return const Center(child: CircularProgressIndicator());
        } else {

          final completedBookings = bookingApiController.bookingList
              .where((b) => (b.summary?.remainingBalance ?? -1) == 0)
              .toList();

          if (completedBookings.isEmpty) {
            return const Center(child: Text("No completed customers found"));
          }

          return ListView.builder(
            itemCount: completedBookings.length,
            itemBuilder: (context, index) {
              final booking = completedBookings[index];

              final formattedDate =
              DateFormat('yyyy-MM-dd').format(booking.joiningDate);

              return Column(
                children: [
                  Card(
                    color: Appcolor.container,
                    margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    elevation: 2,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage("assets/images/person3.jpg"),
                      ),
                      title: Text(
                        "Customer: ${booking.customer?.name ?? 'Unknown'}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black),
                              children: [
                                const TextSpan(
                                    text: 'Remaining Balance: ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:
                                    '${booking.summary?.remainingBalance ?? 0}'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black),
                              children: [
                                const TextSpan(
                                    text: "Joining Date: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(text: formattedDate),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (index == completedBookings.length - 1)
                    const SizedBox(height: 100),
                ],
              );
            },
          );
        }
      }),
    );
  }
}
