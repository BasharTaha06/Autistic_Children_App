import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChooseTeypeOfLodding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // خلفية ديكورية بسيطة بدلاً من الصورة الممتدة
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 253, 161, 138),
                    Color.fromARGB(255, 252, 77, 77)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // المحتوى الأساسي
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  Center(
                    child: Container(
                      height: 50.w,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/APP-LOGO.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'مرحباً بك 👋',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'يرجى اختيار نوع الدخول  ',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  SizedBox(height: 6.h),
                  _buildButton(
                    context,
                    title: 'تسجيل ولي أمر',
                    onPressed: () =>
                        Navigator.pushNamed(context, 'Parent-Log-in'),
                    icon: Icons.person_outline,
                    color: Colors.orange.shade700,
                  ),
                  SizedBox(height: 3.h),
                  _buildButton(
                    context,
                    title: 'تسجيل الابن / الابنه',
                    onPressed: () =>
                        Navigator.pushNamed(context, 'Child-Log-in'),
                    icon: Icons.child_care,
                    color: Colors.teal.shade600,
                  ),
                  const Spacer(),
                  _buildButton(
                    context,
                    title: 'زر الطوارئ',
                    onPressed: () => Navigator.pushNamed(context, 'Imergance'),
                    icon: Icons.warning_amber_rounded,
                    color: Colors.red.shade700,
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required String title,
      required VoidCallback onPressed,
      required IconData icon,
      required Color color}) {
    return SizedBox(
      width: double.infinity,
      height: 7.5.h,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 5,
        ),
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: 22.sp),
        label: Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
