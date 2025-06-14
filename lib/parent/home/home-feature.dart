import 'package:autisticchildren/login_type.dart';
import 'package:autisticchildren/parent/Logic/parent_login_cubit.dart';
import 'package:autisticchildren/parent/home/ProfileCardPage.dart';
import 'package:autisticchildren/parent/home/addNewChild.dart';
import 'package:autisticchildren/parent/home/articelsPagescreen.dart';
import 'package:autisticchildren/parent/home/doctors_view.dart';
import 'package:autisticchildren/parent/home/imergance.dart';
import 'package:autisticchildren/parent/home/notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeFeature extends StatefulWidget {
  const HomeFeature({super.key});

  @override
  State<HomeFeature> createState() => _HomeFeatureState();
}

class _HomeFeatureState extends State<HomeFeature> {
  String name = 'with us';
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

//function  to open the whats up group
  void openWhatsAppGroup() async {
    final Uri url =
        Uri.parse('https://chat.whatsapp.com/KnbDs01KCHz0G3X2K5nmRu');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch WhatsApp group link");
    }
  }

  void opentleyGroup() async {
    final Uri url = Uri.parse('https://t.me/+dlRY2a06WOQ1NTQ0');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch WhatsApp group link");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 1.w,
            ),
            Text(
              "$name",
            ),
            Text(
              " ,أهلاً ",
              style: TextStyle(fontSize: 15.sp, color: Colors.red),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()));
            },
            icon: Icon(Icons.notifications),
            color: Colors.red,
          )
        ],
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
                color: Colors.white,
                //    borderRadius: BorderRadius.circular(100),
                /*  boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],*/
              ),
              child: Image.asset(
                'assets/images/logo1.jpg',
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
                        onPressed: () {}, icon: Icon(Icons.tips_and_updates)),
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
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 2.h,
            ),
            //start the articels
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Articales()));
              },
              borderRadius: BorderRadius.circular(16),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadowColor: Colors.black54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + Arrow Row
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "مقالات توعوية",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    // Image Section
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                      child: Image.asset(
                        'assets/images/articals.jpg', // غيّرها إلى رابط الصورة اللي تحب
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //end the articales
            SizedBox(
              height: 2.h,
            ),

            Row(
              children: [
                //start the group
                Expanded(
                  child: InkWell(
                    onTap: openWhatsAppGroup,
                    borderRadius: BorderRadius.circular(16),
                    child: Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadowColor: Colors.black54,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title + Arrow Row
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "تواصل معنا",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          // Image Section
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(16),
                            ),
                            child: Image.asset(
                              'assets/images/a.1.jpg', // غيّرها إلى رابط الصورة اللي تحب
                              width: double.infinity,
                              height: 10.h,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //end the group
                //start the ad child
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewChild()));
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadowColor: Colors.black54,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title + Arrow Row
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "اضف طفل",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          // Image Section
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(16),
                            ),
                            child: Image.asset(
                              'assets/images/AddChild.png',
                              width: double.infinity,
                              height: 10.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //end the add child
              ],
            ),
            SizedBox(height: 2.h),
            //start the doctors
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DoctorsList()));
              },
              borderRadius: BorderRadius.circular(16),
              child: Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadowColor: Colors.black54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + Arrow Row
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "حجز جلسات استشارية",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    // Image Section
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                      child: Image.asset(
                        'assets/images/doctors.jpg', // غيّرها إلى رابط الصورة اللي تحب
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: InkWell(
                onTap: opentleyGroup,
                borderRadius: BorderRadius.circular(16),
                child: Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  shadowColor: Colors.black54,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + Arrow Row
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "منتدى مغلق للاهل لتبادل الخبرات والتعبير عن تحدياتهم",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      // Image Section
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(16),
                        ),
                        child: Image.asset(
                          'assets/images/m.3.jpg', // غيّرها إلى رابط الصورة اللي تحب
                          width: double.infinity,
                          height: 170,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //end the articales
          ],
        ),
      ),
    );
  }
}
