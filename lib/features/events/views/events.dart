import 'package:flutter/material.dart';
import 'package:urge/common/widgets/colors.dart';


class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
            body: const Center(child: Text('Events in progress',
      style: TextStyle(color: Colors.white, fontSize: 18),)),

    );
  }
}