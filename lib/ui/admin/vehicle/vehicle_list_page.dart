import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/ui/admin/driver/add_driver_page.dart';
import 'package:motor_vehicle/ui/admin/driver/view_driver_details.dart';
import 'package:motor_vehicle/ui/admin/vehicle/add_vehicle_page.dart';
import 'package:motor_vehicle/ui/admin/vehicle/view_vehicle_details.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class VehicleListPage extends StatelessWidget {
  VehicleListPage({super.key});

  final List<Map<String, String>> customers = [
    {
      'name': 'Swift',
      'car_no': 'GJ05AB1234',
      'image': 'assets/images/baleno.jpg',
    },
    {
      'name': 'Baleno',
      'car_no': 'MH12 XY 4567',
      'image': 'assets/images/baleno.jpg',
    },
    {
      'name': 'Brezza',
      'car_no': 'DL09 CD 7890',
      'image': 'assets/images/brezza.png',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        title:  Text('Vehicle List',style: TextStyle(color: Colors.white),),
        backgroundColor: Appcolor.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (BuildContext context ,int index) {
          final customer = customers[index];
          return Card(
            color: Appcolor.container,
            margin:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 2,
            child: ListTile(
              contentPadding:  EdgeInsets.all(12),
              leading: InkWell(
                onTap: (){
                  Get.to(
                        () => ViewVehicleDetails(),
                    arguments:[
                      customer['name'] ,
                      customer['image'] ,
                      customer['car_no'] ,
                    ],
                  );
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: AssetImage(customer['image']!),
                ),

              ),
              title: InkWell(
                onTap: (){
                  Get.to(CustomerProfilePage());
                },
                child: Text(
                  customer['name']!,
                  style:  TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 1),
                        child: Icon(Icons.directions_car_filled, size: 17),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          customer['car_no']!,
                          style:  TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  IconButton(
                    icon:  Icon(Icons.edit, color: Colors.green),
                    onPressed: () {
                      Get.to(()=>AddVehiclePage(),arguments:[
                        customer['name'] ,
                        customer['image'] ,
                        customer['car_no'] ,
                      ],);
                    },
                  ),
                  IconButton(
                    icon:  Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context)
                          {
                            return AlertDialog(
                              title: Text("Delete"),
                              content:  Text("Are you Sure delete",style: TextStyle(fontSize: 16),),
                              actions: [

                                TextButton(

                                    onPressed: (){
                                      Get.back();
                                    }, child:Text("Cancel",style: TextStyle(fontSize: 18),)
                                ),
                                TextButton(
                                    onPressed: (){}, child:Text("ok",style: TextStyle(fontSize: 18),)
                                )

                              ],

                            );
                          }
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
        onPressed: (){
          Get.to(AddVehiclePage());
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Appcolor.primary,
      ),
    );
  }
}
