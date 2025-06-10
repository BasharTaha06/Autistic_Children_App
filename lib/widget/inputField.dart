// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sizer/sizer.dart';

// class UserInput extends StatefulWidget {
//   final IconData icon;
//   final TextEditingController data;
//   final bool numbers;
//   final String fieldName;
//   final bool password;
//   bool see = true;
//   UserInput(
//       {required this.icon,
//       required this.data,
//       required this.numbers,
//       required this.fieldName,
//       required this.password});

//   @override
//   State<UserInput> createState() => _UserInputState();
// }

// class _UserInputState extends State<UserInput> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//               color: Colors.white, width: 1.5, style: BorderStyle.solid)),
//       width: 90.w,
//       height: 8.h,
//       alignment: Alignment.center,
//       child: Center(
//         child: TextField(
//           obscureText: widget.password ? widget.see : false,
//           inputFormatters:
//               widget.numbers ? [FilteringTextInputFormatter.digitsOnly] : [],
//           controller: widget.data,
//           autofocus: true,
//           keyboardType: TextInputType.number,
//           decoration: InputDecoration(
//               labelText: widget.fieldName,
//               labelStyle: TextStyle(
//                   color: Colors.black,
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold),
//               prefixIcon: IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   widget.icon,
//                   size: 20.sp,
//                   color: const Color.fromARGB(255, 96, 182, 252),
//                 ),
//               ),
//               suffixIcon: widget.password
/*                   ? IconButton(*/
//                       onPressed: () {
//                         setState(() {
//                           widget.see = !widget.see;
//                         });
//                       },
//                       icon: Icon(
//                         widget.see ? Icons.visibility_off : Icons.visibility,
//                         size: 20.sp,
//                         color: Colors.black,
//                       ),
//                     )
//                   : Text(''),
//               border: InputBorder.none),
//         ),
//       ),
//     );
//end the phone
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class UserInput extends StatefulWidget {
  final IconData icon;
  final TextEditingController data;
  final bool numbers;
  final String fieldName;
  final bool password;
  bool see = true;
  Color fillColor = Colors.white;

  UserInput({
    required this.icon,
    required this.data,
    required this.numbers,
    required this.fieldName,
    required this.password,
    this.fillColor = Colors.white,
  });

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        margin: EdgeInsets.only(top: 2.h, bottom: 2.h),
        decoration: BoxDecoration(
          color: widget.fillColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: widget.fillColor,
            width: 1.5,
            style: BorderStyle.solid,
          ),
        ),
        width: 90.w,
        height: 8.h,
        alignment: Alignment.center,
        child: Center(
          child: TextFormField(
            obscureText: widget.password ? widget.see : false,
            inputFormatters:
                widget.numbers ? [FilteringTextInputFormatter.digitsOnly] : [],
            controller: widget.data,
            keyboardType:
                widget.numbers ? TextInputType.number : TextInputType.text,
            style: TextStyle(fontSize: 18.sp),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'الرجاء إدخال ${widget.fieldName}';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: widget.fieldName,
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
              prefixIcon: Icon(
                widget.icon,
                size: 20.sp,
                color: Color.fromARGB(255, 96, 182, 252),
              ),
              suffixIcon: widget.password
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          widget.see = !widget.see;
                        });
                      },
                      icon: Icon(
                        widget.see ? Icons.visibility_off : Icons.visibility,
                        size: 20.sp,
                        color: Colors.black,
                      ),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
            ),
          ),
        ),
      ),
    );
  }
}
