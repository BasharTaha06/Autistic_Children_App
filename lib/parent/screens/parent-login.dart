import 'package:autisticchildren/Btns/btns.dart';
import 'package:autisticchildren/TestScreen.dart';
import 'package:autisticchildren/login_type.dart';
import 'package:autisticchildren/parent/screens/parent-sing-up.dart';
import 'package:autisticchildren/parent/Logic/autho_state.dart';
import 'package:autisticchildren/parent/Logic/parent_login_cubit.dart';
import 'package:autisticchildren/parent/screens/resetPass.dart';
import 'package:autisticchildren/parent/auth/screens/singin.dart';
import 'package:autisticchildren/parent/auth/screens/singup.dart';
import 'package:autisticchildren/widget/inputField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
//   String childName = "محمد";
//   String parentEmail = "amam@123";
//   @override
//   void initState() {
//     super.initState();
//     // _initCamera();
//     fetchChildInfo();
//   }

// // to get the parent email and the child name to store the resoult
//   Future<void> fetchChildInfo() async {
//     final currentUser = FirebaseAuth.instance.currentUser;

//     if (currentUser == null) {
//       print('No user is currently logged in.');
//       return;
//     }

//     final FirebaseFirestore firestore = FirebaseFirestore.instance;

//     try {
//       // جلب كل أولياء الأمور
//       QuerySnapshot parentSnapshot =
//           await firestore.collection('parents').get();

//       for (var parentDoc in parentSnapshot.docs) {
//         String parentId = parentDoc.id;

//         // جلب كل الأطفال لهذا الأب
//         QuerySnapshot childrenSnapshot = await firestore
//             .collection('parents')
//             .doc(parentId)
//             .collection('children')
//             .get();

//         for (var childDoc in childrenSnapshot.docs) {
//           Map<String, dynamic> childData =
//               childDoc.data() as Map<String, dynamic>;

//           if (childData['email'] == currentUser.email) {
//             // خزّن البيانات في المتغيرات العامة
//             childName = childData['name'] ?? 'غير معروف';
//             parentEmail = childData['Parentemail'] ?? 'غير معروف';

//             print('Child Name: $childName');
//             print('Parent Email: $parentEmail');

//             return;
//           }
//         }
//       }

//       print('Child not found in Firestore.');
//     } catch (e) {
//       print('Error fetching child info: $e');
//     }
//   }

//   void sendStartNotification(
//       {required String parentEmail,
//       required String childName,
//       required String message}) async {
//     final firestore = FirebaseFirestore.instance;

//     // نجيب ولي الأمر من الإيميل
//     var result = await firestore
//         .collection('parents')
//         .where('email', isEqualTo: parentEmail)
//         .get();

//     if (result.docs.isEmpty) return;

//     // جِبنا الـ ID بتاع ولي الأمر
//     String parentId = result.docs.first.id;

//     // الوقت والتاريخ الحالي
//     DateTime now = DateTime.now();
//     String date =
//         "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
//     String time =
//         "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

//     // نخزن الإشعار
//     await firestore
//         .collection('parents')
//         .doc(parentId)
//         .collection('notifications')
//         .add({
//       'message': '${message}',
//       'type': 'start',
//       'date': date,
//       'time': time,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//   }
  void sendStartNotification({required String message}) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot parentSnapshot =
          await firestore.collection('parents').get();

      for (var parentDoc in parentSnapshot.docs) {
        String parentId = parentDoc.id;

        QuerySnapshot childrenSnapshot = await firestore
            .collection('parents')
            .doc(parentId)
            .collection('children')
            .get();

        for (var childDoc in childrenSnapshot.docs) {
          final data = childDoc.data() as Map<String, dynamic>;
          if (data['email'] == currentUser.email) {
            final childName = data['name'] ?? 'طفلك';
            final parentEmail = data['Parentemail'] ?? '';

            DateTime now = DateTime.now();
            String date =
                "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
            String time =
                "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

            await firestore
                .collection('parents')
                .doc(parentId)
                .collection('notifications')
                .add({
              'message': 'مرحبا بعودتك ${childName} ⭐',
              'type': 'start',
              'date': date,
              'time': time,
              'timestamp': FieldValue.serverTimestamp(),
            });

            print("✅ Notification sent successfully");
            return;
          }
        }
      }

      print("❌ Child not found");
    } catch (e) {
      print("❌ Error sending notification: $e");
    }
  }

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
                        Navigator.pushReplacement(
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
                              sendStartNotification(
                                  message: "مرحبا بعودتك مره اخره ⭐");
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
