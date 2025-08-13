import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/package/add_package_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import '../../../controller/package_api_controller.dart';

class PackageListPage extends StatelessWidget {
  PackageListPage({super.key});

  final PackageController p = Get.put(PackageController());

  @override
  Widget build(BuildContext context) {
    p.getPackageList();
    return Scaffold(
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        title: const Text('Package List', style: TextStyle(color: Colors.white)),
        backgroundColor: Appcolor.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (p.loader.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (p.tolist.isEmpty) {
          return const Center(child: Text("No packages available"));
        }

        return ListView.builder(
          itemCount: p.tolist.length,
          itemBuilder: (BuildContext context, int index) {
            final package = p.tolist[index];
            return Card(
              color: Appcolor.container,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              elevation: 2,
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                title: InkWell(
                  onTap: () {},
                  child: Text(
                    package.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Vehicle ID: ${package.vehicle_id}",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),
                      Text(
                        "Days: ${package.days}  |  KM: ${package.km}",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),
                      Text(
                        "Price: ₹${package.price}",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.green),
                      onPressed: () {
                        Get.to(
                              () => AddPackagePage(),
                          arguments: {
                            "isEdit": true,
                            "name" :package.name,
                            "vehicle_id" :package.vehicle_id,
                            "days" :package.days,
                            "km":package.km,
                            "price" :package.price,
                            "id": package.id,
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Delete"),
                              content: const Text(
                                "Are you sure you want to delete this package?",
                                style: TextStyle(fontSize: 16),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("Cancel", style: TextStyle(fontSize: 18)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    p.packagedelete(package.id);
                                    Get.back();
                                  },
                                  child: const Text("OK", style: TextStyle(fontSize: 18)),
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
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          p.clr();
          Get.to(() => AddPackagePage());
        },
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Appcolor.primary,
      ),
    );
  }
}
