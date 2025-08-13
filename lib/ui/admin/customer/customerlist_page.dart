import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/customer/addcustomer_page.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/controller/customer_api_controller.dart';


class CustomerListPage extends StatelessWidget {
  CustomerListPage({super.key});

  CustomerController cusapi = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    cusapi.getCustomerList();
    return Scaffold(
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        title: Text('Customer List', style: TextStyle(color: Colors.white)),
        backgroundColor: Appcolor.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Obx(
        () {
            if (cusapi.loader.value) {
              return Center(child: CircularProgressIndicator());
            }
          else if(cusapi.customerlist.isEmpty)
            {
              return Center(child: Text("No customers found"));
            }
          else
            { return
              ListView.builder(
                itemCount: cusapi.customerlist.length,
                itemBuilder: (BuildContext context, int index) {
                  final customer = cusapi.customerlist[index];
                  return Column(
                    children: [
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        elevation: 2,
                        color: Appcolor.container,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12),
                          leading: InkWell(
                            onTap: () {
                              // Profile page navigation here if needed
                            },
                            child: CircleAvatar(
                              radius: 27,
                              backgroundColor: Colors.grey[300],
                              child: ClipOval(
                                child: (customer.image != null && customer.image.isNotEmpty)
                                    ? Image.network(
                                  customer.image,
                                  width: 54,
                                  height: 54,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      "assets/images/person3.jpg",
                                      width: 54,
                                      height: 54,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                                    : Image.asset(
                                  "assets/images/person3.jpg",
                                  width: 54,
                                  height: 54,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          title: InkWell(
                            onTap: () {
                              Get.to(CustomerProfilePage());
                            },
                            child: Text(
                              customer.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                                      "${customer.email}",
                                      style: TextStyle(fontSize: 13),
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
                                    customer.mobile_no,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,

                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.green),
                                onPressed: () {
                                  Get.to(
                                        () => AddcustomerPage(),
                                    arguments: {
                                      "isEdit": true,
                                      "name": customer.name,
                                      "email": customer.email,
                                      "password": customer.password,
                                      "mobileno": customer.mobile_no.toString(),
                                      "age": customer.age.toString(),
                                      "address": customer.address,
                                      "pincode": customer.pincode.toString(),
                                      "id": customer.id,
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Delete"),
                                        content: Text(
                                          "Are you Sure delete",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              cusapi.deletecustomerapi(customer.id);
                                              Get.back();
                                            },
                                            child: Text(
                                              "ok",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (index == cusapi.customerlist.length - 1)
                        SizedBox(height: 150),
                    ],
                  );
                },
              );
            }
        }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cusapi.clr();
          Get.to(AddcustomerPage());
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Appcolor.primary,
      ),
    );
  }
}
