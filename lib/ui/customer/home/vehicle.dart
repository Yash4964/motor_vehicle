import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/customer/home/vehicle_list_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class VehiclePage extends StatelessWidget {
  final List<Map<String, dynamic>> customers = [
    {
      'image': 'assets/images/swift.jpg',
      'name': 'Swift',
      'carno': 'GJ27AE5485',
      'color': 'White',
      'engineno': 'GJ236ASEW',
    },
    {
      'image': 'assets/images/brezza.png',
      'name': 'Brezza',
      'carno': 'GJ01AE5485',
      'color': 'White',
      'engineno': 'GJ236ASEW',
    },
    {
      'image': 'assets/images/baleno.jpg',
      'name': 'baleno',
      'carno': 'GJ13AE5485',
      'color': 'Grey',
      'engineno': 'GJ236ASEW',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Appcolor.background,
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: customers.length,
        itemBuilder: (BuildContext context, int index) {
          final c = customers[index];

          return Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () {
                Get.to(
                  () => VehicleInformation(),
                  arguments: [c['image'],c['name'], c['carno'], c['color'], c['engineno']],
                );
              },
              child: Card(
                color: Appcolor.container,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.asset(
                        c['image'],
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        c['name'],
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
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
