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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        user == null ? ChooseTeypeOfLodding() : Btns()),
              )
            });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 20.h,
              width: 20.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Image.asset(
                'assets/images/APP-LOGO.png',
                //fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              "S E E N A R",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
