// days_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor_vehicle/model/report_model.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import '../../../controller/report_api_controller.dart';

class MonthsPage extends StatefulWidget {
  const MonthsPage({super.key});

  @override
  State<MonthsPage> createState() => _MonthsPageState();
}

class _MonthsPageState extends State<MonthsPage> {

  final ReportController reportController = Get.put(ReportController(),tag: 'months'  );

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    reportController.selectedDate.value = today;
    final formatted = DateFormat('MM-yyyy').format(today);
    reportController.dateController.text = formatted;
    reportController.fetchByDate(formatted);
  }
  Future<void> _pickDate(BuildContext context) async {
    final initial = reportController.selectedDate.value;
    final pickedDate = await showMonthPicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      initialDate: initial,
    );

    if (pickedDate != null) {
      reportController.selectedDate.value = pickedDate;
      final formatted = DateFormat('MM-yyyy').format(pickedDate);
      reportController.dateController.text = formatted;
      await reportController.fetchByDate(formatted);
    }
    else
    {
      final today = DateTime.now();
      reportController.selectedDate.value = today;
      final formatted = DateFormat('MM-yyyy').format(today);
      reportController.dateController.text = formatted;
      await reportController.fetchByDate(today as String);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      body: Obx(() {
        final isLoading = reportController.reportloader.value;
        Summary? summary = reportController.reportlist?.value.summary;
        return Column(
          children: <Widget>[
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: reportController.dateController,
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
                        "${summary?.totalBookings}",
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
                        'Total Amount:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "${summary?.totalPackagePrice}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green),
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
                        "${summary?.totalPaid}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Total Pending:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '₹${summary?.remainingBalance}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                final isLoading = reportController.reportloader.value;
                final bookings = reportController.reportlist?.value.bookings ?? [];

                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (bookings.isEmpty) {
                  return const Center(child: Text("NOT DATA"));
                }
                return ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    final joinDateFormatted = DateFormat('dd-MM-yyyy')
                        .format(booking?.joiningDate ?? DateTime.now());

                    return Card(
                      color: Appcolor.container,
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    // navigate to customer profile if needed
                                  },
                                  child: const CircleAvatar(
                                    radius: 35,
                                    backgroundImage: AssetImage(
                                      'assets/images/default_person.png',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 18),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(booking?.customer.name ?? "Customer",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 16)),
                                      Text("Email: ${booking?.customer.email ?? '-'}",
                                          style: const TextStyle(
                                              fontSize: 13, overflow: TextOverflow.ellipsis)),
                                      Text("Phone: ${booking?.customer.mobileNo ?? '-'}",
                                          style: const TextStyle(fontSize: 13)),
                                      Text("Package: ${booking?.package.name ?? '-'}",
                                          style: const TextStyle(fontSize: 13)),
                                      Text(
                                          "Days: ${booking?.package.days ?? '-'} | KM: ${booking?.package.km ?? '-'}",
                                          style: const TextStyle(fontSize: 13)),
                                      Text("Join Date: $joinDateFormatted",
                                          style: const TextStyle(fontSize: 13)),
                                      Text(
                                          "Status:",
                                          style: const TextStyle(
                                              fontSize: 13, color: Colors.green)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Fees: ₹${booking?.package.price ?? 0}",
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                                // Replace this with real pending if available
                                Text("Pending: ₹${booking?.pendingAmount ?? 0}",
                                    style: TextStyle(color: Colors.redAccent)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
