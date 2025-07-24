import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/ui/admin/driver/add_driver_page.dart';
import 'package:motor_vehicle/ui/admin/driver/view_driver_details.dart';
import 'package:motor_vehicle/ui/admin/vehicle/add_vehicle_page.dart';
import 'package:motor_vehicle/ui/admin/vehicle/view_vehicle_details.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

import '../../../controller_api/vehicle_api_controller.dart';

class VehicleListPage extends StatelessWidget {
  VehicleListPage({super.key});

  VehicleController vehicleController = Get.put(VehicleController());

  @override
  Widget build(BuildContext context) {
    vehicleController.getVehicle();
    return Scaffold(
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        title:  Text('Vehicle List',style: TextStyle(color: Colors.white),),
        backgroundColor: Appcolor.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Obx(()
      {
        if(vehicleController.vehicleList.isEmpty)
          {
            return Center(child: CircularProgressIndicator());
          }
        else
          {
            return ListView.builder(
              itemCount: vehicleController.vehicleList.length,
              itemBuilder: (BuildContext context ,int index) {
                final vehicle = vehicleController.vehicleList[index];
                return Card(
                  color: Appcolor.container,
                  margin:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 2,
                  child: ListTile(
                    contentPadding:  EdgeInsets.all(12),
                    leading: InkWell(
                      onTap: (){
                        Get.to(()=>AddVehiclePage(),
                            arguments: {
                              "isEdit":true,
                              "name":vehicle.name,
                              "carno":vehicle.carno,
                              "modelno":vehicle.modelno,
                              "color":vehicle.color,
                              "description":vehicle.description,
                              "id":vehicle.id,
                            }
                        );
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: AssetImage("assets/images/person3.jpg"),
                      ),

                    ),
                    title: InkWell(
                      onTap: (){
                        Get.to(CustomerProfilePage());
                      },
                      child: Text(
                        vehicle.name,
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
                                vehicle.carno,
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
                            Get.to(()=>AddVehiclePage(),
                                arguments: {
                                  "isEdit":true,
                                  "name":vehicle.name,
                                  "carno":vehicle.carno,
                                  "modelno":vehicle.modelno,
                                  "color":vehicle.color,
                                  "description":vehicle.description,
                                  "id":vehicle.id,
                                }
                            );
                          },
                        ),
                        SizedBox(width: 8,),
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
                                          onPressed: (){
                                            vehicleController.deletevehicleapi(vehicle.id);
                                            Get.back();
                                          }, child:Text("ok",style: TextStyle(fontSize: 18),)
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
            );
          }
      }

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
