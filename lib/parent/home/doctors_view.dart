import 'package:autisticchildren/login_type.dart';
import 'package:autisticchildren/parent/Logic/parent_login_cubit.dart';
import 'package:autisticchildren/parent/home/Desplay_doctor_detaild.dart';
import 'package:autisticchildren/parent/home/ProfileCardPage.dart';
import 'package:autisticchildren/parent/home/imergance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            .collection('parents')
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
            Text("Welcome, ",
                style: TextStyle(fontSize: 15.sp, color: Colors.red)),
            SizedBox(width: 1.w),
            Text(name),
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
                // borderRadius: BorderRadius.circular(100),
                /*  boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4))
                ],*/
              ),
              child: Image.asset('assets/images/logo1.jpg'),
            ),
            SizedBox(height: 3.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  context.read<ParentLoginCubit>().signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ChooseTeypeOfLodding()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("تسجيل الخروج"), Icon(Icons.logout_rounded)],
                ),
              ),
            ),
            Divider(),
            SizedBox(height: 3.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ImerganceDesplay()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("الطوارئ"), Icon(Icons.tips_and_updates)],
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
                          builder: (context) => ProfileCardPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("الدعم الفنى "),
                  ],
                ),
              ),
            ),
            Divider()
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 3.h),
        children: [
          doctorCard(
              'assets/images/d1.jpg',
              'د. خالد عبد الله',
              'Dental Specialist',
              '4.8 (120 Reviews)',
              'Open at 17.00',
              "شارع الثورة - القاهرة",
              context),
          doctorCard(
              'assets/images/d2.jpg',
              'د. سارة النجار',
              'Dental Specialist',
              '4.8 (120 Reviews)',
              'Open at 17.00',
              "شارع الثورة - القاهرة",
              context),
          /* doctorCard(
              'assets/images/d4.jpg',
              'د. محمد لاشين',
              'Dental Specialist',
              '4.8 (120 Reviews)',
              'Open at 17.00',
              "شارع الثورة - القاهرة",
              context),*/
          doctorCard(
              'assets/images/d3.webp',
              'د. أحمد مرسي',
              'Dental Specialist',
              '4.8 (120 Reviews)',
              'Open at 17.00',
              "شارع الثورة - القاهرة",
              context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

Widget doctorCard(String imageUrl, String name, String position, String reviews,
    String time, String address, BuildContext context) {
  return Center(
    child: Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(20),
      width: 90.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(4, 4))
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(imageUrl,
                      width: 100, height: 100, fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 30.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp)),
                    Text(position,
                        style: TextStyle(
                            color: Color(0xff8696BB), fontSize: 14.sp)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Divider(thickness: 2, color: Color.fromARGB(150, 190, 190, 190)),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Color.fromARGB(255, 253, 161, 138),
                  ),
                  SizedBox(width: 5),
                  Text(reviews,
                      style: TextStyle(fontSize: 12, color: Color(0xff8696BB))),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.history,
                    color: Color.fromARGB(255, 253, 161, 138),
                  ),
                  SizedBox(width: 5),
                  Text(time,
                      style: TextStyle(fontSize: 12, color: Color(0xff8696BB))),
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h),
          SizedBox(
            width: double.infinity,
            height: 5.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 252, 77, 77),
                foregroundColor: Color.fromARGB(255, 253, 161, 138),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorDetailsPage(
                      imageUrl: imageUrl,
                      name: name,
                      address: address,
                    ),
                  ),
                );
              },
              child: Text("احجز الان",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    ),
  );
}
