import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/customer/viewcustomer_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class DaysPage extends StatefulWidget {
  const DaysPage({super.key});

  @override
  State<DaysPage> createState() => _DaysPageState();
}

class _DaysPageState extends State<DaysPage> {
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();

  final List<Map<String, dynamic>> customers = [
    {
      'name': 'Riya Mehta',
      'email': 'riya.mehta99@gmail.com',
      'phone': '9988776655',
      'image': 'assets/images/person1.jpg',
      'packagename': 'Package A',
      'days': 12,
      'km': 10,
      'price': 1800,
      'bookingdate': '10-10-2025',
      'joindate': '15-10-2025',
      'joining_time': '7:00 AM',
      'payment_status': 'Completed',
    },
    {
      'name': 'Anil Verma',
      'email': 'anil.verma@gmail.com',
      'phone': '9876541230',
      'image': 'assets/images/person2.jpg',
      'packagename': 'Package B',
      'days': 8,
      'km': 6,
      'price': 1400,
      'bookingdate': '18-10-2025',
      'joindate': '22-10-2025',
      'joining_time': '6:45 AM',
      'payment_status': 'Pending Payment',
    },
    {
      'name': 'Sneha Joshi',
      'email': 'sneha.joshi@gmail.com',
      'phone': '9123409876',
      'image': 'assets/images/person3.jpg',
      'packagename': 'Package C',
      'days': 20,
      'km': 15,
      'price': 2500,
      'bookingdate': '05-10-2025',
      'joindate': '10-10-2025',
      'joining_time': '6:15 AM',
      'payment_status': 'Completed',
    },
  ];


  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _dateController.text =
        "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),

      body: Column(
        children: <Widget>[
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _dateController,
              readOnly: true,
              onTap: () => _pickDate(context),
              decoration: InputDecoration(
                labelText: 'Select Date',
                hintText: 'Tap to pick a date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
          ),

          SizedBox(height: 2),
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
                      '₹5,000', // You can use a variable here
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.green),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: customers.length,
              itemBuilder: (BuildContext context, int index) {
                final customer = customers[index];
                return Card(
                  color: Appcolor.container,
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
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
                                radius: 35,
                                backgroundImage: AssetImage(customer['image']),
                              ),
                            ),
                            SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(customer['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  Text("Email: ${customer['email']}", style: TextStyle(fontSize: 13,overflow: TextOverflow.ellipsis)),
                                  Text("Phone: ${customer['phone']}", style: TextStyle(fontSize: 13)),
                                  Text("Package: ${customer['packagename']}", style: TextStyle(fontSize: 13)),
                                  Text("Days: ${customer['days']} | KM: ${customer['km']}", style: TextStyle(fontSize: 13)),
                                  Text("Booking Date: ${customer['bookingdate']}", style: TextStyle(fontSize: 13)),
                                  Text("Join Date: ${customer['joindate']} at ${customer['joining_time']}", style: TextStyle(fontSize: 13)),
                                  Text("Status: ${customer['payment_status']}", style: TextStyle(fontSize: 13,color: Colors.green)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Fees: ₹${customer['price']}", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Pending: ₹500", style: TextStyle(color: Colors.redAccent)),
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
      ),
    );
  }
}
