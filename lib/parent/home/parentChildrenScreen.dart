import 'package:autisticchildren/child/logic/child_cubit.dart';
import 'package:autisticchildren/child/logic/child_state.dart';
import 'package:autisticchildren/parent/Logic/autho_state.dart';
import 'package:autisticchildren/login_type.dart';
import 'package:autisticchildren/parent/home/imergance.dart';
import 'package:autisticchildren/parent/home/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:autisticchildren/parent/Logic/parent_login_cubit.dart';
import 'package:sizer/sizer.dart';

class ChildrenScreen extends StatefulWidget {
  @override
  _ChildrenScreenState createState() => _ChildrenScreenState();
}

class _ChildrenScreenState extends State<ChildrenScreen> {
  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      setState(() {
        context.read<ParentLoginCubit>().getChildrenOfParent(uid);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text("أطفالك"),
        centerTitle: true,
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
      body: BlocListener<ChildAuthCubit, ChildAuthState>(
        listener: (context, state) {
          if (state is ChildSuccessState) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text("تمت إضافة الطفل بنجاح 🎉")));

            final uid = FirebaseAuth.instance.currentUser?.uid;
            if (uid != null) {
              context.read<ParentLoginCubit>().getChildrenOfParent(uid);
            }
          }
        },
        child: BlocBuilder<ParentLoginCubit, ParentAthoState>(
          builder: (context, state) {
            if (state is ParentLodingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ParentChildrenLoadedState) {
              final children = state.children; // ده جاي من Cubit

              if (children.isEmpty) {
                return Center(child: Text('لا يوجد أطفال مسجلين.'));
              }

              return ListView.builder(
                padding: EdgeInsets.all(12),
                itemCount: children.length,
                itemBuilder: (context, index) {
                  final child = children[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        child.name,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("النوع: ${child.gender}"),
                          Text("العمر: ${child.age}"),
                          Text("المستوى: ${child.level}"),
                          Text(
                              "نجاح: ${child.succes}, فشل: ${child.fail}, المحاولات: ${child.TotalTry}"),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is AuthFailure) {
              return Center(child: Text("حدث خطأ: ${state.error}"));
            } else {
              return Center(child: Text("لم يتم تحميل البيانات."));
            }
          },
        ),
      ),
    );
  }
}
