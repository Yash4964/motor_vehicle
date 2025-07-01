import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MonthController extends GetxController {
  var datepick = 'Select Month'.obs;
}

class MonthWisePage extends StatelessWidget {
  MonthWisePage({super.key});

  final MonthController c = Get.put(MonthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Month Picker")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _selectMonth(context),
              child: Text("Select Month"),
            ),
            SizedBox(height: 20),
            Obx(() => Text(
              c.datepick.value,
              style: TextStyle(fontSize: 20),
            )),
          ],
        ),
      ),
    );
  }

  void _selectMonth(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      helpText: "Select a Date", // Optional
      initialDatePickerMode: DatePickerMode.year, // Opens in year view
    );

    if (picked != null) {
      // Format and store only Month & Year
      c.datepick.value = DateFormat('MMMM yyyy').format(picked); // e.g. "March 2026"
    }
  }
}
