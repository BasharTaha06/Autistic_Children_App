import 'package:autisticchildren/Btns/btns.dart';
import 'package:autisticchildren/child/logic/child_cubit.dart';
import 'package:autisticchildren/child/logic/child_state.dart';
import 'package:autisticchildren/child/screens/child-reset-pass.dart';
import 'package:autisticchildren/child/screens/child_sing_up.dart';
import 'package:autisticchildren/login_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../widget/inputField.dart';

class ChildSignIn extends StatefulWidget {
  @override
  State<ChildSignIn> createState() => _ChildSignInState();
}

class _ChildSignInState extends State<ChildSignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/loginbg.webp', // خلفية مختلفة للطفل لو تحب
            width: 100.w,
            height: 100.h,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  SizedBox(height: 8.h),
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
                    "مرحبًا بك يا صغيري 👋",
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  UserInput(
                    fieldName: 'البريد الالكتروني',
                    numbers: false,
                    icon: Icons.email,
                    data: email,
                    password: false,
                  ),
                  UserInput(
                    fieldName: 'كلمة السر',
                    numbers: false,
                    icon: Icons.lock,
                    data: pass,
                    password: true,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetChildPassword()),
                        );
                      },
                      child: Text(
                        "نسيت كلمة المرور؟",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  BlocListener<ChildAuthCubit, ChildAuthState>(
                    listener: (context, state) {
                      if (state is ChildSuccessState) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Btns()),
                        );
                      } else if (state is ChildAuthFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: BlocBuilder<ChildAuthCubit, ChildAuthState>(
                      builder: (context, state) {
                        if (state is ChildLoadingState) {
                          return CircularProgressIndicator(color: Colors.white);
                        }
                        return ElevatedButton(
                          onPressed: () {
                            if (email.text.isNotEmpty && pass.text.isNotEmpty) {
                              context.read<ChildAuthCubit>().signIn(
                                    email: email.text.trim(),
                                    password: pass.text.trim(),
                                  );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('يرجى ملء جميع الحقول'),
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
                            'تسجيل دخول الطفل',
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
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChildSignUp()));
                      },
                      child: Text(
                        'انشاء حساب للطفل ',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 76, 175, 145),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ChooseTeypeOfLodding(),
              ),
              (route) => false);
        },
        child: Icon(
          Icons.arrow_back_ios_sharp,
          color: Colors.white,
        ),
      ),
    );
  }
}
