import 'package:flutter/material.dart';
import 'package:urge/common/widgets/colors.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body:const  Center(child: Text('Dashboard in progress',
      style: TextStyle(color: Colors.white, fontSize: 18),)),
    );
  }
}