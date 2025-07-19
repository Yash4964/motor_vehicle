import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/utils/app_enum.dart';

import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

import '../../../controller/camera_contoller.dart';
import '../../../controller_api/vehicle_api_controller.dart';


class AddVehiclePage extends StatelessWidget {
  AddVehiclePage({super.key});

  var args = Get.arguments;
  CameraContoller c = Get.put(CameraContoller());

  VehicleController v = Get.put(VehicleController());
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    if(args?['isEdit']??false)
    {
      v.setData(Get.arguments);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Vehicle Details', style: TextStyle(color: Colors.white)),
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
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.lightBlue,
                      width: 2.5,
                    ),
                  ),padding: EdgeInsets.all(2),
                  child: Obx(()=>
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            backgroundImage:
                            c.returnimage.value != null ? FileImage(File(c.returnimage.value!.path))
                                : AssetImage('assets/images/default_person.png') as ImageProvider,

                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {},
                              child: InkWell(
                                onTap: ()
                                {
                                  c.camera();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration:  BoxDecoration(
                                    color: Colors.lightBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child:  Icon(Icons.add, color: Colors.white, size: 22),
                                ),
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
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),

              labels("Name"),
              TextFieldWidget(
                controller: v.name,
                hint: 'Name',
                textInputType: TextInputType.name,
                inputTypeMode: InputTypeMode.normal,
              ),

              labels("Car No"),
              TextFieldWidget(
                controller: v.carno,
                hint: 'GJ01243',
                textInputType: TextInputType.text,
                inputTypeMode: InputTypeMode.carno,
              ),

              labels("Model No"),
              TextFieldWidget(
                controller: v.modelno,
                hint: "FVS425",
                textInputType: TextInputType.text,
                inputTypeMode: InputTypeMode.normal,
              ),

              labels("Color"),
              TextFieldWidget(
                controller: v.color,
                hint: 'color name',
                textInputType: TextInputType.text,
                inputTypeMode: InputTypeMode.normal,
              ),

              labels("Description"),
              TextFieldWidget(
                controller: v.description,
                hint: "enter description",
                textInputType: TextInputType.text,
                inputTypeMode: InputTypeMode.normal,
              ),



              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Get.back();
                  if((args?["isEdit"] ?? false) == false)
                  {
                    v.postapi(v.name.text, v.carno.text, v.modelno.text, v.color.text, v.description.text);

                  }
                  else
                  {
                    v.editapi(args['id'],v.name.text, v.carno.text, v.modelno.text, v.color.text, v.description.text);

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

