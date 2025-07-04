import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class MonthsPage extends StatelessWidget {
  MonthsPage({super.key});

  final List<Map<String, dynamic>> customers = [
    {
      'name': 'John Doe',
      'email': 'john.doe@gmail.com',
      'phone': '9876543210',
      'image': 'assets/images/person7.jpg',
      'packagename': 'Package 1',
      'days': 10,
      'km': 5,
      'price': 150,
      'bookingdate': '12-9-2025',
      'joindate': '20-9-2025',
      'joining_time': '6:30 AM',
      'payment_status': 'Pending Payment',
    },
    {
      'name': 'Priya Sharma',
      'email': 'priya.sharma3232@gmail.com',
      'phone': '9123456780',
      'image': 'assets/images/person8.jpg',
      'packagename': 'Package 2',
      'days': 15,
      'km': 5,
      'price': 2000,
      'bookingdate': '20-9-2025',
      'joindate': '25-9-2025',
      'joining_time': '6:30 AM',
      'payment_status': 'Completed',
    },
    {
      'name': 'Amit Patel',
      'email': 'abc.patel@gmail.com',
      'phone': '9012345678',
      'image': 'assets/images/person6.jpg',
      'packagename': 'Package 3',
      'days': 20,
      'km': 5,
      'price': 3000,
      'bookingdate': '15-9-2025',
      'joindate': '25-9-2025',
      'joining_time': '6:30 AM',
      'payment_status': 'Pending Payment',
    },
  ];

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    final TextEditingController monthController = TextEditingController(
      text: "${selectedDate.month}/${selectedDate.year}",
    );

    return Scaffold(
      backgroundColor: Appcolor.background,
      body: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            children: <Widget>[
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: monthController,
                  readOnly: true,
                  onTap: () async {
                    final picked = await showMonthPicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2026),
                    );
                    if (picked != null) {
                      setState(() {
                        selectedDate = picked;
                        monthController.text = "${picked.month}/${picked.year}";
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Month',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_month),
                  ),
                ),
              ),
              SizedBox(height: 2),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Total Customers:', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 6),
                        Text(
                          '${customers.length}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Total Payment:', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 6),
                        Text(
                          '₹5000',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (BuildContext context, int index) {
                    final customer = customers[index];
                    return Card(
                      color: Appcolor.container,
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
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
                                    radius: 35,
                                    backgroundImage: AssetImage(customer['image']),
                                  ),
                                ),
                                SizedBox(width: 18),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(customer['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      Text("Email: ${customer['email']}", style: TextStyle(fontSize: 13,overflow: TextOverflow.ellipsis,)),
                                      Text("Phone: ${customer['phone']}", style: TextStyle(fontSize: 13)),
                                      Text("Package: ${customer['packagename']}", style: TextStyle(fontSize: 13)),
                                      Text("Days: ${customer['days']} | KM: ${customer['km']}", style: TextStyle(fontSize: 13)),
                                      Text("Booking Date: ${customer['bookingdate']}", style: TextStyle(fontSize: 13)),
                                      Text("Join Date: ${customer['joindate']} at ${customer['joining_time']}", style: TextStyle(fontSize: 13)),
                                      Text("Status: ${customer['payment_status']}", style: TextStyle(fontSize: 13,color: Colors.green)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Fees: ₹${customer['price']}", style: TextStyle(fontWeight: FontWeight.bold)),
                                Text("Pending: ₹500", style: TextStyle(color: Colors.redAccent)),
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
