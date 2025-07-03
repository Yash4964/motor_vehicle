import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart'; // <== Add this in pubspec.yaml
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';

class MonthsPage extends StatelessWidget {
  MonthsPage({super.key});

  final List<Map<String, String>> customers = [
    {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'phone': '9876543210',
      'image': 'assets/images/person7.jpg',
    },
    {
      'name': 'Priya Sharma',
      'email': 'priya.sharma3232@example.com',
      'phone': '9123456780',
      'image': 'assets/images/person8.jpg',
    },
    {
      'name': 'Amit Patel',
      'email': 'abc.patel@example.com',
      'phone': '9012345678',
      'image': 'assets/images/person6.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate;

    return Scaffold(
      body: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            children: <Widget>[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  showMonthPicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2025),
                  ).then((date) {
                    if (date != null) {
                      setState(() {
                        selectedDate = date;
                      });
                    }
                  });
                },
                child: const Text('Pick a month'),
              ),
              Text(
                selectedDate == null
                    ? 'No date selected'
                    : 'Selected Month: ${selectedDate!.month}/${selectedDate!.year}',
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (BuildContext context, int index) {
                    final customer = customers[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      elevation: 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: InkWell(
                          onTap: () {
                            Get.to(
                              () => CustomerProfilePage(),
                              arguments: [
                                customer['name'],
                                customer['email'],
                                customer['image'],
                                customer['phone'],
                              ],
                            );
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(customer['image']!),
                          ),
                        ),
                        title: Text(
                          customer['name']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.email, size: 16),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    customer['email']!,
                                    style: const TextStyle(fontSize: 13),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.call, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  customer['phone']!,
                                  style: const TextStyle(fontSize: 13),
                                ),
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
        },
      ),
    );
  }
}
