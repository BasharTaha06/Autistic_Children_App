import 'package:flutter/material.dart';
import 'dart:async'; // لاستخدام Timer

class BreathingExerciseScreen extends StatefulWidget {
  const BreathingExerciseScreen({super.key});

  @override
  State<BreathingExerciseScreen> createState() =>
      _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation; // هنستخدمها للـ scale
  String _instructionText = 'اضغط للبدء';
  bool _isBreathingIn = true;
  bool _isPaused = true;
  int _breathingCycles = 0; // عداد لدورات التنفس
  final int _maxCycles = 5; // أقصى عدد للدورات

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // 4 ثواني لكل دورة (2 شهيق، 2 زفير)
    );

    // الـ Tween هيكون من 0.7 لـ 1.0 عشان حجم البلونة يتغير بشكل واضح
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // حركة سلسة وواقعية
      ),
    )..addListener(() {
        setState(() {
          // بتحديث الحالة، بنعيد بناء الـ UI وبيتم تحديث حجم البلونة
        });
      });

    _controller.addStatusListener((status) {
      if (_isPaused) return; // لو تم الإيقاف المؤقت، مكملش الدورات

      if (status == AnimationStatus.completed) {
        // نهاية الشهيق (البلونة كبرت للآخر)
        _controller.reverse(); // ابدأ الزفير
        setState(() {
          _isBreathingIn = false;
          _instructionText = 'ازفِـــر';
        });
      } else if (status == AnimationStatus.dismissed) {
        // نهاية الزفير (البلونة صغرت للآخر)
        _breathingCycles++; // زود عدد الدورات بعد كل زفير كامل
        if (_breathingCycles < _maxCycles) {
          _controller.forward(); // لو لسه مكملناش الـ 5 مرات، كمل
          setState(() {
            _isBreathingIn = true;
            _instructionText = 'استنشِق';
          });
        } else {
          // لو خلصنا الـ 5 مرات
          _controller.stop(); // وقف الـ animation
          setState(() {
            _isPaused = true;
            _instructionText = 'أحسنت! التمرين انتهى.';
          });
        }
      }
    });
  }

  void _toggleBreathing() {
    if (_breathingCycles >= _maxCycles && !_isPaused) {
      // لو التمرين خلص بالفعل، مفيش حاجة تتعمل بالضغط
      return;
    }

    if (_isPaused) {
      if (_breathingCycles >= _maxCycles) {
        // لو خلص وبتضغط "ابدأ التمرين" تاني، بنعمل إعادة تشغيل
        _resetExercise();
        return;
      }
      _controller.forward(); // ابدأ الـ animation
      setState(() {
        _isPaused = false;
        _instructionText = 'استنشِق';
      });
    } else {
      _controller.stop(); // وقف الـ animation
      setState(() {
        _isPaused = true;
        _instructionText = 'تم الإيقاف المؤقت';
      });
    }
  }

  void _resetExercise() {
    _controller.reset(); // رجّع الـ animation للبداية
    setState(() {
      _breathingCycles = 0; // صفر عداد الدورات
      _isPaused = true;
      _isBreathingIn = true;
      _instructionText = 'اضغط للبدء';
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تمرين التنفس مع البالونة'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0, // نشيل الظل بتاع الـ app bar عشان يبقى شكله أنعم
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _instructionText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 30), // مسافة أقل
            Text(
              'الدورة: $_breathingCycles / $_maxCycles',
              style: const TextStyle(fontSize: 24, color: Colors.grey),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: _toggleBreathing, // بتضغط على البالونة للبدء/الإيقاف
              child: Transform.scale(
                scale: _scaleAnimation
                    .value, // بنستخدم قيمة الـ animation للـ scale
                child: Container(
                  width:
                      250, // حجم ثابت للكونتينر الأساسي عشان الـ scale يشتغل عليه
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: _isBreathingIn
                          ? [
                              Colors.lightBlueAccent.shade100,
                              Colors.blueAccent.shade400,
                            ]
                          : [Colors.lightGreen.shade100, Colors.green.shade400],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 6,
                        blurRadius: 15, // نعومة أكبر للظل
                        offset: const Offset(
                          0,
                          8,
                        ), // إزاحة أكبر عشان البلونة تبان طايرة
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(0.8), // إطار أبيض لامع
                      width: 4,
                    ),
                  ),
                  child: Center(
                    child: _isPaused && _breathingCycles < _maxCycles
                        ? const Icon(
                            Icons.play_arrow,
                            size: 80,
                            color: Colors.white70,
                          ) // أيقونة بلاي لما تكون واقفة
                        : _breathingCycles >= _maxCycles
                            ? const Icon(
                                Icons.check_circle_outline,
                                size: 80,
                                color: Colors.white70,
                              ) // أيقونة صح لما تخلص
                            : const SizedBox.shrink(), // لو شغالة، مفيش أيقونة
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _toggleBreathing,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isPaused && _breathingCycles < _maxCycles
                    ? Colors.blueAccent
                    : _breathingCycles >= _maxCycles
                        ? Colors.deepPurpleAccent // لون مختلف لما يخلص
                        : Colors.redAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
              child: Text(
                _isPaused && _breathingCycles < _maxCycles
                    ? 'ابدأ التمرين'
                    : _breathingCycles >= _maxCycles
                        ? 'أعد البدء' // لما يخلص يبقى الزرار "أعد البدء"
                        : 'إيقاف مؤقت',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
