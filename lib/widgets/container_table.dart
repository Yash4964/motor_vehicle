import 'package:flutter/material.dart';

class Container_table extends StatelessWidget {
  final String? tital;
  final IconData? u_icon;
  final Color? bg_color;

    Container_table({
    super.key,
    this.tital,
    this.u_icon,
    this.bg_color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(-2,-2),
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bg_color ?? Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Icon(
              u_icon ?? Icons.people,
              color: Colors.white,
              size: 30,
            ),
          ),
          SizedBox(height: 10),
          Text(
            tital ?? '',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
