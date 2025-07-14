import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/package/add_package_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

import '../../../controller_api/package_api_controller.dart';

class PackageListPage extends StatelessWidget {
  PackageListPage({super.key});
  PackageConrollerApi p = Get.put(PackageConrollerApi());

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        title: Text('Package List', style: TextStyle(color: Colors.white)),
        backgroundColor:Appcolor.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Obx(()=>
         ListView.builder(
          itemCount: p.tolist.length,
          itemBuilder: (BuildContext context, int index) {
            final package = p.tolist[index];
            return Card(
              color: Appcolor.container,
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              elevation: 2,
              child: ListTile(
                contentPadding: EdgeInsets.all(12),
                title: InkWell(
                  onTap: () {

                  },
                  child: Text(
                    package.name,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                ),

                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Package: ${package.name}", style: TextStyle(fontSize: 15, color: Colors.grey[700]),),
                      Text("Days: ${package.days}  |  KM: ${package.km}", style: TextStyle(fontSize: 15, color: Colors.grey[700]),),
                      Text("Price: ₹${package.price}", style: TextStyle(fontSize: 15, color: Colors.grey[700]),),
                    ],
                  ),

                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.green),
                      onPressed: () {
                        Get.to(
                              () => AddPackagePage(),
                          arguments: {
                            "isEdit":true,
                            "name":package.name,
                            "vehicleid":package.vehicleid,
                            "days":package.days.toString(),
                            "km":package.km.toString(),
                            "price":package.price.toString(),
                            "id":package.id,
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
                                "Are you sure you want to delete this package?",
                                style: TextStyle(fontSize: 16),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("Cancel", style: TextStyle(fontSize: 18)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    p.delapi(package.id);
                                    Get.back();
                                  },
                                  child: Text("OK", style: TextStyle(fontSize: 18)),
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
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          p.clr();
          Get.to(AddPackagePage());
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Appcolor.primary,
      ),
    );
  }
}
