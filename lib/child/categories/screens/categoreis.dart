import 'package:autisticchildren/child/Face/ReactionSelectionScreen.dart';
import 'package:autisticchildren/child/Voice/voice_grid_screen.dart';
import 'package:autisticchildren/child/fruits/FruitBasketGameApp.dart';
import 'package:autisticchildren/child/logic/child_cubit.dart';
import 'package:autisticchildren/child/screens/BreathingApp.dart';
import 'package:autisticchildren/child/screens/child-notification.dart';
import 'package:autisticchildren/child/shpaes/GeometricShapesGameApp.dart';
import 'package:autisticchildren/login_type.dart';
import 'package:autisticchildren/parent/home/imergance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class Categories extends StatefulWidget {
  final List<Map<String, dynamic>> data = [
    {
      "cat-name": "لعبة تقليد المشاعر",
      "cat-img": "assets/images/face.jpg",
      "cat-nave": ReactionSelectionScreen(),
    },
    {
      "cat-name": "تمرين التواصل",
      "cat-img": "assets/images/voice.jpg",
      "cat-nave": VoiceGridScreen(),
    },
    {
      "cat-name": "اختبار التنفيس العميق",
      "cat-img": "assets/images/3.jpg",
      "cat-nave": BreathingExerciseScreen(),
    },
    {
      "cat-name": "لعبة صائد الاشكال",
      "cat-img": "assets/images/shapee.jpg",
      "cat-nave": GeometricShapesColorsGameApp(),
    },
    {
      "cat-name": "سلة الفواكة السحرية",
      "cat-img": "assets/images/4.jpg",
      "cat-nave": FruitBasketGameApp(),
    }
  ];

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  User? user = FirebaseAuth.instance.currentUser;

  String childName = "غير معروف";
  String parentEmail = "بلا بريد";

  @override
  void initState() {
    super.initState();
    getChildDataByEmail();
  }

  Future<void> getChildDataByEmail() async {
    if (user != null) {
      try {
        final email = user!.email;

        final parentsSnapshot =
            await FirebaseFirestore.instance.collection('parents').get();

        for (var parentDoc in parentsSnapshot.docs) {
          final childrenSnapshot =
              await parentDoc.reference.collection('children').get();

          for (var childDoc in childrenSnapshot.docs) {
            final data = childDoc.data();
            if (data['email'] == email) {
              setState(() {
                childName = data['name'] ?? "غير معروف";
                parentEmail = parentDoc['email'] ?? "بلا بريد";
              });

              print("اسم الطفل: $childName");
              print("بريد ولي الأمر: $parentEmail");
              return;
            }
          }
        }

        print("الطفل غير موجود في قاعدة البيانات.");
      } catch (e) {
        print('خطأ أثناء جلب بيانات الطفل: $e');
      }
    } else {
      print('لا يوجد مستخدم مسجل الدخول.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationsChildPage()));
            },
            icon: Icon(Icons.notifications),
            color: Colors.red,
          )
        ],
        elevation: 0,
        // backgroundColor: const Color.fromARGB(255, 255, 139, 62),
        centerTitle: true,
        // iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$childName",
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0)),
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              " ,أهلاً ",
              style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromRGBO(249, 249, 249, 1),
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Container(
              alignment: Alignment.center,
              height: 20.h,
              width: 20.h,
              decoration: BoxDecoration(
                color: Color.fromRGBO(249, 249, 249, 1),
                //borderRadius: BorderRadius.circular(100),
                /* boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],*/
              ),
              child: Image.asset('assets/images/logo1.jpg'),
            ),
            SizedBox(height: 3.h),
            ListTile(
              trailing: Icon(Icons.logout_rounded),
              title: Text("تسجيل الخروج"),
              onTap: () {
                context.read<ChildAuthCubit>().signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => ChooseTeypeOfLodding()),
                );
              },
            ),
            Divider(),
            ListTile(
              trailing: Icon(Icons.tips_and_updates),
              title: Text("الطوارئ"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ImerganceDesplay()));
              },
            ),
            Divider(),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: Text(
                  ":اختر فئة للتفاعل معها",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                )),
            SizedBox(height: 3.h),
            Expanded(
              child: GridView.builder(
                itemCount: widget.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.w,
                  mainAxisSpacing: 3.h,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, index) {
                  final data = widget.data[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => data["cat-nave"],
                        ),
                      );
                    },
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                              child: Image.asset(
                                data["cat-img"],
                                fit: BoxFit.fill,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(1.h),
                            child: Text(
                              data["cat-name"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.sp),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
