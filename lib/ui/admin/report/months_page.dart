import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

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
              SizedBox(height: 10),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Customers:',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 6),
                        Text(
                          '3', 
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.redAccent),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Payment:',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 6),
                        Text(
                          '₹12,000', 
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.redAccent),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (BuildContext context, int index) {
                    final customer = customers[index];
                    return Card(
                      color: Appcolor.container,
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
                        title: Text(
                          customer['name']!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.email, size: 16),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    customer['email']!,
                                    style: TextStyle(fontSize: 13),
                                    overflow: TextOverflow.ellipsis,
                                  ),
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
          );
        },
      ),
    );
  }
}
