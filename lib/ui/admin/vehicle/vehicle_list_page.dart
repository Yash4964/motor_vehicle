import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller_api/vehicle_api_controller.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/ui/admin/vehicle/add_vehicle_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class VehicleListPage extends StatefulWidget {
  const VehicleListPage({super.key});

  @override
  State<VehicleListPage> createState() => _VehicleListPageState();
}

class _VehicleListPageState extends State<VehicleListPage> {
  final VehicleController vehicleController = Get.put(VehicleController());

  @override
  void initState() {
    super.initState();
    vehicleController.getVehicle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        title: const Text('Vehicle List', style: TextStyle(color: Colors.white)),
        backgroundColor: Appcolor.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (vehicleController.vehicleList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: vehicleController.vehicleList.length,
            itemBuilder: (BuildContext context, int index) {
              final vehicle = vehicleController.vehicleList[index];
              return Card(
                color: Appcolor.container,
                margin: const EdgeInsets.symmetric(horizontal:12, vertical: 10),
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  leading: InkWell(
                    onTap: () {
                      Get.to(() => AddVehiclePage(), arguments: {
                        "isEdit": true,
                        "name": vehicle.name,
                        "carno": vehicle.carno,
                        "modelno": vehicle.modelno,
                        "color": vehicle.color,
                        "description": vehicle.description,
                        "id": vehicle.id,
                      });
                    },
                    child: CircleAvatar(
                      radius: 27,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: const AssetImage("assets/images/person3.jpg"),
                    ),
                  ),
                  title: Text(
                    "CarName: ${vehicle.name}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'CarNo : ',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '${vehicle.carno}\n',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        TextSpan(
                          text: 'ModelNo : ',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "${vehicle.modelno}\n",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        TextSpan(
                          text: 'Color : ',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "${vehicle.color}\n",
                          style: TextStyle(color: Colors.grey[700]),
                        ),

                      ],
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.green),
                        onPressed: () {
                          Get.to(() => AddVehiclePage(), arguments: {
                            "isEdit": true,
                            "name": vehicle.name,
                            "carno": vehicle.carno,
                            "modelno": vehicle.modelno,
                            "color": vehicle.color,
                            "description": vehicle.description,
                            "id": vehicle.id,
                          });
                        },
                      ),
                      const SizedBox(width: 6),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Delete"),
                                content: const Text("Are you sure you want to delete this vehicle?",
                                    style: TextStyle(fontSize: 16)),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("Cancel", style: TextStyle(fontSize: 18))),
                                  TextButton(
                                      onPressed: () async {
                                        Get.back();
                                        await vehicleController.deletevehicleapi(vehicle.id);
                                        Get.snackbar("Deleted", "Vehicle deleted successfully",
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.redAccent,
                                            colorText: Colors.white);
                                      },
                                      child: const Text("OK", style: TextStyle(fontSize: 18))),
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
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          vehicleController.clr();
          Get.to(() => AddVehiclePage());
        },
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Appcolor.primary,
      ),
    );
  }
}