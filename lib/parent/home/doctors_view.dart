import 'package:autisticchildren/login_type.dart';
import 'package:autisticchildren/parent/Logic/parent_login_cubit.dart';
import 'package:autisticchildren/parent/home/Desplay_doctor_detaild.dart';
import 'package:autisticchildren/parent/home/imergance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sizer/sizer.dart';

class DoctorsList extends StatefulWidget {
  @override
  State<DoctorsList> createState() => _DoctorsListPage();
}

class _DoctorsListPage extends State<DoctorsList> {
  String name = '  ';
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  Future<void> getUserName() async {
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('parents') // ← هنا غيرناها لـ parents
            .doc(user!.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            name = userDoc['name'];
          });
        } else {
          print('Document does not exist');
        }
      } catch (e) {
        print('Error fetching name: $e');
      }
    } else {
      print('No user is logged in');
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
              "$name",
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
                  context.read<ParentLoginCubit>().signOut();
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
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 3.h,
            ),
            doctorCard(
                'assets/images/d1.jpg',
                'Dr. Joseph Brostito',
                'Dental Specialist',
                '4,8 (120 Reviews)',
                'Open at 17.00',
                "شارع الثورة - القاهرة",
                context),
            doctorCard(
                'assets/images/d2.jpg',
                'Dr. Joseph Brostito',
                'Dental Specialist',
                '4,8 (120 Reviews)',
                'Open at 17.00',
                "شارع الثورة - القاهرة",
                context),
            doctorCard(
                'assets/images/d4.jpg',
                'Dr. Joseph Brostito',
                'Dental Specialist',
                '4,8 (120 Reviews)',
                'Open at 17.00',
                "شارع الثورة - القاهرة",
                context),
            doctorCard(
                'assets/images/d3.webp',
                'Dr. Joseph Brostito',
                'Dental Specialist',
                '4,8 (120 Reviews)',
                'Open at 17.00',
                "شارع الثورة - القاهرة",
                context),
          ],
        ),
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

Widget doctorCard(var imageUrl, String name, String position, String reviews,
    String time, String address, BuildContext context) {
  double rad = 90.w;
  return Center(
    child: Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      width: 90.w,
      height: 28.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(4, 4),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 16,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset(imageUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter),
                    ),
                  ),
                  Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16.sp),
                      ),
                      Text(
                        position,
                        style: TextStyle(
                            color: Color(0xff8696BB), fontSize: 14.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 5),
            child: Divider(
              thickness: 2,
              color: Color.fromARGB(150, 190, 190, 190),
            ),
          ),
          Row(
            spacing: 40,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon:
                          Icon(Icons.calendar_month, color: Color(0xff8696BB))),
                  Text(
                    reviews,
                    style: TextStyle(fontSize: 12, color: Color(0xff8696BB)),
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.history, color: Color(0xff8696BB))),
                  Text(
                    time,
                    style: TextStyle(fontSize: 12, color: Color(0xff8696BB)),
                  )
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 90.w,
            height: 5.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(rad / 2),
                border: Border.all(style: BorderStyle.none),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(5, 6),
                  ),
                ]),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(248, 150, 245, 213),
                foregroundColor: Color.fromARGB(255, 72, 254, 224),
                // shadowColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoctorDetailsPage(
                              imageUrl: imageUrl,
                              name: name,
                              address: address,
                            )));
              },
              child: Text(
                "احجز الان",
                style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
