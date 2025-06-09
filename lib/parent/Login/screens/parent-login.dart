import 'package:autisticchildren/Btns/btns.dart';
import 'package:autisticchildren/TestScreen.dart';
import 'package:autisticchildren/parent/Login/screens/parent-sing-up.dart';
import 'package:autisticchildren/parent/Login/logic/autho_state.dart';
import 'package:autisticchildren/parent/Login/logic/parent_login_cubit.dart';
import 'package:autisticchildren/parent/Login/resetPass.dart';
import 'package:autisticchildren/parent/auth/screens/singin.dart';
import 'package:autisticchildren/parent/auth/screens/singup.dart';
import 'package:autisticchildren/parent/widget/inputField.dart';
// import 'package:autisticchildren/parent/home/screen/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ParentSingIn extends StatefulWidget {
  @override
  State<ParentSingIn> createState() => _ParentSingInState();
}

class _ParentSingInState extends State<ParentSingIn> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/parents-autho.jpg',
            width: 100.w,
            height: 100.h,
            fit: BoxFit.fill,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  SizedBox(height: 8.h),
                  // Logo
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
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    "أهلا بك",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(height: 1.h),
                  UserInput(
                    fieldName: 'البريد الالكتروني',
                    numbers: false,
                    icon: Icons.email,
                    data: email,
                    password: false,
                  ),
                  // SizedBox(height: 2.h),
                  UserInput(
                    fieldName: 'كلمة السر',
                    numbers: false,
                    icon: Icons.lock,
                    data: pass,
                    password: true,
                  ),
                  // SizedBox(height: 2.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetParentPassword(),
                          ),
                        );
                      },
                      child: Text(
                        "نسيت كلمة المرور؟",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  BlocListener<ParentLoginCubit, ParentAthoState>(
                    listener: (context, state) {
                      if (state is ParentSuccessState) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Btns()),
                        );
                      } else if (state is AuthFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: BlocBuilder<ParentLoginCubit, ParentAthoState>(
                      builder: (context, state) {
                        if (state is ParentLodingState) {
                          return CircularProgressIndicator(color: Colors.white);
                        }
                        return ElevatedButton(
                          onPressed: () {
                            if (email.text.isNotEmpty && pass.text.isNotEmpty) {
                              context.read<ParentLoginCubit>().singIn(
                                    email: email.text,
                                    pass: pass.text,
                                  );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('الرجاء ملئ جميع الحقول'),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 2.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'تسجيل دخول',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 3.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParentSingUp(),
                        ),
                      );
                    },
                    child: Text(
                      "أريد إنشاء حساب!",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
