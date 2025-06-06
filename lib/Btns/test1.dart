import 'package:flutter/material.dart';

class Test1 extends StatelessWidget {
  const Test1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text(
          "this is test one ,",
          style: TextStyle(fontSize: 35, color: Colors.white),
        ),
      ),
    );
  }
}
