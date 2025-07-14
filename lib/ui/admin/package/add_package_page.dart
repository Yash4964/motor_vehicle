import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller_api/package_api_controller.dart';
import '../../../widgets/text_field_widget.dart';


class AddPackagePage extends StatelessWidget {
  AddPackagePage({super.key});

  final PackageConrollerApi d = Get.put(PackageConrollerApi());

  var args = Get.arguments;
  @override
  Widget build(BuildContext context) {
    if(args?['isEdit']??false)
    {
      d.setData(Get.arguments);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Package Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  
                  color: Colors.white,
                  border: Border.all(color: Colors.lightBlue, width: 2.5),
                ),
                padding: const EdgeInsets.all(2),
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/default_person.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {

                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.lightBlue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: Colors.white, size: 22),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Package Details',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20),

            labels("Name"),
            TextFieldWidget(
              controller: d.name,
              hint: 'Name',
              textInputType: TextInputType.name,
            ),

            labels("Vehicle id"),
            TextFieldWidget(
              controller: d.vehicleid,
              hint: 'GJ01243',
              textInputType: TextInputType.number,
            ),

            labels("Days"),
            TextFieldWidget(
              controller: d.days,
              hint: "numbers of days",
              textInputType: TextInputType.number
              ,
            ),

            labels("Km"),
            TextFieldWidget(
              controller: d.km,
              hint: 'kliometer',
              textInputType: TextInputType.number,
            ),

            labels("Price"),
            TextFieldWidget(
              controller: d.price,
              hint: "enter description",
              textInputType: TextInputType.number,
            ),



            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Get.back();
                if((args?["isEdit"] ?? false) == false)
                {
                  d.postapi(d.name.text, d.vehicleid.text, d.days.text, d.km.text, d.price.text);

                }
                else
                {
                  d.editapi(args['id'],d.name.text, d.vehicleid.text, d.days.text, d.km.text, d.price.text);

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
    );
  }

  Widget labels(String txt) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6, left: 5),
      child: Text(txt, style: const TextStyle(fontSize: 16)),
    );
  }
}
