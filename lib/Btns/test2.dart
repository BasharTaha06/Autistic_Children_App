import 'package:flutter/material.dart';

class Test2 extends StatelessWidget {
  const Test2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Text(
          "this is test Two ,",
          style: TextStyle(fontSize: 35, color: Colors.white),
        ),
      ),
    );
  }
}
