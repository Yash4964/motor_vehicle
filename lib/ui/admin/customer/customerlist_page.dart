import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/customer/addcustomer_page.dart';

class CustomerListPage extends StatelessWidget {
  CustomerListPage({super.key});

  final List<Map<String, String>> customers = [
    {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'phone': '9876543210',
      'image': 'assets/images/person.jpg'
    },
    {
      'name': 'Priya Sharma',
      'email': 'priya.sharma3232@example.com',
      'phone': '9123456780',
      'image': 'assets/images/person.jpg'
    },
    {
      'name': 'Amit Patel',
      'email': 'abc.patel@example.com',
      'phone': '9012345678',
      'image': 'assets/images/person.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer List',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,


        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (BuildContext context ,int index) {
          final customer = customers[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: InkWell(
                onTap: (){},
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Icon(Icons.email, size: 16),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          customer['email']!,
                          style: const TextStyle(fontSize: 13),
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  IconButton(
                    icon:  Icon(Icons.edit, color: Colors.green),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon:  Icon(Icons.delete, color: Colors.red),
                    onPressed: () {

                    },
                  ),

                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(AddcustomerPage());
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
