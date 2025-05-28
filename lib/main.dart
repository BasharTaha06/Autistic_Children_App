import 'package:autisticchildren/TestScreen.dart';
import 'package:autisticchildren/parent/auth/logic/parent_login_cubit.dart';
import 'package:autisticchildren/parent/auth/screens/singin.dart';
import 'package:autisticchildren/parent/auth/screens/singup.dart';
import 'package:autisticchildren/parent/home/screen/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    BlocProvider(
      create: (_) => ParentLoginCubit(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          home: (user != null) ? VideoScreen() : SingIn(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
