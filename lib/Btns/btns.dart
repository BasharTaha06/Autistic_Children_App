import 'package:autisticchildren/Btns/test1.dart';
import 'package:autisticchildren/Btns/test2.dart';
import 'package:autisticchildren/parent/categories/screens/categoreis.dart';
import 'package:autisticchildren/parent/home/screen/Home.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fancy_bottom_navigation_plus/fancy_bottom_navigation_plus.dart';
import 'package:flutter/material.dart';

class Btns extends StatefulWidget {
  const Btns({super.key});

  @override
  State<Btns> createState() => _BtnsState();
}

class _BtnsState extends State<Btns> {
  int currentPage = 0;
  final List<Widget> pages = [VideoScreen(), Categories(), Test2()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: currentPage,
          children: pages,
        ),
        bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.view_list, title: 'Categories'),
            TabItem(icon: Icons.add, title: 'Add'),
          ],
          onTap: (i) {
            setState(() {
              currentPage = i;
            });
          },
        ));
  }
}
