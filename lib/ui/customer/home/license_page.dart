import 'package:flutter/material.dart';

class LicensePages extends StatelessWidget {
  const LicensePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildLicenseCard(
            title: '2 Wheeler License',
            price: '₹1800',
            terms:
            ' age 16+  Activa.\n'
                ' age 18+  bike.\n'
                'Valid ID proof AadharCard, 2photo, Sign.\n'
                'Basic road safety training is mandatory.',
            icon: Icons.pedal_bike,
          ),
          SizedBox(height: 16),
          _buildLicenseCard(
            title: '4 Wheeler License',
            price: '₹2000',
            terms:
            'You must be 18+ years.\nA learning license is needed.\nMust pass both theory and practical tests.\nValid ID proof AadharCard, 2photo, Sign.',
            icon: Icons.directions_car,
          ),
          SizedBox(height: 16),
          _buildLicenseCard(
            title: '2 & 4 Wheeler Combo',
            price: '₹2500',
            terms:
            'Combo license for both vehicle types.\nAll standard conditions apply.\nBest suited for multi-vehicle learners.',
            icon: Icons.directions_car,
          ),
        ],
      ),
    );
  }

  Widget _buildLicenseCard({
    required String title,
    required String price,
    required String terms,
    required IconData icon,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 36, color: Colors.blue),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Price: $price',
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Divider(),
            SizedBox(height: 4),
            Text(
              'Terms & Conditions:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4),
            Text(
              terms,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
