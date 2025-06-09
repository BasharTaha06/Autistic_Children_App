import 'package:autisticchildren/Btns/btns.dart';
import 'package:autisticchildren/TestScreen.dart';
import 'package:autisticchildren/parent/Login/logic/child_logic/child_cubit.dart';
import 'package:autisticchildren/parent/Login/resetPass.dart';
import 'package:autisticchildren/parent/Login/screens/child_sing_in.dart';
import 'package:autisticchildren/parent/Login/screens/login_type.dart';
import 'package:autisticchildren/parent/Login/screens/parent-login.dart';
import 'package:autisticchildren/parent/Login/logic/parent_login_cubit.dart';
import 'package:autisticchildren/parent/auth/screens/singin.dart';
import 'package:autisticchildren/parent/auth/screens/singup.dart';
// import 'package:autisticchildren/parent/home/screen/Home.dart';
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
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ParentLoginCubit()),
        BlocProvider(create: (_) => ChildAuthCubit()),
      ],
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
          home: (user != null) ? Btns() : ChooseTeypeOfLodding(),
          // home: ChooseTeypeOfLodding(),
          // home: ChildSignIn(),
          // home: ResetParentPassword(),
          debugShowCheckedModeBanner: false,
          routes: {
            "Parent-Log-in": (context) => ParentSingIn(),
            "Child-Log-in": (context) => ChildSignIn(),
          },
        );
      },
    );
  }
}
