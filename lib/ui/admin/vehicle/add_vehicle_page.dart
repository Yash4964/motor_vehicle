import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';


class AddVehiclePage extends StatelessWidget {
  AddVehiclePage({super.key});

  var args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Vehicle Details', style: TextStyle(color: Colors.white)),
        backgroundColor:Appcolor.primary,
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
                  border: Border.all(
                    color: Colors.lightBlue,
                    width: 2.5,
                  ),
                ),
                padding: const EdgeInsets.all(2),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(args?[1] ?? 'assets/images/default_car.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {},
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
            Center(
              child: Text(
                args?[0] ?? 'Vehicle Name',
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),

            const SizedBox(height: 20),
            labels("Vehicle Name"),
            TextFieldWidget(
              hint: args?[0] ?? 'e.g. Swift',
              textInputType: TextInputType.name,
            ),

            labels("Car Number"),
            TextFieldWidget(
              hint: args?[2] ?? 'e.g. GJ01 AB 1234',
              textInputType: TextInputType.text,
            ),

            labels("Vehicle Type"),
            TextFieldWidget(
              hint: "e.g. Sedan, SUV, Hatchback",
              textInputType: TextInputType.text,
            ),

            labels("Model Year"),
            TextFieldWidget(
              hint: "e.g. 2022",
              textInputType: TextInputType.number,
            ),

            labels("Color"),
            TextFieldWidget(
              hint: "e.g. White",
              textInputType: TextInputType.text,
            ),

            const SizedBox(height: 20),
            InkWell(
              onTap: () {

              },
              child: Container(
                width: double.infinity,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:Appcolor.primary,
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
