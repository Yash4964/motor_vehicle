import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/customer/addcustomer_page.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/ui/admin/driver/add_driver_page.dart';
import 'package:motor_vehicle/ui/admin/driver/view_driver_details.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

import '../../../controller/driver_api_controller.dart';

class DriverListPage extends StatelessWidget {
  DriverListPage({super.key});

  DriverConrollerApi driverConrollerApi = Get.put(DriverConrollerApi());

  @override
  Widget build(BuildContext context) {
    driverConrollerApi.getDriver();
    return Scaffold(
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        title:  Text('Driver List',style: TextStyle(color: Colors.white),),
        backgroundColor: Appcolor.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Obx(()
      {
        if(driverConrollerApi.driverlist.isEmpty)
          {
           return Center(child: CircularProgressIndicator());
          }
        else
          {
            return ListView.builder(
              itemCount: driverConrollerApi.driverlist.length,
              itemBuilder: (BuildContext context ,int index) {
                final driver = driverConrollerApi.driverlist[index];
                return Column(
                  children: [
                    Card(
                      color: Appcolor.container,
                      margin:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      elevation: 2,
                      child: ListTile(
                        contentPadding:  EdgeInsets.all(12),
                        leading: InkWell(
                          onTap: () {
                            // Navigate to driver details if needed
                          },

                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[200],
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        ),

                        title: InkWell(
                          onTap: (){
                            Get.to(CustomerProfilePage());
                          },
                          child: Text(
                            driver.name,
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
                                    driver.email,
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
                                  "${driver.mobileno}",
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
                                Get.to(()=>AddDriverPage(),
                                    arguments: {
                                      "isEdit":true,
                                      "name":driver.name,
                                      "email":driver.email,
                                      "password":driver.password,
                                      "mobileno":driver.mobileno.toString(),
                                      "age":driver.age.toString(),
                                      "address":driver.address,
                                      "licenceno":driver.licenceno,
                                      "id":driver.id,
                                    }
                                );
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
                                              onPressed: (){
                                                driverConrollerApi.deletedriverapi(driver.id);
                                                Get.back();
                                              }, child:Text("ok",style: TextStyle(fontSize: 18),)
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
                    ),
                    if (index == driverConrollerApi.driverlist.length - 1)
                      SizedBox(height: 150),
                  ],

                );
              },
            );
          }
      }

      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          driverConrollerApi.clr();
          Get.to(AddDriverPage());
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Appcolor.primary,
      ),
    );
  }
}
