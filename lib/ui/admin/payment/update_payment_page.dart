import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';


class CustomerController extends GetxController
{
  var cusselected = 'Customer 1'.obs;
  var customerlist = ['Customer 1', 'Customer 2'];

  var bookingselected = 'Harsh'.obs;
  var bookinglist = ['Harsh', 'Ramesh', 'Suresh'];

  var datepick = '12/08/2025'.obs;

}

class UpdatePayment extends StatelessWidget {
  UpdatePayment({super.key});

  final CustomerController c = Get.put(CustomerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Payment Details',
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

            SizedBox(height: 10),

            labels("Select Customer"),
            const SizedBox(height: 20),
            Obx(
                  () => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFF3F4F6),
                ),
                padding: EdgeInsets.only(left: 5),
                width: double.infinity,
                child: DropdownButton(
                  isExpanded: true,
                  value: c.cusselected.value,
                  items: [
                    for (var i in c.customerlist)
                      DropdownMenuItem(child: Text(i), value: i),
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
                  color:Color(0xFFF3F4F6),
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
                  onChanged: (newval) {
                    c.bookingselected.value = newval!;
                  },
                ),
              ),
            ),
            labels("Amount"),
            TextFieldWidget(
              hint: '₨ : 1,000',
              textInputType: TextInputType.number,
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
                      color:Color(0xFFF3F4F6),
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
                  color: Appcolor.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFF3F4F6),
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
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      c.datepick.value =
      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }
}
