import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/ui/admin/package/add_package_page.dart';
import 'package:motor_vehicle/ui/admin/vehicle/add_vehicle_page.dart';
import 'package:motor_vehicle/ui/admin/vehicle/view_vehicle_details.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class PackageListPage extends StatelessWidget {
  PackageListPage({super.key});

  final List<Map<String, dynamic>> vehicles = [
    {
      'name': 'Swift',
      'car_no': 'GJ05AB1234',
      'package' : 'Package 1 ',
      'days': 15,
      'kilometers': 5,
      'price': 2500,
    },
    {
      'name': 'Baleno',
      'car_no': 'MH12 XY 4567',
      'package' : 'Package 2 ',
      'days': 10,
      'kilometers': 3,
      'price': 2000,
    },
    {
      'name': 'Brezza',
      'car_no': 'DL09 CD 7890',
      'package' : 'Package 3 ',
      'days': 7,
      'kilometers': 2,
      'price': 1800,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        title: Text('Package List', style: TextStyle(color: Colors.white)),
        backgroundColor:Appcolor.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: vehicles.length,
        itemBuilder: (BuildContext context, int index) {
          final vehicle = vehicles[index];
          return Card(
            color: Appcolor.container,
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 2,
            child: ListTile(
              contentPadding: EdgeInsets.all(12),
              title: InkWell(
                onTap: () {

                },
                child: Text(
                  vehicle['name'],
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                ),
              ),

              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Package: ${vehicle['package']}", style: TextStyle(fontSize: 15, color: Colors.grey[700]),),
                    Text("Days: ${vehicle['days']}  |  KM: ${vehicle['kilometers']}", style: TextStyle(fontSize: 15, color: Colors.grey[700]),),
                    Text("Price: ₹${vehicle['price']}", style: TextStyle(fontSize: 15, color: Colors.grey[700]),),
                  ],
                ),

              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.green),
                    onPressed: () {
                      Get.to(
                            () => AddPackagePage(),
                        arguments: [
                          vehicle['name'],
                          vehicle['package'],
                          vehicle['days'],
                          vehicle['kilometers'],
                          vehicle['price'],
                        ],
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
                              "Are you sure you want to delete this vehicle?",
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
                                  // Add delete logic here if needed
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
          Get.to(AddPackagePage());
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Appcolor.primary,
      ),
    );
  }
}
