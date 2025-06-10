import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class DisplayArticel extends StatefulWidget {
  String art_name;
  String art_content;
  String art_source;
  DisplayArticel(
      {required this.art_name,
      required this.art_content,
      required this.art_source});
  @override
  State<DisplayArticel> createState() => _DisplayArticelState();
}

class _DisplayArticelState extends State<DisplayArticel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 5.h),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.art_name,
                  textAlign: TextAlign.end,
                  style: GoogleFonts.reemKufi(
                    textStyle: TextStyle(fontSize: 24, color: Colors.red),
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(height: 3.h),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  // color: const Color.fromARGB(255, 235, 230, 230),
                  child: Text(
                    widget.art_content,
                    textAlign: TextAlign.end,
                    style: GoogleFonts.elMessiri(
                      textStyle: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Divider(
                color: Colors.black,
                indent: 60,
                endIndent: 70,
              ),
              Divider(
                color: Colors.black,
                indent: 80,
                endIndent: 90,
              ),
              Divider(
                color: Colors.black,
                indent: 100,
                endIndent: 110,
              ),
              SizedBox(
                height: 5.h,
              )
            ],
          ),
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
