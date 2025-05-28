import 'package:autisticchildren/TestScreen.dart';
import 'package:autisticchildren/parent/auth/logic/autho_state.dart';
import 'package:autisticchildren/parent/auth/logic/parent_login_cubit.dart';
import 'package:autisticchildren/parent/auth/screens/singin.dart';
import 'package:autisticchildren/parent/auth/widget/inputField.dart';
import 'package:autisticchildren/parent/home/screen/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
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
                    'assets/images/logen_bg.jpg',
                  ),
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  top: 5.h,
                  left: 32.w,
                  child: Text(
                    "أهلا بك ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                //start the name
                Positioned(
                  top: 13.h,
                  left: 6.w,
                  child: UserInput(
                    fieldName: 'اسم الامستخدم',
                    numbers: false,
                    icon: Icons.person,
                    data: name,
                    password: false,
                  ),
                ),
                //end the name
                //start the email
                Positioned(
                  top: 24.h,
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
                //start the phone
                Positioned(
                  top: 34.h,
                  left: 6.w,
                  child: UserInput(
                    fieldName: 'رقم الهاتف ',
                    numbers: true,
                    icon: Icons.phone,
                    data: phone,
                    password: false,
                  ),
                ),
                //end the phone
                //start the pass
                Positioned(
                  top: 45.h,
                  left: 6.w,
                  child: UserInput(
                    fieldName: 'كلمت السر ',
                    numbers: false,
                    icon: Icons.password,
                    data: pass,
                    password: true,
                  ),
                ),
                //end the pass
                // start btn sing up
                Positioned(
                    top: 60.h,
                    left: 2.w,
                    child: BlocListener<ParentLoginCubit, ParentAthoState>(
                      listener: (context, state) {
                        if (state is ParentSuccessState) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideoScreen()),
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

                          if (state is ParentWaitingForVerificationState) {
                            context
                                .read<ParentLoginCubit>()
                                .checkEmailVerified(state.user);

                            return Column(
                              children: [
                                CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "تم إرسال رابط التفعيل، نتحقق من التفعيل الآن...",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            );
                          }

                          // الزر الرئيسي
                          return GestureDetector(
                            onTap: () {
                              if (!(name.text.isEmpty ||
                                  email.text.isEmpty ||
                                  phone.text.isEmpty ||
                                  pass.text.isEmpty)) {
                                context.read<ParentLoginCubit>().singUp(
                                      email: email.text,
                                      pass: pass.text,
                                      phone: phone.text,
                                      name: name.text,
                                    );
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
                              width: 45.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'أنشاء حساب',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                          );
                        },
                      ),
                    )),
                //end btn singup
                Positioned(
                    bottom: 5.h,
                    right: 5.w,
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SingIn(),
                            ))
                      },
                      child: Text(
                        "!  لدي حساب بلفعل ",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          //decoration: TextDecoration.underline,
                          // decorationColor: Colors.blue
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
