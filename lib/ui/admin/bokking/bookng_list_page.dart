import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller_api/booking_api_controller.dart';
import 'package:motor_vehicle/ui/admin/bokking/add_booking_page.dart';
import 'package:motor_vehicle/ui/customer/home/booking_details_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class BookingListPage extends StatelessWidget {
  BookingListPage({super.key});

  BookingApiController b = Get.put(BookingApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        title: Text('Booking List', style: TextStyle(color: Colors.white)),
        backgroundColor: Appcolor.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Obx(
            ()  {
              if(b.bookingList.isEmpty)
                {
                  return  Center(child: CircularProgressIndicator());
                }
              else
                {
                  return ListView.builder(
                    itemCount: b.bookingList.length,
                    itemBuilder: (context, index) {
                      final booking = b.bookingList[index];
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
                              "Lerner Name : ${booking.lernerName}",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 1,),
                              Text("Customer Name: ${booking.customerId}"),
                              Text("Package: ${booking.packageId}"),
                              Text("Booking Date: ${booking.bookingDate}"),
                              Text("Joining Date: ${booking.joinigDate}"),
                              Text("Joining Time: ${booking.timeSlot}"),
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
                                    "customer_id": booking.customerId,
                                    "lerner_name": booking.lernerName,
                                    "package_id": booking.packageId,
                                    "joinig_date": booking.joinigDate,
                                    "time_slot": booking.timeSlot,
                                    "booking_date": booking.bookingDate,
                                    "id": booking.id,
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  b.deleteBooking(booking.id);
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
