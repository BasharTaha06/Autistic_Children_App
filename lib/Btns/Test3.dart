import 'package:autisticchildren/parent/Login/logic/parent_login_cubit.dart';
import 'package:autisticchildren/parent/Login/screens/login_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Test3 extends StatelessWidget {
  const Test3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 54, 244),
      body: Center(
        child: Column(
          children: [
            Text(
              "this is parent ,",
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
            MaterialButton(
                color: Colors.white,
                child: Text("out"),
                onPressed: () {
                  context.read<ParentLoginCubit>().signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => ChooseTeypeOfLodding()),
                  );
                })
          ],
        ),
      ),
    );
  }
}
