import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller_api/vehicle_api_controller.dart';
import 'package:motor_vehicle/model/vehicle_model.dart';
import 'package:motor_vehicle/utils/app_enum.dart';

import '../../../controller_api/package_api_controller.dart';
import '../../../widgets/text_field_widget.dart';

class AddPackagePage extends StatelessWidget {
  AddPackagePage({super.key});

  final PackageConrollerApi d = Get.put(PackageConrollerApi());
  VehicleController vehicleController = Get.put(VehicleController());
  var args = Get.arguments;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (args?['isEdit'] ?? false) {
      d.setData(Get.arguments);
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
                controller: d.name,
                hint: 'Name',
                textInputType: TextInputType.name,
                inputTypeMode: InputTypeMode.normal,
              ),

              labels("Vehicle id"),
              Obx(() {
                if (vehicleController.vehicleList.isEmpty) {
                  return CircularProgressIndicator();
                }

                d.selectedVehicle ??= Rx<VehicleModel>(
                  vehicleController.vehicleList[0],
                );

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFF3F4F6),
                  ),
                  padding: EdgeInsets.only(left: 5),
                  width: double.infinity,
                  child: DropdownButton(
                    isExpanded: true,
                    value: d.selectedVehicle?.value,
                    items: vehicleController.vehicleList
                        .map(
                          (vehicle) => DropdownMenuItem(
                            value: vehicle,
                            child: Text(vehicle.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      d.selectedVehicle?.value = value as VehicleModel;
                    },
                  ),
                );
              }),

              labels("Days"),
              TextFieldWidget(
                controller: d.days,
                hint: "numbers of days",
                textInputType: TextInputType.number,
                inputTypeMode: InputTypeMode.days,
              ),

              labels("Km"),
              TextFieldWidget(
                controller: d.km,
                hint: 'kliometer',
                textInputType: TextInputType.number,
                inputTypeMode: InputTypeMode.km,
              ),

              labels("Price"),
              TextFieldWidget(
                controller: d.price,
                hint: "enter description",
                textInputType: TextInputType.number,
                inputTypeMode: InputTypeMode.normal,
              ),

              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Get.back();
                  if ((args?["isEdit"] ?? false) == false) {
                    d.postapi();
                  } else {
                    d.editapi();
                  }
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
