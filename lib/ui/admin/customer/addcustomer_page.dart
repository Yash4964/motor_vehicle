import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller/camera_contoller.dart';
import 'package:motor_vehicle/controller_api/customer_api_controller.dart';
import 'package:motor_vehicle/ui/admin/customer/customerlist_page.dart';
import 'package:motor_vehicle/utils/app_enum.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

// ignore: must_be_immutable
class AddcustomerPage extends StatelessWidget {
  AddcustomerPage({super.key});

  var args=Get.arguments;
  final _formkey = GlobalKey<FormState>();

  CameraContoller c = Get.put(CameraContoller());
  CustomerApiController cusapi = Get.put(CustomerApiController());
  @override
  Widget build(BuildContext context) {
    if(args?['isEdit']??false){
      cusapi.setData(Get.arguments);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Customer Details', style: TextStyle(color: Colors.white)),
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
               SizedBox(height: 10),
               Center(
                child: Text(
                   'Customer Details',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
               SizedBox(height: 20),

              labels("Name"),
              TextFieldWidget(
                controller: cusapi.cname,
                hint: 'Name',
                textInputType: TextInputType.name,
              ),

              labels("Email"),
              TextFieldWidget(
                controller: cusapi.email,
                hint:  'ex: jon.smith@gmail.com',
                textInputType: TextInputType.emailAddress,
                inputTypeMode: InputTypeMode.email,
              ),



              labels("Password"),
              TextFieldWidget(
                controller:cusapi.pass,
                hint: "password",
                obscureText: true,
              ),

              labels("Mobile"),
              TextFieldWidget(
                controller: cusapi.mobile,
                hint:"91+ 9698521475",
                textInputType: TextInputType.phone,
                inputTypeMode: InputTypeMode.phone,
              ),

              labels("Age"),
              TextFieldWidget(
                controller: cusapi.age,
                hint: "Age must be 18+",
                textInputType: TextInputType.number,
              ),

              labels("Address"),
              TextFieldWidget(
                controller: cusapi.address,
                hint: "Address",
                textInputType: TextInputType.text,
              ),

              labels("Pincode"),
              TextFieldWidget(
                controller: cusapi.pincode,
                hint:"Pincode",
                obscureText: false,
                textInputType: TextInputType.number,
                inputTypeMode: InputTypeMode.pincode,
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {

                },
                child: InkWell(
                  onTap: ()
                  {
                    if(_formkey.currentState!.validate())
                      {
                        if((args?['isEdit'] ?? false) == false) {
                          cusapi.postcustomerapi(
                            cusapi.cname.text,
                            cusapi.email.text,
                            cusapi.pass.text,
                            cusapi.mobile.text,
                            cusapi.age.text,
                            cusapi.address.text,
                            cusapi.pincode.text,
                          );
                          Get.back();
                        }
                        else
                        {
                          cusapi.updatecustomerapi(
                            args['id'],
                            cusapi.cname.text,
                            cusapi.email.text,
                            cusapi.pass.text,
                            cusapi.mobile.text,
                            cusapi.age.text,
                            cusapi.address.text,
                            cusapi.pincode.text,

                          );
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
                    child:  Text(
                        "Submit",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
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
