import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller_api/package_api_controller.dart';
import 'package:motor_vehicle/controller_api/vehicle_api_controller.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class VehicleInformation extends StatelessWidget {
  var args = Get.arguments;
  VehicleController vehicleController =Get.put(VehicleController());
  PackageConrollerApi packageConrollerApi = Get.put(PackageConrollerApi());
  @override
  Widget build(BuildContext context) {
    final vehicle_id = args['id'];
    packageConrollerApi.getPackagesByVehicle(vehicle_id);
    return Scaffold(
      backgroundColor:Appcolor.background,
      body: SingleChildScrollView(
        child: Obx(()
        {
          if(vehicleController.vehicleList.isEmpty)
            {
              return Center(child: CircularProgressIndicator(),);
            }

          final match = vehicleController.vehicleList.firstWhereOrNull((i) =>i.id == vehicle_id);
          if (match == null)
            {
              return Center(child:Text('Vehicle not Found'));
            }
          else
            {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 13.0, left: 10, right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/baleno.jpg',
                              width: 155,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 1),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Text(
                                    "Name: ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 129, 129, 129),
                                    ),
                                  ),
                                  Text(
                                    match!.name,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),

                              Row(
                                children: [
                                  Text(
                                    "Car No : ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 129, 129, 129),
                                    ),
                                  ),
                                  Text(
                                    match.carno,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    "color : ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 129, 129, 129),
                                    ),
                                  ),
                                  Text(
                                    match.color,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    "Model No : ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 129, 129, 129),
                                    ),
                                  ),
                                  Text(
                                    match.modelno,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Car Packages",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),


                  Obx(() {
                    if(packageConrollerApi.loader.value)
                      {
                        return Center(child: CircularProgressIndicator(),);
                      }
                    if (packageConrollerApi.packagedetails.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text("No packages available."),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: packageConrollerApi.packagedetails[0].packages.length,
                      itemBuilder: (context, index) {
                        final pkg =  packageConrollerApi.packagedetails[0].packages[index];
                        return Padding(
                          padding: EdgeInsets.only(top: 10, left: 16, right: 16),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      "Package ${index + 1}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  _buildPackageRow("Day", pkg.days.toString()),
                                  SizedBox(height: 10),
                                  _buildPackageRow("Kilometer", "${pkg.km} / Per Day"),
                                  SizedBox(height: 10),
                                  _buildPackageRow("Price", pkg.price.toString()),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),



                  SizedBox(height: 12),
                ],
              );
            }
        }

        ),
      ),
    );
  }
  Widget _buildPackageRow(String label, String value) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Text(
            "$label : ",
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

}
