import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

class DropController extends GetxController {

  var timeselected = '6:30 AM'.obs;
  var timelist = ['6:30 AM', '7:00 AM', '7:30 AM'];
}

class Customercontoller extends GetxController {
  var cusselected = 'Dixa Patel'.obs;
  var customerlist = [
    'Dixa Patel',
    'Priya Sharma',
    'Amit Patel',
    'Reena Mehta',
    'Karan Singh',
    'Divya Trivedi',
    'Ravi Desai',
    'Nikita Goyal',
    'Suresh Kumar',
    'Rajesh Joshi',

  ];


  var datepick = '12/08/2025'.obs;

}


class AddAttendanceCustomer extends StatelessWidget {
  AddAttendanceCustomer({super.key});

  final DropController d = Get.put(DropController());
  final Customercontoller c = Get.put(Customercontoller());
  var args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Add Attendance ',
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
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(args?[0] ?? 'assets/images/default_person.png',),
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
            SizedBox(height: 20),
            labels("Select Driver name"),
            Obx(
                  () => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 226, 230, 236),
                ),
                padding: EdgeInsets.only(left: 5),
                width: double.infinity,
                child: DropdownButton(
                  isExpanded: true,
                  value: c.cusselected.value,
                  items: [
                    for (var j in c.customerlist)
                      DropdownMenuItem(child: Text(j), value: j),
                  ],
                  onChanged: (val) {
                    c.cusselected.value = val!;
                  },
                ),
              ),
            ),

            labels("Date"),
            InkWell(
              onTap: () {
                _selecteddate(context);
              },
              child: AbsorbPointer(
                absorbing: true,
                child: Obx(
                      () => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 226, 230, 236),
                    ),
                    padding: EdgeInsets.only(left: 5),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(c.datepick.value),
                    ),
                  ),
                ),
              ),
            ),

            labels("Select Time"),
            Container(
              child: Row(
                children: [
                  Obx(
                        () => Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          //filled: true,
                          color: Color.fromARGB(255, 226, 230, 236),
                        ),
                        padding: EdgeInsets.only(left: 5),

                        child: DropdownButton(
                          isExpanded: true,
                          value: d.timeselected.value,
                          items: [
                            for (var t in d.timelist)
                              DropdownMenuItem(
                                child: Text(t, style: TextStyle(color: Colors.black87)),
                                value: t,
                              ),
                          ],
                          onChanged: (timevalue) {
                            d.timeselected.value = timevalue!  ;
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Center(
                          child: Obx(() => Text(d.timeselected.value)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
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

  void _selecteddate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if(pickedDate != null) {
      c.datepick.value =
      "${pickedDate.day ?? 0}/${pickedDate.month ?? 0}/${pickedDate.year ?? 0}";
    }
  }
}
