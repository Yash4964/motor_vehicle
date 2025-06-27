import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/customer/addcustomer_page.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';

class AllPaymentDetails extends StatelessWidget {
  AllPaymentDetails({super.key});

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
    return Scaffold(
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (BuildContext context ,int index) {
          final customer = customers[index];
          return Card(
            margin:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 2,
            child: ListTile(
              contentPadding:  EdgeInsets.all(12),
              leading: InkWell(
                onTap: (){
                  Get.to(
                        () => CustomerProfilePage(),
                    arguments:[
                      customer['name'] ,
                      customer['email'] ,
                      customer['image'] ,
                      customer['phone'] ,
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
                style:  TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Icon(Icons.email, size: 16),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          customer['email']!,
                          style:  TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
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
                        style:  TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),

    );
  }
}
