import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/customer/home/booking_page.dart';

class BookingListPage extends StatelessWidget {
  BookingListPage({super.key});

  final List<Map<String, dynamic>> customers = [
    {
      'image': 'assets/images/person.jpg',
      'name': 'swift',
      'cname': 'john Doe',
      'packagename': 'package 1',
      'days': 10,
      'km': 5,
      'price': 150,
      'bookingdate': '12-9-2025',
      'joindate': '20-9-2025',
      'joining_time': '6:30 AM',
    },
    {
      'image': 'assets/images/person.jpg',
      'name': 'swift',
      'cname': 'krisha',
      'packagename': 'package 2',
      'days': 15,
      'km': 5,
      'price': 200,
      'bookingdate': '20-9-2025',
      'joindate': '25-9-2025',
      'joining_time': '6:30 AM',
    },
    {
      'image': 'assets/images/person.jpg',
      'name': 'swift',
      'cname': 'charu',
      'packagename': 'package 3',
      'days': 20,
      'km': 5,
      'price': 300,
      'bookingdate': '15-9-2025',
      'joindate': '25-9-2025',
      'joining_time': '6:30 AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (BuildContext context, int index) {
          final c = customers[index];
          return Padding(
            padding: EdgeInsets.all(5.0),
            child: Card(
              elevation: 2,
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Get.to(() => BookingPage(), arguments: [
                    c['name'],
                    c['cname'],
                    c['packagename'],
                    c['days'],
                    c['km'],
                    c['price'],
                    c['bookingdate'],
                    c['joindate'],
                  ]);
                },
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          c['image'] ?? '',
                          width: 100,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c['cname'] ?? '',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text("Package: ${c['packagename']}",
                                style: TextStyle(fontSize: 15, color: Colors.grey[700])),
                            Text("Booking Date: ${c['bookingdate']}",
                                style: TextStyle(fontSize: 15, color: Colors.grey[700])),
                            Text("Joining Date: ${c['joindate']}",
                                style: TextStyle(fontSize: 15, color: Colors.grey[700])),
                            Text("Joining Time: ${c['joining_time']}",
                                style: TextStyle(fontSize: 15, color: Colors.grey[700])),
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
      ),
    );
  }
}
