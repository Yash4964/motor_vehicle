import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/utils/app_enum.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';
import '../../../controller/camera_contoller.dart';
import '../../../controller/vehicle_api_controller.dart';

class AddVehiclePage extends StatelessWidget {
  AddVehiclePage({super.key});

  var args = Get.arguments;
  VehicleController vehicleController = Get.put(VehicleController());

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    vehicleController.imageController.returnimage.value = null;
    if (args?['isEdit'] ?? false) {
      vehicleController.setData(Get.arguments);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Vehicle Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Picker
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.lightBlue,
                            width: 2.5,
                          ),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: Obx(
                              () => Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                backgroundImage: vehicleController
                                    .imageController.returnimage.value !=
                                    null
                                    ? FileImage(File(vehicleController
                                    .imageController
                                    .returnimage
                                    .value!
                                    .path))
                                    : const AssetImage(
                                    'assets/images/default_person.png')
                                as ImageProvider,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    vehicleController.imageController.camera();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: Colors.lightBlue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.add,
                                        color: Colors.white, size: 22),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        'Vehicle Details',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 20),

                    labels("Name"),
                    TextFieldWidget(
                      controller: vehicleController.name,
                      hint: 'Name',
                      textInputType: TextInputType.name,
                      inputTypeMode: InputTypeMode.normal,
                    ),

                    labels("Car No"),
                    TextFieldWidget(
                      controller: vehicleController.carno,
                      hint: '1234',
                      textInputType: TextInputType.text,
                      inputTypeMode: InputTypeMode.normal,
                    ),

                    labels("Model No"),
                    TextFieldWidget(
                      controller: vehicleController.modelno,
                      hint: "1234",
                      textInputType: TextInputType.text,
                      inputTypeMode: InputTypeMode.normal,
                    ),

                    labels("Color"),
                    TextFieldWidget(
                      controller: vehicleController.color,
                      hint: 'color name',
                      textInputType: TextInputType.text,
                      inputTypeMode: InputTypeMode.normal,
                    ),

                    labels("Description"),
                    TextFieldWidget(
                      controller: vehicleController.description,
                      hint: "enter description",
                      textInputType: TextInputType.text,
                      inputTypeMode: InputTypeMode.normal,
                    ),

                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          if ((args?['isEdit'] ?? false) == false) {
                            vehicleController.postVehicle();
                          } else {
                            vehicleController.updatevehicleapi(args['id']);
                            Get.back();
                          }
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

            // Loader overlay
            if (vehicleController.loader.value)
              Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        );
      }),
    );
  }

  Widget labels(String txt) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6, left: 5),
      child: Text(txt, style: const TextStyle(fontSize: 16)),
    );
  }
}
