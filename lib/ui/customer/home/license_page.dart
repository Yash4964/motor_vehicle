import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller/licence_api_controller.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class LicensePages extends StatelessWidget {
  LicensePages({super.key});
  final LicenceControllerApi licenceControllerApi = Get.put(LicenceControllerApi());

  @override
  Widget build(BuildContext context) {
    licenceControllerApi.licenceget(); // Call API

    return Scaffold(
      backgroundColor: Appcolor.background,
      body: Obx(() {
        if (licenceControllerApi.loader.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (licenceControllerApi.Licencelist.isEmpty) {
          return const Center(child: Text("No packages available"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: licenceControllerApi.Licencelist.length,
          itemBuilder: (context, index) {
            final licence = licenceControllerApi.Licencelist[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildLicenseCard(
                  title: licence.name,
                  price: licence.price,
                  terms: licence.description,
                  icon: _getIcon(licence.name),
              ),
            );
          },
        );
      }),
    );
  }

  IconData _getIcon(String type) {
    switch (type.toLowerCase()) {
      case '2wheeler':
        return Icons.pedal_bike;
      case '4wheeler':
        return Icons.directions_car;
      case 'combo':
        return Icons.motorcycle;
      default:
        return Icons.adjust_rounded;
    }
  }

  Widget _buildLicenseCard({
    required String title,
    required String price,
    required String terms,
    required IconData icon,
  }) {
    return Card(
      color: Appcolor.container,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 36, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Price: $price',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 4),
            const Text(
              'Terms & Conditions:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              terms,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
