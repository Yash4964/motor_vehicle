import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor_vehicle/controller_api/booking_api_controller.dart';
import 'package:motor_vehicle/ui/admin/bokking/add_booking_page.dart';
import 'package:motor_vehicle/ui/customer/home/booking_details_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';


class BookingListPage extends StatelessWidget {
  BookingListPage({super.key});

  BookingApiController b = Get.put(BookingApiController());

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
              if (b.loader.value) {
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
                      DateTime dateTime = DateTime.parse(booking.joining_date);
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
                                "Booking_id":booking.id,
                              });
                            },
                            child: Text(
                              "Learner Name : ${booking.learner_name}",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 1,),
                              Text("Customer Name: ${booking.customer_id}"),
                              Text("Package: ${booking.package_id}"),
                              Text("Booking Date: ${formattedDate}"),
                              Text("Joining Time: ${booking.time_slot}"),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.green),
                                onPressed: () {
                                  b.clr();
                                  Get.to(() => AddBookingPage(), arguments: {
                                    "isEdit": true,
                                    "customer_id": booking.customer_id,
                                    "learner name": booking.learner_name,
                                    "package_id": booking.package_id,
                                    "joining_date":  formattedDate,
                                    "time_slot": booking.joining_date,
                                    "id": booking.id,
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  b.bookingdelete(booking.id);
                                },
                              ),
                            ],
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
          b.clr();
          Get.to(() => AddBookingPage());
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Appcolor.primary,
      ),
    );
  }
}
