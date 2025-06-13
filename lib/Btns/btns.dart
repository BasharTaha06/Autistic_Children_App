import 'package:autisticchildren/parent/home/home-feature.dart';
import 'package:autisticchildren/parent/home/parentChildrenScreen.dart';
import 'package:autisticchildren/parent/home/articelsPagescreen.dart';
import 'package:autisticchildren/child/screens/chart.dart';
import 'package:autisticchildren/child/categories/screens/categoreis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:autisticchildren/parent/home/screen/Home.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fancy_bottom_navigation_plus/fancy_bottom_navigation_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Btns extends StatefulWidget {
  const Btns({super.key});

  @override
  State<Btns> createState() => _BtnsState();
}

class _BtnsState extends State<Btns> {
  int currentPage = 0;
  List<Widget> pages = [
    Center(child: CircularProgressIndicator()),
    Center(child: CircularProgressIndicator())
  ];
  User? updatedUser = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    determineUserTypeAndSetPages();
  }

  bool parent = true;
  Future<void> determineUserTypeAndSetPages() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    try {
      // نحاول نلاقيه كطفل
      final parentsSnapshot =
          await FirebaseFirestore.instance.collection("parents").get();

      for (var parentDoc in parentsSnapshot.docs) {
        final childSnapshot = await parentDoc.reference
            .collection("children")
            .where("email", isEqualTo: currentUser?.email)
            .get();

        if (childSnapshot.docs.isNotEmpty) {
          // لو لقي طفل
          setState(() {
            pages = [Categories(), ChildProgressPage()];
            parent = false;
          });
          return;
        }
      }

      // لو ملقناهوش كطفل نعتبره بيرنت
      setState(() {
        pages = [HomeFeature(), ChildrenScreen()];
        parent = true;
      });
    } catch (e) {
      print("❌ خطأ في تحديد نوع المستخدم: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: currentPage,
          children: pages,
        ),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.red,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(
                icon: Icons.view_list, title: parent ? "Children" : 'Prograss'),
          ],
          onTap: (i) {
            setState(() {
              currentPage = i;
            });
          },
        ));
  }
}
