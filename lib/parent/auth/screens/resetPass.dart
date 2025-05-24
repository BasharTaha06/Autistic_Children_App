import 'package:autisticchildren/TestScreen.dart';
import 'package:autisticchildren/parent/auth/logic/autho_state.dart';
import 'package:autisticchildren/parent/auth/logic/parent_login_cubit.dart';
import 'package:autisticchildren/parent/auth/screens/singin.dart';
import 'package:autisticchildren/parent/auth/widget/inputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController email = TextEditingController();

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
                    'assets/images/logen_bg.jpg',
                  ),
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.fill,
                ),
                Positioned(
                    left: 3.w,
                    top: 5.h,
                    child: IconButton(
                        onPressed: () => {
                              Navigator.pop(context),
                            },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 25.sp,
                        ))),
                Positioned(
                  top: 28.h,
                  left: 15.w,
                  child: Text(
                    "استعيد حسابك الان ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                //start the email
                Positioned(
                  top: 33.h,
                  left: 6.w,
                  child: UserInput(
                    fieldName: 'البريد الالكتروني',
                    numbers: false,
                    icon: Icons.email,
                    data: email,
                    password: false,
                  ),
                ),
                //end the email

                // start btn sing up
                Positioned(
                    top: 43.h,
                    left: 15.w,
                    child: BlocListener<ParentLoginCubit, ParentAthoState>(
                      listener: (context, state) {
                        if (state is ParentSuccessState) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TestScreen()),
                          );
                        } else if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(state.error),
                                backgroundColor: Colors.blue),
                          );
                        }
                      },
                      child: BlocBuilder<ParentLoginCubit, ParentAthoState>(
                        builder: (context, state) {
                          if (state is ParentLodingState) {
                            return CircularProgressIndicator(
                              color: Colors.white,
                              padding: EdgeInsets.only(left: 16.w),
                            ); // أو أي تصميم تحميل
                          }

                          // الزر الرئيسي
                          return GestureDetector(
                            onTap: () {
                              if (!(email.text.isEmpty)) {
                                context.read<ParentLoginCubit>().resetPassword(
                                      email: email.text,
                                    );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('تم ارسال رسالة اعادة التعيين'),
                                    backgroundColor: Colors.blue,
                                  ),
                                );
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('الرجاء ملئ جميع الحقول'),
                                    backgroundColor: Colors.blue,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 5.h, bottom: 10.h),
                              width: 70.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'اعادة تعيين',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    )),
                //end btn ResetPassword
              ],
            ),
          ),
        ),
      ),
    );
  }
}
