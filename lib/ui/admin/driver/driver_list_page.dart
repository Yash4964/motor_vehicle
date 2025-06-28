import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/customer/addcustomer_page.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/ui/admin/driver/add_driver_page.dart';
import 'package:motor_vehicle/ui/admin/driver/view_driver_details.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class DriverListPage extends StatelessWidget {
  DriverListPage({super.key});

  final List<Map<String, String>> customers = [
    {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'phone': '9876543210',
      'image': 'assets/images/person1.jpg',
    },
    {
      'name': 'Priya Sharma',
      'email': 'priya.sharma3232@example.com',
      'phone': '9123456780',
      'image': 'assets/images/person2.jpg',
    },
    {
      'name': 'Amit Patel',
      'email': 'abc.patel@example.com',
      'phone': '9012345678',
      'image': 'assets/images/person3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Driver List',style: TextStyle(color: Colors.white),),
        backgroundColor: Appcolor.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
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
                        () => ViewDriverDetailsPage(),
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
              title: InkWell(
                onTap: (){
                  Get.to(CustomerProfilePage());
                },
                child: Text(
                  customer['name']!,
                  style:  TextStyle(fontWeight: FontWeight.bold),
                ),
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  IconButton(
                    icon:  Icon(Icons.edit, color: Colors.green),
                    onPressed: () {
                      Get.to(()=>AddDriverPage(),arguments:[
                        customer['name'] ,
                        customer['email'] ,
                        customer['image'] ,
                        customer['phone'] ,
                      ],);
                    },
                  ),
                  IconButton(
                    icon:  Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context)
                          {
                            return AlertDialog(
                              title: Text("Delete"),
                              content:  Text("Are you Sure delete",style: TextStyle(fontSize: 16),),
                              actions: [

                                TextButton(

                                    onPressed: (){
                                      Get.back();
                                    }, child:Text("Cancel",style: TextStyle(fontSize: 18),)
                                ),
                                TextButton(
                                    onPressed: (){}, child:Text("ok",style: TextStyle(fontSize: 18),)
                                )

                              ],

                            );
                          }
                      );
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
          Get.to(AddDriverPage());
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Appcolor.primary,
      ),
    );
  }
}
