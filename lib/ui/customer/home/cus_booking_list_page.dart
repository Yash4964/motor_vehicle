import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor_vehicle/controller_api/booking_api_controller.dart';
import 'package:motor_vehicle/ui/customer/home/booking_details_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class BookingListPage extends StatelessWidget {
  BookingListPage({super.key});

  BookingApiController bookingApiController = Get.put(BookingApiController());

  @override
  Widget build(BuildContext context) {
    bookingApiController.bookingget();
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      body: Obx(() {
        if (bookingApiController.loader.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (bookingApiController.bookingList.isEmpty) {
          return Center(child: Text('Not data Found'));
        }
        return ListView.builder(
          itemCount: bookingApiController.bookingList.length,
          itemBuilder: (BuildContext context, int index) {
            final booking = bookingApiController.bookingList[index];
            DateTime dateTime = DateTime.parse(booking.joining_date);
            final formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
            return Padding(
              padding: EdgeInsets.all(5.0),
              child: Card(
                elevation: 2,
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    Get.to(
                      () => BookingDetailsPage(),
                      arguments: {"Booking_id": booking.id},
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/person.jpg',
                            width: 90,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text(
                                  booking.learner_name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Appcolor.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "Package: ${booking.package_id}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                              // Text("Booking Date: ${booking.joining_date}",
                              //     style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                              Text(
                                "Joining Date: ${formattedDate}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                "Joining Time: ${booking.time_slot}",
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
