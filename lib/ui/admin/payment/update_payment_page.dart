import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';


class Customercontoller extends GetxController {
  var cusselected = 'Rajubhai'.obs;
  var customerlist = ['Customer 1', 'Customer 1'];

  var bookingselected = 'Package 1'.obs;
  var bookinglist = ['Harsh', 'Ramesh', 'Suresh'];

  var datepick = '12/08/2025'.obs;

}

class UpdatePayment extends StatelessWidget {
  UpdatePayment({super.key});

  final Customercontoller c = Get.put(Customercontoller());
  var args=Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Payment Details',
          style: TextStyle(color: Colors.white),
        ),
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
                      backgroundImage: AssetImage(args?[1] ?? 'assets/images/default_person.png',),
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
            SizedBox(height: 10),

            labels("Select Customer"),
            const SizedBox(height: 20),
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
            labels("Select Booking Name"),
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
                  value: c.bookingselected.value,
                  items: [
                    for (var j in c.bookinglist)
                      DropdownMenuItem(child: Text(j), value: j),
                  ],
                  onChanged: (val) {
                    c.bookingselected.value = val!;
                  },
                ),
              ),
            ),
            labels("Amount"),
            TextFieldWidget(
              hint: args?[0] ?? '₨ : 1,000',
              textInputType: TextInputType.phone,
            ),
            labels("Joining Date"),
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
            const SizedBox(height: 20),
            InkWell(
              onTap: () {

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
             SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget labels(String txt) {
    return Padding(
      padding:  EdgeInsets.only(top: 12, bottom: 6, left: 5),
      child: Text(txt, style:  TextStyle(fontSize: 16)),
    );
  }

  void _selecteddate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
    );
    if(pickedDate != null) {
      c.datepick.value =
      "${pickedDate?.day ?? 0}/${pickedDate?.month ?? 0}/${pickedDate?.year ?? 0}";
    }
  }
}
