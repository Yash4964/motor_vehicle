import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/customer/addcustomer_page.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/ui/admin/payment/update_payment_page.dart';

class DaysPage extends StatefulWidget {
  const DaysPage({super.key});

  @override
  State<DaysPage> createState() => _DaysPageState();
}

class _DaysPageState extends State<DaysPage> {
  DateTime? _selectedDate;

  final List<Map<String, String>> customers = [
    {
      'name': 'John Doe',
      'EMI': '2',
      'email': 'john.doe@example.com',
      'phone': '9876543210',
      'image': 'assets/images/person1.jpg',
    },
    {
      'name': 'Priya Sharma',
      'EMI': '2',
      'email': 'priya.sharma3232@example.com',
      'phone': '9123456780',
      'image': 'assets/images/person2.jpg',
    },
    {
      'name': 'Amit Patel',
      'EMI': '2',
      'email': 'abc.patel@example.com',
      'phone': '9012345678',
      'image': 'assets/images/person3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2100),
              ).then((date) {
                if (date != null) {
                  setState(() {
                    _selectedDate = date;
                  });
                }
              });
            },
            child: const Text('Pick a date'),
          ),
          Text(
            _selectedDate == null
                ? 'No date selected'
                : 'Selected Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: customers.length,
              itemBuilder: (BuildContext context, int index) {
                final customer = customers[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
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
                    title: InkWell(
                      onTap: () {
                        Get.to(CustomerProfilePage());
                      },
                      child: Text(
                        customer['name']!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text('Pending EMI: '),
                            Text(
                              customer['EMI']!,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.call, size: 16),
                            SizedBox(width: 4),
                            Text(
                              customer['phone']!,
                              style: TextStyle(fontSize: 13),
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
      ),
    );
  }
}
