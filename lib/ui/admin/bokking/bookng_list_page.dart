import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/bokking/add_booking_page.dart';
import 'package:motor_vehicle/ui/customer/home/booking_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class BookingListPage extends StatelessWidget {
  BookingListPage({super.key});

  final List<Map<String, dynamic>> c = [
    {
      'customer_name': 'Ashish',
      'booking_name': 'Booking 001',
      'vehicle_name': 'Swift',
      'package_name': 'Package 1',
      'days' : 15,
      'km':5,
      'joining_date': '2025-06-26',
      'price':1500,
      'booking_date':'2025-06-25',
      'joining_time': '6:30 AM',
    },
    {
      'customer_name': 'Rajesh',
      'booking_name': 'Booking 002',
      'vehicle_name': 'Baleno',
      'package_name': 'Package 2',
      'days' : 15,
      'km':5,
      'joining_date': '2025-06-26',
      'price':1500,
      'booking_date':'2025-06-25',
      'joining_time': '6:30 AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking List', style: TextStyle(color: Colors.white)),
        backgroundColor:Appcolor.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: c.length,
        itemBuilder: (BuildContext context, int index) {
          final booking = c[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 2,
            child: ListTile(
              contentPadding: EdgeInsets.all(12),
              title: InkWell(
                onTap: (){
                  Get.to(()=> BookingPage(),
                  arguments: [
                    booking['vehicle_name'],
                    booking['customer_name'],
                    booking['package_name'],
                    booking['days'],
                    booking['km'],
                    booking['price'],
                    booking['joining_date'],
                    booking['booking_date'],
                    'admin',
                  ]);
                },
                child: Text(
                  booking['booking_name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Package: ${booking['package_name']}", style: TextStyle(fontSize: 15, color: Colors.grey[700])),
                    Text("Joining Date: ${booking['joining_date']}", style: TextStyle(fontSize: 15, color: Colors.grey[700])),
                    Text("Joining Time: ${booking['joining_time']}", style: TextStyle(fontSize: 15, color: Colors.grey[700])),
                  ],
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.green),
                    onPressed: () {
                      Get.to(() => AddBookingPage(), arguments: booking);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Delete"),
                            content: Text(
                              "Are you sure you want to delete this booking?",
                              style: TextStyle(fontSize: 16),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Cancel", style: TextStyle(fontSize: 18)),
                              ),
                              TextButton(
                                onPressed: () {

                                  Get.back();
                                },
                                child: Text("OK", style: TextStyle(fontSize: 18)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),

            ),


          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddBookingPage());
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Appcolor.primary,
      ),
    );
  }
}
