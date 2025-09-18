import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor_vehicle/model/report_model.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import '../../../controller/report_api_controller.dart';

class DaysPage extends StatefulWidget {
  const DaysPage({super.key});

  @override
  State<DaysPage> createState() => _DaysPageState();
}

class _DaysPageState extends State<DaysPage> {
  final ReportController reportController = Get.put(ReportController(), tag: 'days');

  // Filter toggle: true = Pending, false = Completed
  RxBool showPending = true.obs;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    reportController.selectedDate.value = today;
    final formatted = DateFormat('dd-MM-yyyy').format(today);
    reportController.dateController.text = formatted;
    reportController.fetchByDate(formatted);
  }

  Future<void> _pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: reportController.selectedDate.value,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      reportController.selectedDate.value = pickedDate;
      final formatted = DateFormat('dd-MM-yyyy').format(pickedDate);
      reportController.dateController.text = formatted;
      await reportController.fetchByDate(formatted);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      body: Obx(() {
        final isLoading = reportController.reportloader.value;
        Summary? summary = reportController.reportlist?.value.summary;
        final bookings = reportController.reportlist?.value.bookings ?? [];

        // Filter bookings based on Pending/Completed toggle
        final filteredBookings = bookings.where((booking) {
          final pendingAmount = booking?.pendingAmount ?? 0;
          return showPending.value ? pendingAmount > 0 : pendingAmount == 0;
        }).toList();

        return Column(
          children: [
            const SizedBox(height: 16),

            // Date Picker
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

            const SizedBox(height: 8),

            // Pending / Completed checkboxes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Obx(() => Checkbox(
                    value: showPending.value,
                    onChanged: (val) {
                      showPending.value = true;
                    },
                  )),
                  const Text('Pending'),
                  const SizedBox(width: 16),
                  Obx(() => Checkbox(
                    value: !showPending.value,
                    onChanged: (val) {
                      showPending.value = false;
                    },
                  )),
                  const Text('Completed'),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Summary Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                ],
              ),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Text('Total Customers:', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 6),
                      Text("${summary?.totalBookings}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Total Amount:', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 6),
                      Text("${summary?.totalPackagePrice}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Total Payment:', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 6),
                      Text("${summary?.totalPaid}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Total Pending:', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 6),
                      Text('₹${summary?.remainingBalance}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Booking List
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredBookings.isEmpty
                  ? const Center(child: Text("No data found."))
                  : ListView.builder(
                itemCount: filteredBookings.length,
                itemBuilder: (context, index) {
                  final booking = filteredBookings[index];
                  final joinDateFormatted =
                  DateFormat('dd-MM-yyyy').format(booking?.joiningDate ?? DateTime.now());

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
                                  // Navigate to customer profile if needed
                                },
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundImage: booking?.customer.image != null &&
                                      booking!.customer.image!.isNotEmpty
                                      ? NetworkImage(booking.customer.image!)
                                      : const AssetImage('assets/images/default_person.png')
                                  as ImageProvider,
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
                                    Text("Status:",
                                        style: const TextStyle(fontSize: 13, color: Colors.green)),
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
                              Text("Pending: ₹${booking?.pendingAmount ?? 0}",
                                  style: const TextStyle(color: Colors.redAccent)),
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
