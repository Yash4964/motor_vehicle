import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller_api/booking_api_controller.dart';
import 'package:motor_vehicle/controller_api/customer_api_controller.dart';
import 'package:motor_vehicle/controller_api/package_api_controller.dart';
import 'package:motor_vehicle/model/customer_model.dart';
import 'package:motor_vehicle/model/package_model.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

import '../attendance/add_attendance_customer.dart';

class DropController extends GetxController {
  var timeselected = '6:30 AM'.obs;
  var timelist = ['6:30 AM', '7:00 AM', '7:30 AM'];
  var datepick = '12/08/2025'.obs;
}

class AddBookingPage extends StatelessWidget {
  AddBookingPage({super.key});

  final DropController d = Get.put(DropController());
  final Customercontoller c = Get.put(Customercontoller());
  final BookingApiController b = Get.put(BookingApiController());
  final CustomerApiController customerController = Get.put(CustomerApiController());
  final PackageConrollerApi packageController = Get.put(PackageConrollerApi());
  final args = Get.arguments;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    customerController.getCustomer();
    packageController.packageget();
    b.clr();
    if (args?['isEdit'] ?? false) {
      b.setData(args);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Booking Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Appcolor.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          child: Column(
            key: _formkey,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 20),
              labels("Select Customer"),
              Obx(() {
                if (customerController.customerlist.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                if(b.selectCustomer == null)
                {
                  if(args?["isEdit"] == true)
                  {
                    final customer_id = args["customer_id"] ?? "";
                    final match = customerController.customerlist.firstWhereOrNull(
                            (i) => i.id == customer_id
                    );
                    if(match != null)
                      {
                        b.selectCustomer = Rx<CustomerModel>(match,);
                      }
                  }
                  else
                    {
                      b.selectCustomer = Rx<CustomerModel>(customerController.customerlist[0]);
                    }
                }
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFF3F4F6),
                  ),
                  padding: EdgeInsets.only(left: 5),
                  width: double.infinity,
                  child: DropdownButton<CustomerModel>(
                    isExpanded: true,
                    value: b.selectCustomer?.value,
                    items: customerController.customerlist.map((customer) {
                      return DropdownMenuItem(
                        value: customer,
                        child: Text(customer.name),
                      );
                    }).toList(),
                    onChanged: (val) {
                      b.selectCustomer?.value = val!;
                    },
                  ),
                );
              }),

              labels("Booking Name"),
              TextFieldWidget(
                controller: b.learner_name,
                hint: 'Enter Booking Name',
                textInputType: TextInputType.name,
              ),

              labels("Select Package"),
              Obx(() {
                if(packageController.tolist.isEmpty)
                  {
                    return Center(child: CircularProgressIndicator());
                  }

                if(b.selectpackage == null)
                  {
                    if(args?["isEdit"] == true)
                      {
                        final packageid = args["package_id"];
                        final matchpack = packageController.tolist.firstWhereOrNull(
                                (i) => i.id == packageid
                        );
                        if(matchpack != null)
                          {
                            b.selectpackage ??= Rx<PackageModel>
                              (matchpack);
                          }
                      }
                    else
                      {
                        b.selectpackage = Rx<PackageModel>
                          (packageController.tolist[0]);
                      }
                  }
                b.selectpackage ??= Rx<PackageModel>
                  (packageController.tolist[0]);

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFF3F4F6),
                  ),
                  padding: EdgeInsets.only(left: 5),
                  width: double.infinity,
                  child: DropdownButton<PackageModel>(
                    isExpanded: true,
                    value: b.selectpackage?.value,
                    items: packageController.tolist.map((p) {
                      return DropdownMenuItem(
                        value: p,
                        child: Text(p.name ?? ""),
                      );
                    }).toList(),
                    onChanged: (val) {
                      b.selectpackage?.value = val!;
                    },
                  ),
                );
              }),

              labels("Joining Date"),
              InkWell(
                onTap: () => _selecteddate(context),
                child: AbsorbPointer(
                  child: Obx(() => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFFF3F4F6),
                    ),
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    child: Text(c.datepick.value),
                  )),
                ),
              ),

              labels("Select Time"),
              Obx(() => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFF3F4F6),
                ),
                padding: EdgeInsets.only(left: 5),
                width: double.infinity,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: d.timeselected.value,
                  items: d.timelist.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                  onChanged: (val) => d.timeselected.value = val!,
                ),
              )),

              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  b.joinigDate.text = c.datepick.value;
                  b.timeSlot.text = d.timeselected.value;
                  b.bookingDate.text = DateTime.now().toString().split(' ')[0];

                  if ((args?['isEdit'] ?? false) == false) {
                   b.bookingadd();
                  } else {
                    b.bookingupdate(args['id']);
                  }

                  Get.back();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Appcolor.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("Submit", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget labels(String txt) => Padding(
    padding: EdgeInsets.only(top: 12, bottom: 6, left: 5),
    child: Text(txt, style: TextStyle(fontSize: 16)),
  );

  void _selecteddate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      c.datepick.value = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }
}
