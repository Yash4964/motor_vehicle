import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor_vehicle/controller/booking_controller.dart';
import 'package:motor_vehicle/ui/customer/home/booking_details_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class BookingListPage extends StatelessWidget {
  BookingListPage({super.key});

  final BookingController bookingApiController = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    bookingApiController.bookingget();
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      body: Obx(() {
        if (bookingApiController.bookingloaders.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (bookingApiController.bookingList.isEmpty) {
          return const Center(child: Text('No data found'));
        }

        return ListView.builder(
          itemCount: bookingApiController.bookingList.length,
          itemBuilder: (BuildContext context, int index) {
            final booking = bookingApiController.bookingList[index];
            final formattedDate =
            DateFormat('yyyy-MM-dd').format(booking.joiningDate);

            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 2,
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    Get.to(
                          () => BookingDetailsPage(),
                      arguments: {"booking_id": booking.id.toString()},
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: (booking.customer.image != null &&
                              booking.customer.image.isNotEmpty)
                              ? Image.network(
                            booking.customer.image,
                            width: 90,
                            height: 120,
                            fit: BoxFit.cover,
                            loadingBuilder:
                                (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 90,
                                height: 120,
                                color: Colors.grey[200],
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/person.jpg',
                                width: 90,
                                height: 120,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                              : Image.asset(
                            'assets/images/person.jpg',
                            width: 90,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Text(
                                  booking.learnerName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Appcolor.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "Package: ${booking.package.name}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                "Joining Date: $formattedDate",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                "Joining Time: ${booking.timeSlot}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
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
            );
          },
        );
      }),
    );
  }
}
