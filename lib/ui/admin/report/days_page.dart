// days_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/controller/report_controller.dart';
import 'package:motor_vehicle/model/report_model.dart';

import '../../../controller_api/report_api_controller.dart';

class DaysPage extends StatefulWidget {
  const DaysPage({super.key});

  @override
  State<DaysPage> createState() => _DaysPageState();
}

class _DaysPageState extends State<DaysPage> {
  final Rx<DateTime> _selectedDate = DateTime.now().obs;
  final TextEditingController _dateController = TextEditingController();
  final ReportController _reportController = Get.put(ReportController());

  @override
  void initState() {
    super.initState();
    final initial = _selectedDate.value;
    final formatted = DateFormat('dd-MM-yyyy').format(initial);
    _dateController.text = formatted;
    _reportController.fetchByDate(formatted);
  }

  Future<void> _pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _selectedDate.value = pickedDate;
      final formatted = DateFormat('dd-MM-yyyy').format(pickedDate);
      _dateController.text = formatted;
      await _reportController.fetchByDate(formatted);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      body: Obx(() {
        final isLoading = _reportController.reportloader.value;
        final bookings = _reportController.allBookings();

        return Column(
          children: <Widget>[
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _dateController,
                readOnly: true,
                onTap: () => _pickDate(context),
                decoration: const InputDecoration(
                  labelText: 'Select Date',
                  hintText: 'Tap to pick a date',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
            ),
            const SizedBox(height: 2),
            Container(
              margin:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Total Customers:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${_reportController.totalCustomers()}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Total Payment:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '₹${_reportController.totalPayment().toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : bookings.isEmpty
                  ? const Center(child: Text("No bookings for selected date"))
                  : ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  final customer = booking.customer;
                  final package = booking.package;
                  final joinDateFormatted = DateFormat('dd-MM-yyyy')
                      .format(booking.joiningDate);
                  return Card(
                    color: Appcolor.container,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(
                                        () =>  CustomerProfilePage(),
                                    arguments: [
                                      customer.name,
                                      customer.email,
                                      customer.image,
                                      customer.mobileNo,
                                    ],
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage(
                                    'assets/images/default_person.png',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(customer.name,
                                        style: const TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            fontSize: 16)),
                                    Text("Email: ${customer.email}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            overflow:
                                            TextOverflow.ellipsis)),
                                    Text("Phone: ${customer.mobileNo}",
                                        style: const TextStyle(
                                            fontSize: 13)),
                                    Text("Package: ${package.name}",
                                        style: const TextStyle(
                                            fontSize: 13)),
                                    Text(
                                        "Days: ${package.days} | KM: ${package.km}",
                                        style: const TextStyle(
                                            fontSize: 13)),
                                    Text(
                                        "Join Date: $joinDateFormatted at ${booking.timeSlot}",
                                        style: const TextStyle(
                                            fontSize: 13)),
                                    Text(
                                        "Status: ${booking.hasJoiningDatePassed ? 'Joined' : 'Upcoming'}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.green)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Fees: ₹${package.price}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const Text("Pending: ₹500",
                                  style: TextStyle(
                                      color: Colors.redAccent)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
