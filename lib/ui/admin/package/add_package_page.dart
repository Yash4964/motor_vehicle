import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller_api/vehicle_api_controller.dart';
import 'package:motor_vehicle/model/vehicle_model.dart';
import 'package:motor_vehicle/utils/app_enum.dart';
import '../../../controller_api/package_api_controller.dart';
import '../../../widgets/text_field_widget.dart';

class AddPackagePage extends StatelessWidget {
  AddPackagePage({super.key});

  final PackageConrollerApi packageConrollerApi = Get.put(PackageConrollerApi());
  final VehicleController vehicleController = Get.put(VehicleController());
  final _formkey = GlobalKey<FormState>();
  final args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    packageConrollerApi.clr();

    if (args?['isEdit'] ?? false) {
      packageConrollerApi.setData(args);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Package Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Details Fill',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),

              labels("Name"),
              TextFieldWidget(
                controller: packageConrollerApi.name,
                hint: 'Name',
                textInputType: TextInputType.name,
                inputTypeMode: InputTypeMode.normal,
              ),

              labels("Vehicle ID"),
              Obx(() {
                if (vehicleController.loader.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (vehicleController.vehicleList.isEmpty) {
                  return const Text("No vehicles available");
                }

                if (packageConrollerApi.selectedVehicle == null) {
                  if ((args?['isEdit'] ?? false) && args?['vehicleid'] != null) {
                    final vehicleId = args['vehicleid'];
                    final matchedVehicle = vehicleController.vehicleList
                        .firstWhereOrNull((v) => v.id == vehicleId);
                    if (matchedVehicle != null) {
                      packageConrollerApi.selectedVehicle = Rx<VehicleModel>(matchedVehicle);
                    }
                  } else {
                    packageConrollerApi.selectedVehicle = Rx<VehicleModel>(vehicleController.vehicleList.first);
                  }
                }


                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFFF3F4F6),
                  ),
                  padding: const EdgeInsets.only(left: 5),
                  child: DropdownButton<VehicleModel>(
                    isExpanded: true,
                    value: packageConrollerApi.selectedVehicle?.value,
                    items: vehicleController.vehicleList.map((vehicle) {
                      return DropdownMenuItem<VehicleModel>(
                        value: vehicle,
                        child: Text(vehicle.id),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        packageConrollerApi.selectedVehicle?.value = value;
                      }
                    },
                  ),
                );
              }),

              labels("Days"),
              TextFieldWidget(
                controller: packageConrollerApi.days,
                hint: "Number of days",
                textInputType: TextInputType.number,
                inputTypeMode: InputTypeMode.days,
              ),

              labels("Km"),
              TextFieldWidget(
                controller: packageConrollerApi.km,
                hint: 'Kilometer',
                textInputType: TextInputType.number,
                inputTypeMode: InputTypeMode.km,
              ),

              labels("Price"),
              TextFieldWidget(
                controller: packageConrollerApi.price,
                hint: "Enter price",
                textInputType: TextInputType.number,
                inputTypeMode: InputTypeMode.normal,
              ),

              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  if ((args?["isEdit"] ?? false) == false) {
                    packageConrollerApi.postapi();
                  } else {
                    packageConrollerApi.editapi();
                  }
                  Get.back();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget labels(String txt) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6, left: 5),
      child: Text(txt, style: const TextStyle(fontSize: 16)),
    );
  }
}
