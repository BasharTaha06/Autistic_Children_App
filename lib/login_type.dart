import 'package:autisticchildren/TestScreen.dart';
import 'package:autisticchildren/parent/Logic/autho_state.dart';
import 'package:autisticchildren/parent/Logic/parent_login_cubit.dart';
import 'package:autisticchildren/parent/home/imergance.dart';
import 'package:autisticchildren/parent/screens/resetPass.dart';
import 'package:autisticchildren/parent/auth/screens/singup.dart';
import 'package:autisticchildren/widget/inputField.dart';
// import 'package:autisticchildren/parent/home/screen/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ChooseTeypeOfLodding extends StatelessWidget {
  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Image(
                  image: AssetImage(
                    'assets/images/check.png',
                  ),
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.fill,
                ),
                Positioned(
                    top: 5.h,
                    left: 25.w,
                    child: Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: Image(
                        image: AssetImage(
                          'assets/images/APP-LOGO.png',
                        ),
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    )),
                Positioned(
                  top: 35.h,
                  left: 5.w,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "Parent-Log-in");
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 5.h, bottom: 10.h),
                      width: 90.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 228, 176, 4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'تسجيل ولي أمر',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Positioned(
                  top: 47.h,
                  left: 5.w,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "Child-Log-in");
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 5.h, bottom: 10.h),
                      width: 90.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 228, 176, 4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'تسجيل الابن / الابنه',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -7.h,
                  // left: 5.w,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImerganceDesplay()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 5.h, bottom: 10.h),
                      width: 50.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 163, 8, 8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'زر الطوارئ',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
