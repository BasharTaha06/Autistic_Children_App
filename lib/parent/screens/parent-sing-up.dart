import 'package:autisticchildren/Btns/btns.dart';
import 'package:autisticchildren/parent/screens/parent-login.dart';
import 'package:autisticchildren/parent/Logic/autho_state.dart';
import 'package:autisticchildren/parent/Logic/parent_login_cubit.dart';
import 'package:autisticchildren/parent/auth/screens/singin.dart';
import 'package:autisticchildren/widget/inputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ParentSingUp extends StatefulWidget {
  const ParentSingUp({super.key});

  @override
  State<ParentSingUp> createState() => _ParentParentSingUp();
}

class _ParentParentSingUp extends State<ParentSingUp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/log.jpg', // نفس الخلفية الخاصة باللوجين
            width: 100.w,
            height: 100.h,
            fit: BoxFit.fill,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  SizedBox(height: 250),
                  // Logo
                  /* Container(
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
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),*/
                  UserInput(
                    fieldName: 'اسم المستخدم',
                    numbers: false,
                    icon: Icons.person,
                    data: name,
                    password: false,
                  ),
                  UserInput(
                    fieldName: 'البريد الإلكتروني',
                    numbers: false,
                    icon: Icons.email,
                    data: email,
                    password: false,
                  ),
                  UserInput(
                    fieldName: 'رقم الهاتف',
                    numbers: true,
                    icon: Icons.phone,
                    data: phone,
                    password: false,
                  ),
                  UserInput(
                    fieldName: 'كلمة السر',
                    numbers: false,
                    icon: Icons.lock,
                    data: pass,
                    password: true,
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

                        if (state is ParentWaitingForVerificationState) {
                          context
                              .read<ParentLoginCubit>()
                              .checkEmailVerified(state.user);
                          return Column(
                            children: [
                              CircularProgressIndicator(color: Colors.white),
                              SizedBox(height: 2.h),
                              Text(
                                "تم إرسال رابط التفعيل، نتحقق من التفعيل الآن...",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          );
                        }

                        return ElevatedButton(
                          onPressed: () {
                            if (name.text.isNotEmpty &&
                                email.text.isNotEmpty &&
                                phone.text.isNotEmpty &&
                                pass.text.isNotEmpty) {
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
                            'إنشاء حساب',
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
                          builder: (context) => ParentSingIn(),
                        ),
                      );
                    },
                    child: Text(
                      "لدي حساب بالفعل!",
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 76, 175, 145),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios_sharp,
          color: Colors.white,
        ),
      ),
    );
  }
}
