import 'package:autisticchildren/child/Face/ReactionSelectionScreen.dart';
import 'package:autisticchildren/child/logic/child_cubit.dart';
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
      "cat-name": "الوجوه",
      "cat-img": "assets/images/smil.png",
      "cat-nave": "Facespage", //still not add it will be an widget ( page  )
    },
    {
      "cat-name": "الصوت",
      "cat-img": "assets/images/voic.jpg",
      "cat-nave": "Viocepage", //still not add it will be an widget ( page  )
    },
    {
      "cat-name": "اختبار",
      "cat-img": "assets/images/quizes.webp",
      "cat-nave": "Quizespage", //still not add it will be an widget ( page  )
    }
  ];
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  // String name = 'with us';
  User? user = FirebaseAuth.instance.currentUser;

  String childName = "  ";
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
              // لقينا الطفل اللي سجل الدخول
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
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome, ",
              style: TextStyle(fontSize: 15.sp, color: Colors.red),
            ),
            SizedBox(
              width: 1.w,
            ),
            Text(
              "$childName",
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 5.h),
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
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: InkWell(
                onTap: () {
                  context.read<ChildAuthCubit>().signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => ChooseTeypeOfLodding()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("تسجيل الخروج"),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.logout_rounded))
                  ],
                ),
              ),
            ),
            Divider(),
            SizedBox(height: 3.h),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImerganceDesplay()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("الطوارئ "),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.tips_and_updates))
                  ],
                ),
              ),
            ),
            Divider()
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        padding: EdgeInsets.all(3.w),
        child: ListView(
          // shrinkWrap: true,
          children: [
            Container(
              height: 50.h,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.w,
                    mainAxisSpacing: 3.h),
                itemBuilder: (BuildContext context, int index) {
                  final data = widget.data[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReactionSelectionScreen()));
                    },
                    child: Card(
                      elevation: 15,
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            child: Image(
                              image: AssetImage(
                                data["cat-img"],
                              ),
                              fit: BoxFit.fill,
                              height: 130,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            data["cat-name"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.sp),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}
