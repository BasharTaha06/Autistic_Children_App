import 'package:autisticchildren/child/logic/child_cubit.dart';
import 'package:autisticchildren/login_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Test2 extends StatelessWidget {
  const Test2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Column(
          children: [
            Text(
              "this is test Two ,",
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
            MaterialButton(
                onPressed: () {
                  context.read<ChildAuthCubit>().signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => ChooseTeypeOfLodding()),
                  );
                },
                color: Colors.red,
                child: Text("out"))
          ],
        ),
      ),
    );
  }
}
