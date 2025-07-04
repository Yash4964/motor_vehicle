import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

class DropController extends GetxController {
  var selected = 'swift'.obs;
  var carname = ['swift', 'baleno', 'brezza'];
}

class AddPackagePage extends StatelessWidget {
  AddPackagePage({super.key});
  final DropController d = Get.put(DropController());
  var args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Package Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Appcolor.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                args?[1] ?? 'Package',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 20),
            labels("Package Name"),

            TextFieldWidget(
              hint: args?[1] ?? 'Package 1',
              textInputType: TextInputType.name,
            ),

            labels("Select Vehicle"),
            Obx(
              () => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFF3F4F6),
                ),
                padding: EdgeInsets.only(left: 5),
                width: double.infinity,
                child: DropdownButton(
                  hint: Text("Select Vehicle"),
                  value: d.selected.value,
                  items: [
                    for (var i in d.carname)
                      DropdownMenuItem(
                        child: Text(i, style: TextStyle(color: Colors.black87)),
                        value: i,
                      ),
                  ],
                  onChanged: (newValue) {
                    d.selected.value = newValue!;
                  },
                ),
              ),
            ),

            labels("Number of Days"),
            TextFieldWidget(
              hint: "${args?[2] ?? '15'}",
              textInputType: TextInputType.number,
            ),

            labels("Number of KiloMeters"),
            TextFieldWidget(
              hint: "${args?[3] ?? '5'}",
              textInputType: TextInputType.number,
            ),

            labels("Price"),
            TextFieldWidget(
              hint: "${args?[4] ?? '2500'}",
              textInputType: TextInputType.number,
            ),

            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Appcolor.primary,
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
