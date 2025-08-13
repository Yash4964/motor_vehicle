import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor_vehicle/controller/booking_controller.dart';
import 'package:motor_vehicle/ui/admin/bokking/add_booking_page.dart';
import 'package:motor_vehicle/ui/customer/home/booking_details_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';


class BookingListPage extends StatelessWidget {
  BookingListPage({super.key});

  BookingController b = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {

    b.bookingget();
    return Scaffold(
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        title: Text('Booking List', style: TextStyle(color: Colors.white)),
        backgroundColor: Appcolor.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Obx(
            ()  {
              if (b.bookingloader.value) {
                return Center(child: CircularProgressIndicator());
              }
              if(b.bookingList.isEmpty)
                {
                  return  Center(child: Text("No packages available"));
                }
              else
                {
                  return ListView.builder(
                    itemCount: b.bookingList.length,
                    itemBuilder: (context, index) {
                      final booking = b.bookingList[index];
                      DateTime dateTime = booking.joiningDate;

                      final formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

                      return Card(
                        color: Appcolor.container,
                        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12),
                          title: InkWell(
                            onTap: () {
                              Get.to(() => BookingDetailsPage(),
                              arguments:
                              {
                                "booking_id":booking.id.toString(),
                              });
                            },
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(8),

                              title: Text(
                                "Learner Name: ${booking.learnerName}",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),

                              subtitle: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Customer Name : ',
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${booking.customer.name}\n',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                    TextSpan(
                                      text: 'Package : ',
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "${booking.package.name}\n",
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                    TextSpan(
                                      text: 'joining_date : ',
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "${formattedDate}\n",
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                    TextSpan(
                                      text: 'Time Slot : ',
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "${booking.timeSlot}\n",
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),

                                  ],
                                ),
                              ),

                          //   child: Text(
                          //     "Learner Name : ${booking.learner_name}",
                          //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          //   ),
                          // ),
                          // subtitle: Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     SizedBox(height: 1,),
                          //     Text("Customer Name: ${booking.customer_id}"),
                          //     Text("Package: ${booking.package_id}"),
                          //     Text("Booking Date: ${formattedDate}"),
                          //     Text("Joining Time: ${booking.time_slot}"),
                          //   ],
                          // ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.green),
                                onPressed: () {
                                  b.clear();
                                  Get.to(() => AddBookingPage(), arguments: {
                                    "booking_id": booking.id.toString(),
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  b.deleteBooking(booking.id.toString());
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                        ),
                      );
                    },
                  );
                }
            }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          b.clear();
          Get.to(() => AddBookingPage());
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Appcolor.primary,
      ),
    );
  }
}
