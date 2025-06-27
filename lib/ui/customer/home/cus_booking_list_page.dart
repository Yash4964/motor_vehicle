import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:motor_vehicle/ui/customer/home/booking_page.dart';

class BookingListPage extends StatelessWidget {
  BookingListPage({super.key});

  final List<Map<String, dynamic>> customers = [
    {
      'image': 'assets/images/person.jpg',
      'cname': 'john Doe',
      'packagename': 'package 1',
      'days': 10,
      'km': 5,
      'price': 150,
      'bookingdate': '12/9/2025',
      'joindate': '20/9/2025',
    },
    {
      'image': 'assets/images/person.jpg',
      'cname': 'krisha',
      'packagename': 'package 2',
      'days': 15,
      'km': 5,
      'price': 200,
      'bookingdate': '20/9/2025',
      'joindate': '25/9/2025',
    },
    {
      'image': 'assets/images/person.jpg',
      'cname': 'charu',
      'packagename': 'package 3',
      'days': 20,
      'km': 5,
      'price': 300,
      'bookingdate': '15/9/2025',
      'joindate': '25/9/2025',
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
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              color: Colors.white,
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: InkWell(
                  onTap: () {
                    Get.to(()=>BookingPage(),arguments: [
                      c['cname'],
                      c['packagename'],
                      c['days'],
                      c['km'],
                      c['price'],
                      c['bookingdate'],
                      c['joindate'],
                    ]
                    
                    );
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(c['image'] ?? ''),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['cname'] ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text("${c['packagename'] ?? ''}"),
                    // Text("${c['join'] ?? ''}"),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    
    );
  }
}
