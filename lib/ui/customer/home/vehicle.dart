import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller/vehicle_api_controller.dart';
import 'package:motor_vehicle/ui/customer/home/vehicle_list_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class VehiclePage extends StatelessWidget {
 
  VehicleController vehicleController = Get.put(VehicleController());
  @override

  Widget build(BuildContext context) {
    vehicleController.getVehicle();
    return Scaffold(
      backgroundColor:Appcolor.background,
      body: Obx(()
      {
        if(vehicleController.loader.value)
          {
            return Center(child: CircularProgressIndicator(),);
          }
        else if(vehicleController.vehicleList.isEmpty)
        {
          return Center(child: Text('Not data Found'));
        }
        else
          {
            return ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: vehicleController.vehicleList.length,
              itemBuilder: (BuildContext context, int index) {
                final v = vehicleController.vehicleList[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () {
                      Get.to(
                              () => VehicleInformation(),arguments: {
                                'id':v.id,
                      });
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
                              'assets/images/baleno.jpg',
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              v.name,
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
            );
          }
      }
      
           
      ),
    );
  }
}
