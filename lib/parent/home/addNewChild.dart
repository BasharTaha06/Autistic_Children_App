import 'package:autisticchildren/Btns/btns.dart';
import 'package:autisticchildren/child/logic/child_cubit.dart';
import 'package:autisticchildren/child/logic/child_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../widget/inputField.dart';

class AddNewChild extends StatefulWidget {
  @override
  State<AddNewChild> createState() => _AddNewChildState();
}

class _AddNewChildState extends State<AddNewChild> {
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController parentEmail = TextEditingController();

  String gender = 'ذكر'; // القيمة الافتراضية
  String level = 'الدرجه الاوله'; // القيمة الافتراضية

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/log.jpg',
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
                  /*  Container(
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
                  ),*/
                  SizedBox(height: 150),
                  Text(
                    "إنشاء حساب طفل",
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  UserInput(
                    fieldName: 'اسم الطفل',
                    numbers: false,
                    icon: Icons.person,
                    data: name,
                    password: false,
                  ),
                  UserInput(
                    fieldName: 'العمر',
                    numbers: false,
                    icon: Icons.person,
                    data: age,
                    password: false,
                  ),
                  Text(
                    ': الجنس',
                    style: TextStyle(fontSize: 16.sp),
                  ),

                  /// 🔘 الجنس Radio Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: 'ذكر',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                          Text("ذكر"),
                        ],
                      ),
                      SizedBox(width: 5.w),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'أنثى',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                          Text("أنثى"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    ': درجة شدة التوحد',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: 'الدرجه الاولي',
                            groupValue: level,
                            onChanged: (value) {
                              setState(() {
                                level = value!;
                              });
                            },
                          ),
                          Text('الاولي',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(
                        width: 2.h,
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'الدرجه الثانيه',
                            groupValue: level,
                            onChanged: (value) {
                              setState(() {
                                level = value!;
                              });
                            },
                          ),
                          Text('الثانيه',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(
                        width: 2.h,
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'الدرجه الثالثه',
                            groupValue: level,
                            onChanged: (value) {
                              setState(() {
                                level = value!;
                              });
                            },
                          ),
                          Text('الثالثه',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),

                  UserInput(
                    fieldName: 'البريد الالكتروني',
                    numbers: false,
                    icon: Icons.email,
                    data: email,
                    password: false,
                  ),
                  UserInput(
                    fieldName: 'بريد الاب الالكتروني',
                    numbers: false,
                    icon: Icons.email,
                    data: parentEmail,
                    password: false,
                  ),
                  UserInput(
                    fieldName: 'كلمة السر',
                    numbers: false,
                    icon: Icons.lock,
                    data: pass,
                    password: true,
                  ),
                  SizedBox(height: 3.h),

                  /// 🔁 Bloc Listener & Builder
                  BlocListener<ChildAuthCubit, ChildAuthState>(
                    listener: (context, state) {
                      if (state is ChildSuccessState) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Btns()),
                            (route) => false);
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
                        final isLoading = state is ChildLoadingState;

                        return Column(
                          children: [
                            ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      if (email.text.isNotEmpty &&
                                          pass.text.isNotEmpty &&
                                          name.text.isNotEmpty &&
                                          parentEmail.text.isNotEmpty &&
                                          age.text.isNotEmpty) {
                                        context.read<ChildAuthCubit>().signUp(
                                              email: email.text.trim(),
                                              password: pass.text.trim(),
                                              name: name.text.trim(),
                                              age: age.text.trim(),
                                              gender: gender.trim(),
                                              level: level.trim(),
                                              parentEmail:
                                                  parentEmail.text.trim(),
                                            );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('يرجى ملء جميع الحقول'),
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
                                'إنشاء الحساب',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            /// ⏳ رسالة أثناء التحميل
                            if (isLoading) ...[
                              SizedBox(height: 1.h),
                              Text(
                                'يرجى تأكيد الحساب عبر البريد لإتمام التسجيل',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 3.h),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
