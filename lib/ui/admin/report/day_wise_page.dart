import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateController extends GetxController {
  var datepick = 'Select Date'.obs;
}

class DayWisePage extends StatelessWidget {
  DayWisePage({super.key});

  final DateController c = Get.put(DateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _selecteddate(context);
                },
                child: Text("Select Day"),
              ),
            ),
            SizedBox(height: 16),
            // Obx(
            //       () => Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5),
            //       color: Color.fromARGB(255, 226, 230, 236),
            //     ),
            //     padding: EdgeInsets.only(left: 5),
            //     width: double.infinity,
            //     child: Padding(
            //       padding: const EdgeInsets.all(15.0),
            //       child: Text(c.datepick.value),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _selecteddate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      c.datepick.value =
      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }
}
