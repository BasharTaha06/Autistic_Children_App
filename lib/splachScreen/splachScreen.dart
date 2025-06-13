import 'package:autisticchildren/Btns/btns.dart';
import 'package:autisticchildren/login_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import 'package:lashin/intro_pages/startPage.dart';
import 'package:sizer/sizer.dart';

class SplachtPage extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration(seconds: 3),
        () => {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          user == null ? ChooseTeypeOfLodding() : Btns()),
                  (route) => false)
            });
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 30.h,
              width: 30.h,
              decoration: BoxDecoration(
                color: Color.fromRGBO(249, 249, 249, 1),
                //borderRadius: BorderRadius.circular(100),
                /*  boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],*/
              ),
              child: Image.asset(
                'assets/images/logo1.jpg',
                //fit: BoxFit.contain,
              ),
            ),
            /* SizedBox(height: 5.h),
            Text(
              "S A N N A R",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold),
            ),*/
          ],
        ),
      ),
    );
  }
}
