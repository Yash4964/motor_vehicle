import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/attendance/add_attendance_page.dart';
import 'package:motor_vehicle/ui/admin/customer/addcustomer_page.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class AttendanceListPage extends StatelessWidget {
  AttendanceListPage({super.key});

  final List<Map<String, String>> customers = [
    {
      'name': 'Dixa Patel',
      'email': 'john.doe@example.com',
      'phone': '9876543210',
      'image': 'assets/images/person1.jpg',
    },
    {
      'name': 'Priya Sharma',
      'email': 'priya.sharma3232@example.com',
      'phone': '9123456780',
      'image': 'assets/images/person2.jpg',
    },
    {
      'name': 'Amit Patel',
      'email': 'abc.patel@example.com',
      'phone': '9012345678',
      'image': 'assets/images/person3.jpg',
    },
    {
      'name': 'Reena Mehta',
      'email': 'reena.mehta@example.com',
      'phone': '9988776655',
      'image': 'assets/images/person4.jpg',
    },
    {
      'name': 'Karan Singh',
      'email': 'karan.singh@example.com',
      'phone': '9876512345',
      'image': 'assets/images/person5.jpg',
    },
    {
      'name': 'Divya Trivedi',
      'email': 'divya.trivedi@example.com',
      'phone': '9123459876',
      'image': 'assets/images/person6.jpg',
    },
    {
      'name': 'Ravi Desai',
      'email': 'ravi.desai@example.com',
      'phone': '9345678901',
      'image': 'assets/images/person7.jpg',
    },
    {
      'name': 'Nikita Goyal',
      'email': 'nikita.goyal@example.com',
      'phone': '9554433221',
      'image': 'assets/images/person8.jpg',
    },
    {
      'name': 'Suresh Kumar',
      'email': 'suresh.kumar@example.com',
      'phone': '9001122334',
      'image': 'assets/images/persons9.jpg',
    },
    {
      'name': 'Rajesh Joshi',
      'email': 'rajesh.joshi@example.com',
      'phone': '9911223344',
      'image': 'assets/images/person10.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        title: Text('Attendance List', style: TextStyle(color: Colors.white)),
        backgroundColor: Appcolor.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (BuildContext context, int index) {
          final customer = customers[index];
          return Card(
            color: Appcolor.container,
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 2,
            child: ListTile(
              contentPadding: EdgeInsets.all(12),
              leading: InkWell(
                onTap: () {
                  Get.to(
                    () => CustomerProfilePage(),
                    arguments: [
                      customer['name'],
                      customer['email'],
                      customer['image'],
                      customer['phone'],
                    ],
                  );
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(customer['image']!),
                ),
              ),
              title: InkWell(
                onTap: () {
                  Get.to(
                    () => CustomerProfilePage(),
                    arguments: [
                      customer['name'],
                      customer['email'],
                      customer['image'],
                      customer['phone'],
                    ],
                  );
                },
                child: Text(
                  customer['name']!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.green),
                    onPressed: () {
                      Get.to(
                        () => AddAttendancePages(),
                        arguments: [customer['image']],
                      );
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
                              "Are you sure you want to delete?",
                              style: TextStyle(fontSize: 16),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(fontSize: 18),
                                ),
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
          Get.to(AddAttendancePages());
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Appcolor.primary,
      ),
    );
  }
}
