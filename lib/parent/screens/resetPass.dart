import 'package:autisticchildren/TestScreen.dart';
import 'package:autisticchildren/parent/Logic/autho_state.dart';
import 'package:autisticchildren/parent/Logic/parent_login_cubit.dart';
import 'package:autisticchildren/parent/auth/screens/singin.dart';
import 'package:autisticchildren/widget/inputField.dart';
// import 'package:autisticchildren/parent/home/screen/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ResetParentPassword extends StatefulWidget {
  const ResetParentPassword({super.key});

  @override
  State<ResetParentPassword> createState() => _ResetParentPasswordState();
}

class _ResetParentPasswordState extends State<ResetParentPassword> {
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 3.h),
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
                SizedBox(height: 3.h),
                Text(
                  "استعيد حسابك الان ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold),
                ),

                //start the email
                UserInput(
                  fieldName: 'البريد الالكتروني',
                  numbers: false,
                  icon: Icons.email,
                  data: email,
                  password: false,
                  fillColor: const Color.fromARGB(115, 211, 211, 211),
                ),

                //end the email

                // start btn sing up
                BlocListener<ParentLoginCubit, ParentAthoState>(
                  listener: (context, state) {
                    if (state is ParentSuccessState) {
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => VideoScreen()),
                      // );
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
                                content: Text('تم ارسال رسالة اعادة التعيين'),
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
                          margin: EdgeInsets.only(top: 2.h, bottom: 10.h),
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
                ),
                //end btn ResetPassword

                Container(
                  width: 20.w,
                  height: 20.h,
                  child: Image(
                    image: AssetImage(
                      'assets/images/parentreset.png',
                    ),
                    // width: .w,
                    // height: 100.h,
                    fit: BoxFit.fill,
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
